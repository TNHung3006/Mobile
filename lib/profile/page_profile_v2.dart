import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngoc_hung66131218_flutter_app/profile/controller_profile.dart';

class PageProfileV2 extends StatelessWidget {
  PageProfileV2({super.key});
  TextEditingController txtName = TextEditingController();

  @override
  Widget build(BuildContext context) {

    ControllerProfile controller = ControllerProfile.instance;

    // txtName.text = controller.profile.ten?? "";
    return Scaffold(
      appBar: AppBar(
        title: Text("My profile V2"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 200,
                  width: 300,
                  child: Image.asset("asset/images/thien_nhien.jpg"),
                ),
              ),
              GetBuilder(
                id: "profile",
                init: controller,
                builder: (controller) {

                  // khong de o tren ma` de duoi day de co the load duoc ten vi` de o tren nhu ban dau thi load khong kip.
                  txtName.text = controller.profile.ten?? "";

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),
                      Text("Ho ten: "),
                      TextField(
                        readOnly: !controller.edittable,
                        controller: txtName,
                        onChanged: (value) => controller.profile.ten = value,
                      ),
                      SizedBox(width: 10,),
                      Text("Gioi tinh: "),
                      // RadioGroup(
                      //     groupValue: controller.profile.gioiTinh,
                      //     onChanged: (value) {
                      //       if(controller.edittable==true){
                      //         controller.profile.gioiTinh = value;
                      //         controller.changeState();
                      //       }
                      //     },
                      //     child: Row(
                      //       children: [
                      //         Expanded(
                      //           child: RadioListTile(
                      //             value: "Nữ",
                      //             title: Text("Nữ"),
                      //             // groupValue: controller.profile.gioiTinh,
                      //             // onChanged: (value) {
                      //             //   if(controller.edittable==true){
                      //             //     controller.profile.gioiTinh = value.toString();
                      //             //     controller.changeState();
                      //             //   }
                      //             // },
                      //           ),
                      //         ),
                      //         Expanded(
                      //           child: RadioListTile(
                      //             value: "Nam",
                      //             title: Text("Nam"),
                      //             // groupValue: controller.profile.gioiTinh,
                      //             // onChanged: (value) {
                      //             //   if(controller.edittable==true){
                      //             //     controller.profile.gioiTinh = value.toString();
                      //             //     controller.changeState();
                      //             //   }
                      //             // },
                      //           ),
                      //         ),
                      //       ],
                      //     )
                      // ), //
                      RadioGroup(
                          groupValue: controller.profile.gioiTinh,
                          onChanged: (value) {
                            if(controller.edittable==true){
                              controller.profile.gioiTinh = value;
                              controller.changeState();
                            }
                          },
                          child: Row(
                            children: [
                              Expanded(
                                child: RadioListTile(
                                  value: "Nữ",
                                  title: Text("Nữ"),
                                ),
                              ),
                              Expanded(
                                child: RadioListTile(
                                  value: "Nam",
                                  title: Text("Nam"),
                                ),
                              ),
                            ],
                          )
                      ),
                    ],
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end, // dua ve cuoi'
                children: [
                  SizedBox(width: 10,),
                  ElevatedButton( // tao nut bam'
                    onPressed: () {
                      controller.save();
                    },
                    child: Text("Save")
                  ),
                  SizedBox(width: 10,),
                  ElevatedButton( // tao nut bam'
                      onPressed: () {
                        controller.allowEdit();
                      },
                      child: Text("Edit")
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

