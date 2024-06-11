import 'package:flutter/material.dart';
import 'const.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;

import 'controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DataController dataController = Get.put(DataController());

  @override
  void initState() {
    getData();
    super.initState();
  }

  // controller.dart citation
  getData() async {
    DataController dataController = Get.put(DataController());
    // var url = Uri.parse(
    //     'https://en.wikipedia.org/wiki/List_of_universities_in_Pakistan');
    var url = Uri.parse(
        'https://regatta.time-team.nl/usrowing-youth-national/2024/results/races.php'); // couldn't get rowtown to work
    var response = await http.get(url);
    dom.Document document = parser.parse(response.body);

    for (int i = 0; i <= 0; i++) {
      var element = document.querySelectorAll('table>tbody')[i];
      var data = element.querySelectorAll('tr[class="even"], tr[class="odd"]');
      var heading = document.querySelectorAll('h3')[i];
      var heading2 = document.querySelectorAll('h4')[i];
      dataController.addHeader(heading.text.toString().trim());
      dataController.addHeader2(heading2.text.toString().trim());
      for (int j = 0; j < data.length; j++) {
        dataController.addTime(data[j].children[0].text.toString().trim());
        dataController.addNumber(data[j].children[1].text.toString().trim());
        dataController.addRace(data[j].children[2].text.toString().trim());
        dataController.addStatus(data[j].children[3].text.toString().trim());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DataController>(
        builder: (_) => Scaffold(
              appBar: AppBar(
                backgroundColor: maroon,
                automaticallyImplyLeading: false,
                title: const Text("Row City",
                    style: TextStyle(color: Colors.white)),
              ),
              body: SafeArea(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: dataController.time.length + 2,
                      itemBuilder: (BuildContext context, int index) {
                        // row headers
                        if (index == 0) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Text(
                                "${dataController.header[0]}, ${dataController.header2[0]}",
                                style: const TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                )),
                          );
                        }

                        if (index == 1) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 80,
                                  child: Text("Time",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                                // Spacer(flex: 1),
                                SizedBox(
                                  width: 80,
                                  child: Text("No.",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ),
                                // Spacer(flex: 10),
                                Text("Race",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                Spacer(),
                                Text("Status",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          );
                        }

                        index -= 2;
                        return Card(
                            child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 80,
                                      child: Text(
                                          dataController.time[index]
                                              .toString()
                                              .trim(),
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                          )),
                                    ),
                                    // Spacer(flex: 1),
                                    SizedBox(
                                      width: 80,
                                      child: Text(
                                          dataController.number[index]
                                              .toString()
                                              .trim(),
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                          )),
                                    ),
                                    // Spacer(flex: 10),
                                    Text(
                                        dataController.race[index]
                                            .toString()
                                            .trim(),
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                    const Spacer(),
                                    Text(
                                        dataController.status[index]
                                            .toString()
                                            .trim(),
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                )));
                      })),
            ));
  }
}
