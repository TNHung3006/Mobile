import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngoc_hung66131218_flutter_app/profile/controller_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileV2{
  String? ten, gioiTinh, soThich, nnlt;
  int? ngaySinh;

  ProfileV2({
    this.ten,
    this.gioiTinh,
    this.soThich,
    this.nnlt,
    this.ngaySinh,
  });

  Map<String, dynamic> toMap() {
    return {
      'ten': this.ten,
      'gioiTinh': this.gioiTinh,
      'soThich': this.soThich,
      'nnlt': this.nnlt,
      'ngaySinh': this.ngaySinh,
    };
  }

  factory ProfileV2.fromMap(Map<String, dynamic> map) {
    return ProfileV2(
      ten: map['ten'] as String,
      gioiTinh: map['gioiTinh'] as String,
      soThich: map['soThich'] as String,
      nnlt: map['nnlt'] as String,
      ngaySinh: map['ngaySinh'] as int,
    );
  }
}

// class PageProfileV2 extends StatelessWidget {
//   PageProfileV2({super.key});
//   TextEditingController txtName = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//
//     ControllerProfile controller = ControllerProfile.instance;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("My profile V2"),
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Center(
//             child: Container(
//               height: 200,
//               width: 300,
//               child: Image.asset("asset/images/thien_nhien.jpg"),
//             ),
//           ),
//           GetBuilder(
//             id: "profile",
//             init: controller,
//             builder: (controller) {
//               return Column(
//               children: [
//
//               ],
//               );
//             },
//           )
//         ],
//       ),
//     );
//   }
// }


class ProfileV2_Snapshot{
  static Future<ProfileV2> loadProfile() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? s = preferences.getString("profile");
    if(s!=null){
      ProfileV2 p = ProfileV2.fromMap(jsonDecode(s));
      return p;
    }
    return ProfileV2(
      ten: "Ngoc Hung",
      ngaySinh: DateTime(2000, 10, 10).microsecond,
      gioiTinh: "Nam",
      soThich: "thich nhieu thu",
      nnlt: "tieng viet",

    );
  }
  static Future<void> saveProfile(ProfileV2 p) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String s = jsonEncode(p.toMap());
    preferences.setString("profile", s);
  }
}