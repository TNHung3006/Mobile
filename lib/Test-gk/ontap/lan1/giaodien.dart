import 'package:flutter/material.dart';

import 'XuLyTinhToan.dart';


class GiaoDienTinhToan extends StatefulWidget {
  const GiaoDienTinhToan({super.key});

  @override
  State<GiaoDienTinhToan> createState() => _GiaoDienTinhToanState();
}

class _GiaoDienTinhToanState extends State<GiaoDienTinhToan> {

  //1. Khai bao controller de lay/ghi du lieu vao 2 o textfield
  final TextEditingController txtCm = TextEditingController();
  final TextEditingController txtInches = TextEditingController();

  //2. khai bao danh sach de luu lich su tinh toan
  List<String> danhSachLichSu = [];

  // 3. Hàm xử lý nút mũi tên XUỐNG (CM -> Inches)
  void _tinhCmSangInches() {
    // Lấy số từ ô CM. Dùng tryParse để đề phòng người dùng nhập chữ hoặc để trống
    double cm = double.tryParse(txtCm.text) ?? 0.0;

    // Gọi logic từ lớp Xulytinhtoan của bạn
    double inches = Xulytinhtoan.cmToinches(cm);

    // setState báo cho Flutter biết cần vẽ lại màn hình
    setState(() {
      // Ghi kết quả vào ô Inches
      txtInches.text = inches.toStringAsFixed(3);

      // Lấy chuỗi định dạng từ lớp Xulytinhtoan
      String chuoiKetQua = Xulytinhtoan.taoChuoiLichSuCmToInches(cm, inches);

      // insert(0, ...) giúp đẩy kết quả mới nhất lên ĐẦU danh sách
      danhSachLichSu.insert(0, chuoiKetQua);
    });
  }

  // 4. Hàm xử lý nút mũi tên LÊN (Inches -> CM)
  void _tinhInchesSangCm() {
    double inches = double.tryParse(txtInches.text) ?? 0.0;
    double cm = Xulytinhtoan.inchesTocm(inches);

    setState(() {
      txtCm.text = cm.toStringAsFixed(2);

      // Dựa theo ảnh code của bạn, hàm này nhận tham số (cm, inches)
      String chuoiKetQua = Xulytinhtoan.taoChuoiLichSuInchesToCm(cm, inches);
      danhSachLichSu.insert(0, chuoiKetQua);
    });
  }

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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            Text("Chieu dai (cm): "),
            TextField(
              controller: txtCm,
              keyboardType: TextInputType.number,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: _tinhCmSangInches,
                    child: Icon(Icons.arrow_downward)),
                ElevatedButton(
                    onPressed: _tinhInchesSangCm,
                    child: Icon(Icons.arrow_upward)),
              ],
            ),
            SizedBox(height: 10,),
            Text("Chieu dai (inches)"),
            TextField(
              controller: txtInches,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10,),
            Text("Ket qua tinh toan: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),

            //5. vung hien thi danh sach lich su
            Expanded(
              child: ListView.separated(
                itemCount: danhSachLichSu.length,

                // Thuộc tính mới: Vẽ đường kẻ mờ (Divider) giữa các dòng
                separatorBuilder: (context, index) {
                  return Divider(
                    thickness: 1, // Độ dày của đường kẻ
                    color: Colors.grey.shade400, // Chỉnh màu xám mờ
                  );
                },

                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      danhSachLichSu[index],
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                },
              )
            )
          ],
        ),
      ),
    );
  }
}
