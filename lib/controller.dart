import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

// citation:https://github.com/asaddigital2809/datascrap/tree/master
class DataController extends GetxController {
  List<String> header = [];
  List<String> header2 = [];
  List<String> time = [];
  List<String> date = [];
  List<String> days = [];
  List<String> events = [];
  List<String> races = [];
  List<String> male = [];
  List<String> female = [];
  List<String> total = [];
  List<String> teams = [];
  List<String> number = [];
  List<String> race = [];
  List<String> status = [];

  void addHeader(String text) {
    header.add(text);
    update();
  }

  void addHeader2(String text) {
    header2.add(text);
    update();
  }

  void addTime(String text) {
    time.add(text);
    update();
  }

  void addDate(String text) {
    date.add(text);
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

  void clearData() {
    header = [];
    header2 = [];
    time = [];
    date = [];
    days = [];
    events = [];
    races = [];
    male = [];
    female = [];
    total = [];
    teams = [];
    number = [];
    race = [];
    status = [];
  }
}
