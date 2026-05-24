// 🎯 Integration Guide - Cách tích hợp vào dự án

import 'package:get/get.dart';
import 'todo_controller.dart';
import 'provider_todo.dart';
import 'page_todo.dart';

/// ===== OPTION 1: GetX Bindings =====
/// 
/// Sử dụng Bindings để khởi tạo Controller
/// Thêm vào main.dart:

class ToDoBindings extends Bindings {
  @override
  void dependencies() {
    // Lazy Load Controller - chỉ tạo khi cần
    Get.lazyPut(() => ToDoController());
  }
}

// Trong GetMaterialApp:
// GetMaterialApp(
//   initialRoute: '/',
//   getPages: [
//     GetPage(
//       name: '/todo',
//       page: () => PageToDo(),
//       binding: ToDoBindings(),
//     ),
//   ],
// )

/// ===== OPTION 2: Trực tiếp trong StatelessWidget =====
/// 
/// Khởi tạo trực tiếp trong Widget

// class PageToDo extends StatelessWidget {
//   final ToDoController controller = Get.put(ToDoController());
//   
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() => 
//       ListView.builder(
//         itemCount: controller.toDoItems.length,
//         itemBuilder: (context, index) {
//           return ListTile(title: Text(controller.toDoItems[index].title ?? ""));
//         },
//       )
//     );
//   }
// }

/// ===== OPTION 3: Provider Integration =====
/// 
/// Sử dụng Provider cho State Management
/// Thêm vào main.dart:

// void main() {
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(
//           create: (context) => ToDoProvider(),
//         ),
//       ],
//       child: MyApp(),
//     ),
//   );
// }

// Trong Widget:
// class PageToDoWithProvider extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ToDoProvider>(
//       builder: (context, provider, child) {
//         if (provider.isLoading) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         
//         return ListView.builder(
//           itemCount: provider.toDoItems?.length ?? 0,
//           itemBuilder: (context, index) {
//             return ListTile(
//               title: Text(provider.toDoItems![index].title ?? ""),
//             );
//           },
//         );
//       },
//     );
//   }
// }

/// ===== OPTION 4: Hybrid (GetX + Provider) =====
/// 
/// Dùng cả GetX Navigation + Provider State Management
/// Hữu ích nếu bạn muốn tách navigation và state management

// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => ToDoProvider(),
//       child: MyApp(),
//     ),
//   );
// }

// Sử dụng navigation với GetX:
// Get.to(() => PageToDo());
// Get.back();

// Sử dụng state với Provider:
// final provider = Provider.of<ToDoProvider>(context);

/// ===== OPTION 5: Simple Navigation =====
/// 
/// Nếu không dùng GetX, dùng Navigator thông thường

// // Push new screen
// Navigator.push(
//   context,
//   MaterialPageRoute(builder: (context) => PageToDo()),
// );

// // Pop back
// Navigator.pop(context);

/// ===== PUBSPEC.YAML Dependencies =====

// dependencies:
//   flutter:
//     sdk: flutter
//   get: ^4.6.0                              # GetX
//   provider: ^6.0.0                         # Provider
//   sqflite: ^2.0.0                          # SQLite Database
//   path_provider: ^2.0.0                    # Path provider
//   intl: ^0.19.0                            # Internationalization
//   flutter_local_notifications: ^14.0.0     # Notifications (optional)

/// ===== QUICK START EXAMPLE =====

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:code/nhomcuoiki/page_todo.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'Smart To-Do List',
//       theme: ThemeData(
//         primarySwatch: Colors.deepPurple,
//         useMaterial3: true,
//       ),
//       home: PageToDo(),
//     );
//   }
// }

/// ===== HOW TO USE IN YOUR APP =====

// 1. Sao chép toàn bộ nhomcuoiki folder vào lib/
// 2. Thêm dependencies vào pubspec.yaml
// 3. Run: flutter pub get
// 4. Import PageToDo hoặc ToDoController
// 5. Chọn một trong các cách trên để integrate
// 6. Run app!

/// ===== FILE STRUCTURE =====
// lib/
// ├── nhomcuoiki/
// │   ├── todo_model.dart
// │   ├── todo_controller.dart
// │   ├── provider_todo.dart
// │   ├── page_todo.dart
// │   ├── page_todo_detail.dart
// │   ├── README.md
// │   └── integration_guide.dart  (this file)
// ├── main.dart
// └── ...

/// ===== TIPS & TRICKS =====

// 1. Để clear database:
//    final helper = DatabaseHelperToDo();
//    await helper.deleteDB();

// 2. Để export dữ liệu:
//    final items = await controller.getToDoItems();
//    // Convert to JSON hoặc CSV

// 3. Để thêm notifications:
//    Cài flutter_local_notifications
//    Gọi notification khi reminder time đến

// 4. Để offline-first sync:
//    Thêm timestamp để track changes
//    Sync với Firebase/Cloud khi online

// 5. Để add categories/tags:
//    Thêm field 'category' hoặc 'tags' vào ToDoItem
//    Migrate database schema
