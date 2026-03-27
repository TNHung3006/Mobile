import 'package:get/get.dart';

class ControllerCounter extends GetxController{
  final counter = 0.obs;
  static ControllerCounter get instance => Get.find<ControllerCounter>();
  void increment(){
    counter.value++;
  }
}

class ControllerCounter2 extends GetxController{
  int counter = 0;
  int sum = 0;
static ControllerCounter2 get instance => Get.find<ControllerCounter2>();
  void increment(){
    counter++;
    sum = counter + 5;
    update(["01", "02"]);
  }
}

class BindingsController extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut(() => ControllerCounter(),);
    Get.lazyPut(() => ControllerCounter2(),);
  }
}