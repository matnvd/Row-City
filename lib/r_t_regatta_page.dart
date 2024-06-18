import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'const.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;

import 'controller.dart';
import 'main.dart';
import 'r_t_race_page.dart';

class RTRegattaPage extends StatefulWidget {
  final String link;
  final String regatta;
  final String numDays;

  const RTRegattaPage(
    this.link,
    this.regatta,
    this.numDays, {
    super.key,
  });

  @override
  State<RTRegattaPage> createState() => _RTRegattaPageState();
}

class _RTRegattaPageState extends State<RTRegattaPage> with RouteAware {
  DataController dataController = Get.put(DataController());

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ObserverUtils.routeObserver.subscribe(this, ModalRoute.of(context)!);
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
        "http://rowtown.org/results/${widget.link}"); // regatta central requires a f*cking api key, show email
    var response = await http.get(url);
    dom.Document document = parser.parse(response.body);

    // change to go from 0 to 1 when u want to add some of the dropdowns from the first tbody
    for (int i = 0; i <= 1; i++) {
      var element = document.querySelectorAll('table')[i];
      var data = element.querySelectorAll('tbody>tr');
      var headers = document.querySelectorAll('thead>tr');
      var eventLinks = element.querySelectorAll('td>a');

      // for the headers
      if (i == 0) {
        dataController.addNumber(headers[0].children[1].text.toString().trim());
        if (int.parse(widget.numDays) > 1) {
          dataController
              .addRaceDate(headers[0].children[2].text.toString().trim());
        }
        dataController.addTime(headers[0].children[3].text.toString().trim());
        dataController.addRace(headers[0].children[4].text.toString().trim());
        dataController.addStatus(headers[0].children[5].text.toString().trim());
        dataController
            .addResults(headers[0].children[6].text.toString().trim());
        dataController.addEventLink("Place holder link header");
      } else {
        for (int j = 0; j < data.length; j++) {
          dataController.addNumber(data[j].children[1].text.toString().trim());
          if (int.parse(widget.numDays) > 1) {
            dataController
                .addRaceDate(data[j].children[2].text.toString().trim());
          }
          dataController.addTime(data[j].children[3].text.toString().trim());
          dataController.addRace(data[j].children[4].text.toString().trim());
          dataController.addStatus(data[j].children[5].text.toString().trim());
          dataController.addResults(data[j].children[6].text.toString().trim());
          dataController.addEventLink(
              eventLinks[j].attributes['href'].toString().trim()); //
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
                title: Text(widget.regatta,
                    style: const TextStyle(color: Colors.white)),
              ),
              body: SafeArea(
                  child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  height: 1000,
                  width: 800,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: dataController.race.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                            child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 40,
                                      child: Text(
                                        dataController.number[index]
                                            .toString()
                                            .trim(),
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.black,
                                          fontWeight: index == 0
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 130,
                                      child: Text(
                                          textAlign: TextAlign.center,
                                          dataController.raceDate[index]
                                              .toString()
                                              .trim(),
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.black,
                                              fontWeight: index == 0
                                                  ? FontWeight.bold
                                                  : FontWeight.normal)),
                                    ),
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                          textAlign: TextAlign.center,
                                          dataController.time[index]
                                              .toString()
                                              .trim(),
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.black,
                                              fontWeight: index == 0
                                                  ? FontWeight.bold
                                                  : FontWeight.normal)),
                                    ),
                                    SizedBox(
                                      width: 300,
                                      child: Text(
                                          textAlign: TextAlign.center,
                                          dataController.race[index]
                                              .toString()
                                              .trim(),
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.black,
                                              fontWeight: index == 0
                                                  ? FontWeight.bold
                                                  : FontWeight.normal)),
                                    ),
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                          textAlign: TextAlign.center,
                                          dataController.status[index]
                                              .toString()
                                              .trim(),
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.black,
                                              fontWeight: index == 0
                                                  ? FontWeight.bold
                                                  : FontWeight.normal)),
                                    ),
                                    SizedBox(
                                      width: 100,
                                      child: InkWell(
                                        onTap: () {
                                          _launchURL(
                                              "http://rowtown.org/results/${dataController.eventLink[index]}");
                                          /*Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (context, animation,
                                                      secondaryAnimation) =>
                                                  RTRacePage(
                                                      dataController
                                                          .link[index],
                                                      dataController
                                                          .race[index]),
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
                                          );*/
                                        },
                                        child: Text(
                                            textAlign: TextAlign.center,
                                            dataController.results[index]
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
                                                    : TextDecoration
                                                        .underline)),
                                      ),
                                    ),
                                  ],
                                )));
                      }),
                ),
              )),
            ));
  }

  _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
