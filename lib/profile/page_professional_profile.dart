import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Thư viện GetX để quản lý trạng thái (state management)
import 'package:ngoc_hung66131218_flutter_app/profile/controller_profile.dart'; // Import controller quản lý dữ liệu profile

class ProfessionalProfilePage extends StatelessWidget {
  const ProfessionalProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Khởi tạo hoặc lấy instance của ControllerProfile đã được tạo
    ControllerProfile controller = ControllerProfile.instance;

    return Scaffold(
      // GetBuilder lắng nghe sự thay đổi từ controller thông qua id: "profile"
      body: GetBuilder(
        id: "profile",
        init: controller,
        builder: (controller) {
          return SingleChildScrollView( // Cho phép cuộn trang nếu nội dung quá dài
            child: Column(
              children: [
                _buildHeader(context), // Widget phần đầu trang (ảnh bìa, ảnh đại diện)
                const SizedBox(height: 60), // Khoảng cách để chừa chỗ cho Avatar đang đè lên
                _buildMainInfo(controller), // Widget hiển thị Tên và Chức danh
                const SizedBox(height: 20),
                _buildStatsRow(), // Widget hiển thị các con số thống kê (Posts, Followers...)
                const SizedBox(height: 20),
                _buildDetailsList(controller), // Widget hiển thị danh sách thông tin chi tiết
                const SizedBox(height: 30),
                // Nút bấm Chỉnh sửa Profile
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    onPressed: () => controller.allowEdit(), // Gọi hàm cho phép chỉnh sửa trong controller
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent, // Màu nền của nút
                      foregroundColor: Colors.white, // Màu chữ/icon của nút
                      minimumSize: const Size(double.infinity, 50), // Nút dài tràn ngang màn hình
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // Bo góc cho nút
                      ),
                    ),
                    child: const Text("Edit Profile", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 50), // Khoảng cách cuối trang
              ],
            ),
          );
        },
      ),
    );
  }

  // Hàm xây dựng phần Header với ảnh bìa và ảnh đại diện
  Widget _buildHeader(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none, // Cho phép các widget con hiển thị lòi ra ngoài phạm vi của Stack
      alignment: Alignment.center,
      children: [
        // Phần Container chứa ảnh bìa và màu Gradient
        Container(
          height: 200,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient( // Tạo hiệu ứng chuyển màu từ xanh sang tím
              colors: [Colors.blueAccent, Colors.purpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only( // Bo tròn 2 góc dưới của ảnh bìa
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Opacity(
            opacity: 0.3, // Làm ảnh bìa mờ đi để nổi bật màu Gradient
            child: Image.asset(
              "asset/images/thien_nhien.jpg",
              fit: BoxFit.cover, // Ảnh phủ kín Container
            ),
          ),
        ),
        // Nút quay lại (Back Button)
        Positioned(
          top: 40,
          left: 10,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        // Ảnh đại diện (Avatar) nằm đè lên giữa ảnh bìa và phần body
        Positioned(
          bottom: -50, // Đẩy avatar xuống dưới để lòi ra ngoài ảnh bìa 50 pixel
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 4), // Viền trắng xung quanh ảnh đại diện
              boxShadow: [
                BoxShadow( // Hiệu ứng đổ bóng cho ảnh đại diện
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 5,
                )
              ],
            ),
            child: const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage("asset/images/thien_nhien.jpg"),
            ),
          ),
        ),
      ],
    );
  }

  // Hàm hiển thị Tên và Chức danh chuyên môn
  Widget _buildMainInfo(ControllerProfile controller) {
    return Column(
      children: [
        Text(
          controller.profile.ten ?? "Chưa cập nhật",
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 5),
        Text(
          "Mobile Developer | Flutter Enthusiast", // Chức danh cố định để tạo vẻ chuyên nghiệp
          style: TextStyle(fontSize: 16, color: Colors.grey[600], fontStyle: FontStyle.italic),
        ),
      ],
    );
  }

  // Hàm xây dựng hàng ngang hiển thị các con số thống kê
  Widget _buildStatsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Chia đều khoảng cách giữa các mục
      children: [
        _buildStatItem("Posts", "12"),
        _buildStatItem("Followers", "1.2k"),
        _buildStatItem("Following", "150"),
      ],
    );
  }

  // Widget con cho từng mục thống kê
  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
      ],
    );
  }

  // Hàm hiển thị danh sách thông tin chi tiết trong một chiếc Card
  Widget _buildDetailsList(ControllerProfile controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        elevation: 2, // Độ nổi khối của Card
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), // Bo góc cho Card
        child: Column(
          children: [
            _buildListTile(Icons.person, "Giới tính", controller.profile.gioiTinh ?? "N/A"),
            const Divider(height: 1), // Đường kẻ mờ phân chia các dòng
            _buildListTile(Icons.cake, "Ngày sinh", controller.profile.ngaySinh != null ? "10/10/2000" : "Chưa cập nhật"),
            const Divider(height: 1),
            _buildListTile(Icons.favorite, "Sở thích", controller.profile.soThich ?? "Chưa cập nhật"),
            const Divider(height: 1),
            _buildListTile(Icons.code, "Ngôn ngữ", controller.profile.nnlt ?? "Flutter/Dart"),
          ],
        ),
      ),
    );
  }

  // Widget con cho từng hàng thông tin (Icon - Tiêu đề - Nội dung)
  Widget _buildListTile(IconData icon, String title, String trailing) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent), // Icon bên trái
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)), // Tiêu đề ở giữa
      trailing: Text(trailing, style: const TextStyle(color: Colors.grey)), // Nội dung bên phải
    );
  }
}
