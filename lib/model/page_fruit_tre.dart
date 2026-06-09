import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:get/get.dart';
import 'package:ngoc_hung66131218_flutter_app/model/controller_fruit_store.dart';
import 'package:ngoc_hung66131218_flutter_app/model/fruit.dart';
import 'package:ngoc_hung66131218_flutter_app/supabase/page_login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PageFruit_Tre extends StatelessWidget {
  PageFruit_Tre({super.key});
  final controller = Get.put(ControllerFruitStore());

  @override
  Widget build(BuildContext context) {
    if (controller.mapFruits.isEmpty) {
      controller.onReady();
    }
    return GetBuilder<ControllerFruitStore>(
        id: "gioHang",
        init: controller,
        builder: (controller) {
          final user = Supabase.instance.client.auth.currentUser;
          return Scaffold(
            appBar: AppBar(
              title: const Text("Fruit store tre"),
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              actions: [
                IconButton(
                  onPressed: () {
                    Get.to(() => const PageGioHang());
                  },
                  icon: badges.Badge(
                    badgeContent: Text(
                      "${controller.slMHG}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    child: const Icon(Icons.shopping_cart, size: 30, color: Colors.red,),
                  ),
                ),
                const SizedBox(width: 10,),
              ],
            ),
            drawer: user != null ? MyDrawer(controller: controller, email: user.email!) : null,
            body: SafeArea(
                child: GetBuilder<ControllerFruitStore>(
                  id: "fruits",
                  init: controller,
                  builder: (controller) {
                    var fruits = controller.mapFruits.values;
                    return GridView.extent(
                      maxCrossAxisExtent: 200,
                      crossAxisSpacing: 5,
                      childAspectRatio: 0.7,
                      children: fruits.map(
                            (e) {
                          return Card(
                            child: GestureDetector(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) {
                                    return PageChiTiet(fruit: e);
                                  },)
                                );
                              },
                              child: Column(
                                children: [
                                  Image.network(e.anh?? "No image"),
                                  Text("${e.ten}"),
                                  Text("${e.gia } VND")
                                ],
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    );
                  },
                )
            ),
          );
        }
    );
  }
}

class PageChiTiet extends StatelessWidget {
  PageChiTiet({super.key, required this.fruit});
  final Fruit fruit;
  final controller = Get.find<ControllerFruitStore>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControllerFruitStore>(
        id: "gioHang",
        init: controller,
        builder: (controller) {
          final user = Supabase.instance.client.auth.currentUser;
          return Scaffold(
            appBar: AppBar(
              title: Text(fruit.ten),
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              actions: [
                IconButton(
                  onPressed: () {
                    Get.to(() => const PageGioHang());
                  },
                  icon: badges.Badge(
                    badgeContent: Text(
                      "${controller.slMHG}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    child: const Icon(Icons.shopping_cart, size: 30, color: Colors.red,),
                  ),
                ),
                const SizedBox(width: 10,),
              ],
            ),
            drawer: user != null ? MyDrawer(controller: controller, email: user.email!) : null,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      fruit.anh != null && fruit.anh!.startsWith('http')
                          ? Image.network(
                        fruit.anh!,
                        width: double.infinity,
                        height: 300,
                        fit: BoxFit.cover,
                      )
                          : const SizedBox(
                        height: 300,
                        child: Icon(Icons.image, size: 100, color: Colors.grey),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        fruit.ten,
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Giá: ${fruit.gia} VND",
                        style: const TextStyle(fontSize: 18, color: Colors.red),
                      ),
                      const Row(
                        children: [
                          Icon(Icons.star, color: Colors.orange,),
                          Icon(Icons.star, color: Colors.orange,),
                          Icon(Icons.star, color: Colors.orange,),
                          Icon(Icons.star, color: Colors.orange,),
                          Icon(Icons.star_half, color: Colors.orange,),
                          SizedBox(width: 30,),
                          Text("100 danh gia" ,style: TextStyle(fontSize: 18),)
                        ],),
                    ],
                  ),
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.purple,
              onPressed: () async {
                if (Supabase.instance.client.auth.currentUser != null) {
                  await controller.themMH_vao_GH(fruit);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Đã thêm ${fruit.ten} vào giỏ hàng!"),
                      backgroundColor: Colors.green,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                } else {
                  Get.snackbar(
                    "Yêu cầu đăng nhập",
                    "Vui lòng đăng nhập để thêm sản phẩm vào giỏ hàng",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.orangeAccent,
                    colorText: Colors.white,
                  );

                  await Get.to(() => const PageLogin());

                  if (Supabase.instance.client.auth.currentUser != null) {
                    await controller.dangNhap();
                    await controller.themMH_vao_GH(fruit);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Đã tự động thêm ${fruit.ten} vào giỏ hàng!"),
                        backgroundColor: Colors.green,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  }
                }
              },
              child: const Icon(Icons.add_shopping_cart, color: Colors.white),
            ),
          );
        }
    );
  }
}

class MyDrawer extends StatelessWidget {
  final ControllerFruitStore controller;
  final String email;

  const MyDrawer({super.key, required this.controller, required this.email});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.inversePrimary),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.account_circle, size: 60, color: Colors.white),
                const SizedBox(height: 10),
                Text(
                  'Chào: "$email"',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Sign out", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red)),
            onTap: () async {
              await controller.dangXuat();
              Get.back();
              Get.snackbar(
                "Đã Sign out",
                "Giỏ hàng của bạn đã được làm trống!",
                backgroundColor: Colors.grey[800],
                colorText: Colors.white,
              );
            },
          ),
        ],
      ),
    );
  }
}

class PageGioHang extends StatelessWidget {
  const PageGioHang({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Giỏ hàng của tôi"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const Center(
        child: Text("Giao diện giỏ hàng ở đây"),
      ),
    );
  }
}