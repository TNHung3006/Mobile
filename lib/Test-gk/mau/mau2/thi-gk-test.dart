import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'thi-gk-test.dart';
import 'controller.dart';

class PageGKTest extends StatelessWidget {
  final CalculatorController controller = Get.put(CalculatorController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tran Ngoc Hung"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(

          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start, // đưa các giá trị trong colum về đầu
          children: [
            SizedBox(height: 10,),
            Text("chiều dài (cm): "),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) => controller.cmValue.value = value,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 10,),
                ElevatedButton(
                    onPressed: () => controller.CmToInch(),
                    child: Icon(Icons.arrow_downward)
                ),
                SizedBox(width: 10,),
                ElevatedButton(
                    onPressed: () => controller.InchToCm(),
                    child: Icon(Icons.arrow_upward)
                )
              ],
            ),
            SizedBox(height: 20,),
            Text("chiều dài (inches): "),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) => controller.inchValue.value = value,
            ),
            SizedBox(height: 10,),
            Text("Kết quả tính toán: ", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
            Expanded(
              child: Obx(() => ListView.builder(
                itemCount: controller.history.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(controller.history[index]),
                  );
                },
              )),
            ),
          ],
        ),
      ),
    );
  }
}

