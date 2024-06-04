import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

// citation:https://github.com/asaddigital2809/datascrap/tree/master
class DataController extends GetxController {
  List<String> name = [];
  List<String> location = [];

  void addName(String text) {
    name.add(text);
    update();
  }

  void addLocation(String text) {
    location.add(text);
    update();
  }
}
