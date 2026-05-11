import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

// Lớp điều khiển xử lý logic chuyển đổi đơn vị, kế thừa từ GetxController để quản lý trạng thái
class DieuKhienChuyenDoi extends GetxController{
  // Khai báo bộ điều khiển cho ô nhập liệu: dùng để lấy dữ liệu người dùng nhập và gán lại kết quả tính toán
  final txtCm = TextEditingController();
  final txtInches = TextEditingController();

  // Danh sách quan sát (observable) để lưu lịch sử các kết quả tính toán, tự động cập nhật UI khi thay đổi
  var danhsachketqua = <String>[].obs;

  // Hàm xử lý khi nhấn nút chuyển từ Cm sang Inches (Mũi tên xuống)
  void ChuyenCmSangInches(){
    // Kiểm tra nếu ô nhập liệu cm không trống
    if(txtCm.text.isNotEmpty){
      // Chuyển đổi giá trị từ chuỗi sang số thực
      double cm = double.parse(txtCm.text);
      // Công thức: 1 inch = 2.54 cm
      double inches = cm / 2.54;

      // Ghi kết quả vào ô inches trên giao diện, lấy 3 chữ số thập phân
      txtInches.text = inches.toStringAsFixed(3);

      // Tạo chuỗi thông báo kết quả
      String ketqua = "${cm.toStringAsFixed(1)} cm = ${inches.toStringAsFixed(3)} inches";
      
      // Chèn kết quả mới nhất vào đầu danh sách (vị trí index 0) để hiển thị lên trên cùng
      danhsachketqua.insert(0, ketqua);
    }
  }

  // Hàm xử lý khi nhấn nút chuyển từ Inches sang Cm (Mũi tên lên)
  void ChuyenInchesSangCm(){
    // Kiểm tra nếu ô nhập liệu inches không trống
    if(txtInches.text.isNotEmpty){
      // Chuyển đổi giá trị từ chuỗi sang số thực
      double inches = double.parse(txtInches.text);
      // Công thức: cm = inches * 2.54
      double cm = inches * 2.54;

      // Ghi kết quả vào ô cm trên giao diện, lấy 1 chữ số thập phân
      txtCm.text = cm.toStringAsFixed(1);

      // Tạo chuỗi thông báo kết quả
      String ketqua = "${inches.toStringAsFixed(3)} inches = ${cm.toStringAsFixed(1)} cm";
      
      // Chèn kết quả mới nhất vào đầu danh sách lịch sử
      danhsachketqua.insert(0, ketqua);
    }
  }
}
