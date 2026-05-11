import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DieuKhienMayTinh extends GetxController {
  // Bộ điều khiển cho 2 số nhập vào
  final txtA = TextEditingController();
  final txtB = TextEditingController();

  // Danh sách lưu lịch sử tính toán
  var danhsachketqua = <String>[].obs;

  // Hàm tính Tổng
  void tinhCong() {
    if (txtA.text.isNotEmpty && txtB.text.isNotEmpty) {
      double a = double.parse(txtA.text);
      double b = double.parse(txtB.text);
      double kq = a + b;
      danhsachketqua.insert(0, "$a + $b = $kq");
    }
  }

  // Hàm tính Hiệu
  void tinhTru() {
    if (txtA.text.isNotEmpty && txtB.text.isNotEmpty) {
      double a = double.parse(txtA.text);
      double b = double.parse(txtB.text);
      double kq = a - b;
      danhsachketqua.insert(0, "$a - $b = $kq");
    }
  }

  // Hàm tính Tích
  void tinhNhan() {
    if (txtA.text.isNotEmpty && txtB.text.isNotEmpty) {
      double a = double.parse(txtA.text);
      double b = double.parse(txtB.text);
      double kq = a * b;
      danhsachketqua.insert(0, "$a * $b = $kq");
    }
  }

  // Hàm tính Thương
  void tinhChia() {
    if (txtA.text.isNotEmpty && txtB.text.isNotEmpty) {
      double a = double.parse(txtA.text);
      double b = double.parse(txtB.text);
      if (b != 0) {
        double kq = a / b;
        danhsachketqua.insert(0, "$a / $b = ${kq.toStringAsFixed(2)}");
      } else {
        danhsachketqua.insert(0, "Lỗi: Không thể chia cho 0");
      }
    }
  }
}
