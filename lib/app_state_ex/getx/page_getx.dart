import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:ngoc_hung66131218_flutter_app/app_state_ex/getx/controller_counter.dart';

class GetxApp extends StatelessWidget {
  const GetxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: BindingsController(),
      home: PageGetxCounter()
    );
  }
}

class PageGetxCounter extends StatelessWidget {
  PageGetxCounter({super.key});
  //final ControllerCounter controller = ControllerCounter.instance;
  //final ControllerCounter2 controller2 = ControllerCounter2.instance;
  @override
  Widget build(BuildContext context) {
    final ControllerCounter controller = ControllerCounter.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text("Getx Counter"),
        leading: Icon(Icons.arrow_back),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, //đưa xuống giữa
          children: [
            Obx(() => Text("Obx: ${controller.counter}"),),
            GetX<ControllerCounter>(
              init: controller,
              tag: "02",
              builder: (controller) => Text("Obx: ${controller.counter}")
            ),
            GetBuilder<ControllerCounter>(
                init: controller,
                id: "01",
                builder: (controller) => Text("GetBuilder: ${controller.counter}")
            ),
            GetBuilder<ControllerCounter2>(
                init: Get.put(ControllerCounter2()),
                id: "02",
                builder: (controller) => Text("SumBuilder: ${controller.sum}")
            ),
            ElevatedButton(
                onPressed: () {
                  controller.increment();
                  controller.increment();
                },
                child: Text("Increment")
            ),
            ElevatedButton(
                onPressed: () {
                  controller.increment();
                },
                child: Text("Increment GetBuilder")
            )
          ],
        ),
      ),

    );
  }
}
