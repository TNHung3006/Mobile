import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'todo_controller.dart';
import 'todo_model.dart';
import 'page_todo_detail.dart';
import 'notification_service.dart';

class PageToDo extends StatelessWidget {
  PageToDo({Key? key}) : super(key: key);

  final ToDoController controller = Get.put(ToDoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Smart To-Do List"),
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        actions: [
          // Nút TEST CHUÔNG 5 GIÂY
          IconButton(
            icon: const Icon(Icons.alarm_on, color: Colors.orangeAccent),
            onPressed: () async {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("🚀 Đang đợi 5 giây để nổ chuông test..."))
              );
              await NotificationService().test5Seconds();
            },
            tooltip: "Test chuông 5 giây",
          ),
          IconButton(
            icon: const Icon(Icons.bug_report),
            onPressed: () => controller.debugPendingNotifications(),
          )
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.toDoItems.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.assignment_late_outlined, size: 80, color: Colors.grey[300]),
                const SizedBox(height: 16),
                Text("Chưa có công việc nào", style: TextStyle(color: Colors.grey[500])),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: controller.toDoItems.length,
          itemBuilder: (context, index) {
            ToDoItem item = controller.toDoItems[index];
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                leading: Checkbox(
                  value: item.isCompleted,
                  onChanged: (value) => controller.toggleCompleted(item.id!),
                ),
                title: Text(
                  item.title ?? "",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    decoration: item.isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (item.dueDate != null) Text("📅 Ngày: ${item.dueDate}"),
                    if (item.reminder != null && item.reminder!.isNotEmpty)
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.orange[100],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text("⏰ Báo thức: ${item.reminder}", 
                          style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                      ),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.redAccent),
                  onPressed: () => controller.deleteToDoItem(item.id!),
                ),
                onTap: () => Navigator.push(context, MaterialPageRoute(
                  builder: (context) => PageToDoDetail(item: item, isEdit: true, controller: controller)
                )),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () => Navigator.push(context, MaterialPageRoute(
          builder: (context) => PageToDoDetail(isEdit: false, controller: controller)
        )),
        child: const Icon(Icons.add),
      ),
    );
  }
}
