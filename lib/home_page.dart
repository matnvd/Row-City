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
    var url = Uri.parse(
        'https://en.wikipedia.org/wiki/List_of_universities_in_Pakistan');
    var response = await http.get(url);
    dom.Document document = parser.parse(response.body);

    for (int i = 0; i <= 3; i++) {
      var element = document.querySelectorAll('table>tbody')[i];
      var data = element.querySelectorAll('tr');
      for (int i = 1; i < data.length; i++) {
        dataController.addName(data[i].children[0].text.toString().trim());
        dataController.addLocation(data[i].children[1].text.toString().trim());
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
                      itemCount: dataController.name.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                            child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                            dataController.name[index]
                                                .toString()
                                                .trim(),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold))),
                                    Text(
                                        dataController.location[index]
                                            .toString()
                                            .trim(),
                                        style: const TextStyle(
                                            fontSize: 15, color: lightMaroon))
                                  ],
                                )));
                      })),
            ));
  }
}
