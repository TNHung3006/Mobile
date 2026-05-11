import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngoc_hung66131218_flutter_app/thi_gk/controller.dart';

class KimTraGK extends StatelessWidget {
  final Controller controller = Get.put(Controller());

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5,),
            Text("Môn học: "),
            TextField(
              controller: controller.txtMonHoc,
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 5,),
            Text("Số TC: "),
            TextField(
              controller: controller.txtTC,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 5,),
            Text("Học phí: "),
            TextField(
              controller: controller.txtHocPhi,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: controller.InKetQua,
                    child: Text("Thêm"),
                )
              ],
            ),
            SizedBox(height: 10,),
            Text("Danh sách môn học: ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            Divider(thickness: 2,),

            Expanded(
                child: Obx(
                      () => ListView.separated(
                    itemCount: controller.danhsachketqua.length,
                    separatorBuilder: (context, index) {
                      return Divider(
                        thickness: 1,
                        color: Colors.grey,
                      );
                    },
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          controller.danhsachketqua[index],
                          style: TextStyle(fontSize: 15),
                        ),
                      );
                    },
                  ),
                )
            ),
            Divider(thickness: 2,),
            Text("Danh sách có: 2 môn học", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          ],
        ),
      ),
    );
  }
}
