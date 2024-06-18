import 'package:flutter/material.dart';
import 'const.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;

import 'controller.dart';
import 'main.dart';
import 'r_t_regatta_page.dart';

class RowTownPage extends StatefulWidget {
  const RowTownPage({
    super.key,
  });

  @override
  State<RowTownPage> createState() => _RowTownPageState();
}

class _RowTownPageState extends State<RowTownPage> with RouteAware {
  DataController dataController = Get.put(DataController());

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ObserverUtils.routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  // LOADS DATA AND PREVENTS RANGE ERROR!!!
  void didPopNext() {
    debugPrint("didPopNext ${runtimeType}");
    getData();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  // controller.dart citation
  getData() async {
    DataController dataController = Get.put(DataController());
    dataController.clearData();
    var url = Uri.parse(
        'http://rowtown.org/results/'); // regatta central requires a f*cking api key
    var response = await http.get(url);
    dom.Document document = parser.parse(response.body);

    // for adding links: https://itnext.io/write-your-first-web-scraper-in-dart-243c7bb4d05

    for (int i = 0; i <= 1; i++) {
      var element = document.querySelectorAll('table>tbody')[i];
      var data = element.querySelectorAll('tr');
      var links = element.querySelectorAll('td>a');

      // for the headers
      if (i == 0) {
        dataController.addRegatta(data[0].children[0].text.toString().trim());
        dataController.addDate(data[0].children[1].text.toString().trim());
        dataController.addDays(data[0].children[2].text.toString().trim());
        dataController.addEvents(data[0].children[3].text.toString().trim());
        dataController.addRaces(data[0].children[4].text.toString().trim());
        dataController.addMale(data[1].children[0].text.toString().trim());
        dataController.addFemale(data[1].children[1].text.toString().trim());
        dataController.addTotal(data[1].children[2].text.toString().trim());
        dataController.addTeams(data[0].children[5].text.toString().trim());
        dataController.addLink("Place holder link header");
      } else {
        for (int j = 0; j < data.length; j++) {
          dataController.addRegatta(data[j].children[0].text.toString().trim());
          dataController.addDate(data[j].children[1].text.toString().trim());
          dataController.addDays(data[j].children[2].text.toString().trim());
          dataController.addEvents(data[j].children[3].text.toString().trim());
          dataController.addRaces(data[j].children[4].text.toString().trim());
          dataController.addMale(data[j].children[5].text.toString().trim());
          dataController.addFemale(data[j].children[6].text.toString().trim());
          dataController.addTotal(data[j].children[7].text.toString().trim());
          dataController.addTeams(data[j].children[8].text.toString().trim());
          dataController.addLink(links[j].attributes['href'].toString().trim());
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DataController>(
        builder: (_) => Scaffold(
              appBar: AppBar(
                backgroundColor: maroon,
                // automaticallyImplyLeading: false,
                title: const Text("Row Town",
                    style: TextStyle(color: Colors.white)),
              ),
              body: SafeArea(
                  child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  height: 1000,
                  width: 860,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: dataController.regatta.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                            child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 300,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (context, animation,
                                                      secondaryAnimation) =>
                                                  RTRegattaPage(
                                                      dataController
                                                          .link[index],
                                                      dataController
                                                          .regatta[index],
                                                      dataController
                                                          .days[index]),
                                              transitionsBuilder: (context,
                                                  animation,
                                                  secondaryAnimation,
                                                  child) {
                                                return FadeTransition(
                                                  opacity: animation,
                                                  child: child,
                                                );
                                              },
                                            ),
                                          );
                                        },
                                        child: Text(
                                          dataController.regatta[index]
                                              .toString()
                                              .trim(),
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: index == 0
                                                  ? Colors.black
                                                  : hyperLinkColor,
                                              fontWeight: index == 0
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                              decoration: index == 0
                                                  ? TextDecoration.none
                                                  : TextDecoration.underline),
                                        ),
                                      ),
                                    ),
                                    // const Spacer(flex: 1),
                                    SizedBox(
                                      width: 110,
                                      child: Text(
                                          textAlign: TextAlign.center,
                                          dataController.date.isNotEmpty
                                              ? dataController.date[
                                                      index] //get error for some reason? once i move to regatta page?, get 18 errors for each regatta pg, if i remove this part i get error for nxt box
                                                  .toString()
                                                  .trim()
                                              : "Loading...",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.black,
                                              fontWeight: index == 0
                                                  ? FontWeight.bold
                                                  : FontWeight.normal)),
                                    ),
                                    SizedBox(
                                      width: 60,
                                      child: Text(
                                          textAlign: TextAlign.center,
                                          dataController.days.isNotEmpty
                                              ? dataController.days[
                                                      index] //get error for some reason? once i move to regatta page?, get 18 errors for each regatta pg, if i remove this part i get error for nxt box
                                                  .toString()
                                                  .trim()
                                              : "Loading...",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.black,
                                              fontWeight: index == 0
                                                  ? FontWeight.bold
                                                  : FontWeight.normal)),
                                    ),
                                    SizedBox(
                                      width: 60,
                                      child: Text(
                                          textAlign: TextAlign.center,
                                          dataController.events.isNotEmpty
                                              ? dataController.events[index]
                                                  .toString()
                                                  .trim()
                                              : "Loading...",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.black,
                                              fontWeight: index == 0
                                                  ? FontWeight.bold
                                                  : FontWeight.normal)),
                                    ),
                                    SizedBox(
                                      width: 60,
                                      child: Text(
                                          textAlign: TextAlign.center,
                                          dataController.races.isNotEmpty
                                              ? dataController.races[index]
                                                  .toString()
                                                  .trim()
                                              : "Loading...",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.black,
                                              fontWeight: index == 0
                                                  ? FontWeight.bold
                                                  : FontWeight.normal)),
                                    ),
                                    SizedBox(
                                      width: 60,
                                      child: Text(
                                          textAlign: TextAlign.center,
                                          dataController.male.isNotEmpty
                                              ? dataController.male[index]
                                                  .toString()
                                                  .trim()
                                              : "Loading...",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.black,
                                              fontWeight: index == 0
                                                  ? FontWeight.bold
                                                  : FontWeight.normal)),
                                    ),
                                    SizedBox(
                                      width: 60,
                                      child: Text(
                                          textAlign: TextAlign.center,
                                          dataController.female.isNotEmpty
                                              ? dataController.female[index]
                                                  .toString()
                                                  .trim()
                                              : "Loading...",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.black,
                                              fontWeight: index == 0
                                                  ? FontWeight.bold
                                                  : FontWeight.normal)),
                                    ),
                                    SizedBox(
                                      width: 60,
                                      child: Text(
                                          textAlign: TextAlign.center,
                                          dataController.total.isNotEmpty
                                              ? dataController.total[index]
                                                  .toString()
                                                  .trim()
                                              : "Loading...",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.black,
                                              fontWeight: index == 0
                                                  ? FontWeight.bold
                                                  : FontWeight.normal)),
                                    ),
                                    SizedBox(
                                      width: 60,
                                      child: Text(
                                          textAlign: TextAlign.center,
                                          dataController.teams.isNotEmpty
                                              ? dataController.teams[index]
                                                  .toString()
                                                  .trim()
                                              : "Loading...",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.black,
                                              fontWeight: index == 0
                                                  ? FontWeight.bold
                                                  : FontWeight.normal)),
                                    ),
                                  ],
                                )));
                      }),
                ),
              )),
            ));
  }
}
