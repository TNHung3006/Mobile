import 'package:get/get.dart';

class UnitController extends GetxController {
  var cmValue = "".obs;
  var inchValue = "".obs;
  var history = <String>[].obs;

  void convertCmToInch() {
    if (cmValue.value.isNotEmpty) {
      double cm = double.parse(cmValue.value);
      double inch = cm / 2.54;
      String result = "$cm cm = ${inch.toStringAsFixed(3)} inches";
      history.insert(0, result);
    }
  }

  void convertInchToCm() {
    if (inchValue.value.isNotEmpty) {
      double inch = double.parse(inchValue.value);
      double cm = inch * 2.54;
      String result = "$inch inches = ${cm.toStringAsFixed(2)} cm";
      history.insert(0, result);
    }
  }
}