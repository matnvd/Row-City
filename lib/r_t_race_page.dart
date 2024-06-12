import 'package:flutter/material.dart';
import 'const.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;

import 'controller.dart';
import 'r_t_race_page.dart';

class RTRacePage extends StatefulWidget {
  final String link;
  final String regatta;

  const RTRacePage(
    this.link,
    this.regatta, {
    super.key,
  });

  @override
  State<RTRacePage> createState() => _RTRacePageState();
}

class _RTRacePageState extends State<RTRacePage> {
  DataController dataController = Get.put(DataController());
  late String imageURL;

  @override
  void initState() {
    getData();
    super.initState();
  }

  // controller.dart citation
  getData() async {
    DataController dataController = Get.put(DataController());
    dataController.clearData();
    var url = Uri.parse(
        "http://rowtown.org/results/${widget.link}"); // regatta central requires a f*cking api key
    var response = await http.get(url);
    dom.Document document = parser.parse(response.body);

    // change to go from 0 to 1 when u want to add some of the dropdowns from the first tbody
    var element = document.querySelectorAll('div>img')[0];
    setState(() {
      imageURL = element.attributes['src'].toString().trim();
      imageURL = "http://rowtown.org/results/$imageURL";
    });
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
                child: Image.network(
                    "https://rowtown.org/results/visualresultssvg?regattaName=Stotesbury+Cup+Regatta&regattaDate=2024-05-17&eventNumber=1&stageType=time-trial&raceNumber=1a"),
              )),
            ));
  }
}
