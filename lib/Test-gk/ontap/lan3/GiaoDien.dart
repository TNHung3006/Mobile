import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngoc_hung66131218_flutter_app/Test-gk/ontap/lan3/xulytinhtoan.dart';

class GiaoDienLan3 extends StatelessWidget {
  // Khởi tạo controller cho Lan 3
  final DieuKhienMayTinh controller = Get.put(DieuKhienMayTinh());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ôn tập Lần 3 - Máy tính"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Số thứ nhất (A):", style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              controller: controller.txtA,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(hintText: "Nhập số A"),
            ),
            const SizedBox(height: 15),
            const Text("Số thứ hai (B):", style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              controller: controller.txtB,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(hintText: "Nhập số B"),
            ),
            const SizedBox(height: 20),
            // Hàng chứa 4 nút bấm phép tính
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCalcButton(label: "+", color: Colors.blue, onPressed: controller.tinhCong),
                _buildCalcButton(label: "-", color: Colors.red, onPressed: controller.tinhTru),
                _buildCalcButton(label: "x", color: Colors.green, onPressed: controller.tinhNhan),
                _buildCalcButton(label: ":", color: Colors.orange, onPressed: controller.tinhChia),
              ],
            ),
            const SizedBox(height: 25),
            const Text("Lịch sử tính toán:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(thickness: 2),
            Expanded(
              child: Obx(
                () => ListView.separated(
                  itemCount: controller.danhsachketqua.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(child: Text("${index + 1}")),
                      title: Text(
                        controller.danhsachketqua[index],
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Hàm helper để tạo nút bấm nhanh
  Widget _buildCalcButton({required String label, required Color color, required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        fixedSize: const Size(60, 60),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(label, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    );
  }
}
