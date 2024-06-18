import 'package:get/get_state_manager/src/simple/get_controllers.dart';

// credits: https://github.com/asaddigital2809/datascrap/tree/master

class DataController extends GetxController {
  // row_town page
  List<String> regatta = [];
  List<String> date = [];
  List<String> days = [];
  List<String> events = [];
  List<String> races = [];
  List<String> male = [];
  List<String> female = [];
  List<String> total = [];
  List<String> teams = [];
  List<String> link = [];

  // row_town -> regatta page
  List<String> number = [];
  List<String> raceDate = [];
  List<String> time = [];
  List<String> race = [];
  List<String> status = [];
  List<String> results = [];
  List<String> eventLink = [];

  // time-team
  List<String> timeTT = [];
  List<String> numberTT = [];
  List<String> raceTT = [];
  List<String> statusTT = [];
  List<String> header = [];
  List<String> header2 = [];

  void addRegatta(String text) {
    regatta.add(text);
    update();
  }

  void addDate(String text) {
    date.add(text);
    update();
  }

  void addTime(String text) {
    time.add(text);
    update();
  }

  void addDays(String text) {
    days.add(text);
    update();
  }

  void addEvents(String text) {
    events.add(text);
    update();
  }

  void addRaces(String text) {
    races.add(text);
    update();
  }

  void addMale(String text) {
    male.add(text);
    update();
  }

  void addFemale(String text) {
    female.add(text);
    update();
  }

  void addTotal(String text) {
    total.add(text);
    update();
  }

  void addTeams(String text) {
    teams.add(text);
    update();
  }

  void addNumber(String text) {
    number.add(text);
    update();
  }

  void addRace(String text) {
    race.add(text);
    update();
  }

  void addStatus(String text) {
    status.add(text);
    update();
  }

  void addLink(String text) {
    link.add(text);
    update();
  }

  void addResults(String text) {
    results.add(text);
    update();
  }

  void addRaceDate(String text) {
    raceDate.add(text);
    update();
  }

  void addEventLink(String text) {
    eventLink.add(text);
    update();
  }

  void addHeader(String text) {
    header.add(text);
    update();
  }

  void addHeader2(String text) {
    header2.add(text);
    update();
  }

  void addTimeTT(String text) {
    timeTT.add(text);
    update();
  }

  void addNumberTT(String text) {
    numberTT.add(text);
    update();
  }

  void addRaceTT(String text) {
    raceTT.add(text);
    update();
  }

  void addStatusTT(String text) {
    statusTT.add(text);
    update();
  }

  void clearData() {
    // row_town page
    regatta = [];
    date = [];
    days = [];
    events = [];
    races = [];
    male = [];
    female = [];
    total = [];
    teams = [];
    link = [];

    // row_town -> regatta page
    number = [];
    raceDate = [];
    time = [];
    race = [];
    status = [];
    results = [];
    eventLink = [];

    //time-team
    header = [];
    header2 = [];
    timeTT = [];
    numberTT = [];
    raceTT = [];
    statusTT = [];
  }
}
