import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

// citation:https://github.com/asaddigital2809/datascrap/tree/master
class DataController extends GetxController {
  List<String> header = [];
  List<String> header2 = [];
  List<String> time = [];
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
}
