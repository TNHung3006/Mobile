import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:http/http.dart';
import 'package:ngoc_hung66131218_flutter_app/Test-gk/ontap/lan2/xulytinhtoan.dart';

class Giaodien extends StatelessWidget {

  final DieuKhienChuyenDoi controller = Get.put(DieuKhienChuyenDoi());

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
            SizedBox(height: 10,),
            Text("Chieu dai (cm):"),
            TextField(
              controller: controller.txtCm,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: controller.ChuyenCmSangInches,
                    child: Icon(Icons.arrow_downward)
                ),
                SizedBox(width: 20,),
                ElevatedButton(
                    onPressed: controller.ChuyenInchesSangCm,
                    child: Icon(Icons.arrow_upward)
                )
              ],
            ),
            SizedBox(height: 10,),
            Text("Chieu dai (inches):"),
            TextField(
              controller: controller.txtInches,
              keyboardType: TextInputType.number,

            ),
            
            SizedBox(height: 10,),
            Text("Ket qua tinh toan: ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
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
            )
          ],
        ),
      ),
    );
  }
}
