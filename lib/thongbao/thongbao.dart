import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PageThongBao extends StatefulWidget {
  const PageThongBao({super.key});

  @override
  State<PageThongBao> createState() => _PageThongBaoState();
}

class _PageThongBaoState extends State<PageThongBao> {
  // Tạo controller để lấy dữ liệu từ TextField
  final TextEditingController _phoneController = TextEditingController();

  // Hàm xử lý chức năng gọi
  Future<void> _makePhoneCall(String phoneNumber) async {
    if (phoneNumber.isEmpty) return; // Bỏ qua nếu chưa nhập số

    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );

    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      debugPrint('Không thể thực hiện cuộc gọi tới $launchUri');
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ung dung goi dien"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: "Nhập số điện thoại...",
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () {
                      _makePhoneCall(_phoneController.text.trim());
                    },
                    child: const Text("Call")
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}