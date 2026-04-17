
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngoc_hung66131218_flutter_app/Test-gk/mau/baiontap/controller.dart';


class MainPage extends StatelessWidget {
  final UnitController controller = Get.put(UnitController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lam Tien Dat"),backgroundColor: Theme.of(context).colorScheme.inversePrimary,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text("chiều dài (cm):"),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) => controller.cmValue.value = value,
            ),

            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () => controller.convertCmToInch(),
                  child: Icon(Icons.arrow_downward)
                ),
                IconButton(
                  icon: Icon(Icons.arrow_upward),
                  onPressed: () => controller.convertInchToCm(),
                ),
              ],
            ),

            Text("chiều dài (inches):"),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) => controller.inchValue.value = value,
            ),

            SizedBox(height: 20),
            Text("Kết quả tính toán:", style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: Obx(() => ListView.separated(
                itemCount: controller.history.length,
                separatorBuilder: (context, index) => Divider(
                  height: 1, // Ép chiều cao về 1 để không bị dư khoảng trống thừa
                  thickness: 1, // Độ dày của đường kẻ (1 pixel là chuẩn đẹp)
                  color: Colors.grey.shade400, // Màu xám nhạt giống viền TextField
                ),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
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