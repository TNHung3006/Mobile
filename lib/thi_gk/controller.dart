import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Controller extends GetxController{
  final txtMonHoc = TextEditingController();
  final txtTC = TextEditingController();
  final txtHocPhi = TextEditingController();

  var danhsachketqua = <String>[].obs;
  int Ketqua = 0;


  void InKetQua(){
    if (txtMonHoc.text.isNotEmpty && txtTC.text.isNotEmpty && txtHocPhi.text.isNotEmpty) {
      String a = txtMonHoc.text;
      double b = double.parse(txtHocPhi.text);
      double c = double.parse(txtTC.text);
      danhsachketqua.insert(0, "$a  \nHọc phí:  ${b.toStringAsFixed(0)} vnđ        số tín chỉ ${c.toStringAsFixed(0)}");
      Ketqua++;
    }
  }
}