import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'todo_controller.dart';
import 'todo_model.dart';
import 'page_todo_detail.dart';

class PageToDo extends StatelessWidget {
  PageToDo({Key? key}) : super(key: key);

  final ToDoController controller = Get.put(ToDoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Smart To-Do List with Reminder"),
        elevation: 0,
        backgroundColor: Colors.deepPurple,
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
                Icon(Icons.done_all, size: 80, color: Colors.grey[300]),
                const SizedBox(height: 16),
                Text(
                  "Chưa có công việc nào",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(8),
          separatorBuilder: (context, index) =>
              const Divider(thickness: 1, height: 1),
          itemCount: controller.toDoItems.length,
          itemBuilder: (context, index) {
            ToDoItem item = controller.toDoItems[index];
            return Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
              child: ListTile(
                leading: Checkbox(
                  value: item.isCompleted,
                  onChanged: (value) {
                    controller.toggleCompleted(item.id!);
                  },
                ),
                title: Text(
                  item.title ?? "Không có tiêu đề",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    decoration: item.isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    color: item.isCompleted
                        ? Colors.grey
                        : Colors.black87,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (item.description != null && item.description!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          item.description!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    if (item.dueDate != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 14,
                              color: _getPriorityColor(item.priority),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              item.dueDate!,
                              style: TextStyle(
                                fontSize: 12,
                                color: _getPriorityColor(item.priority),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (item.reminder != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Row(
                          children: [
                            Icon(
                              Icons.notifications,
                              size: 14,
                              color: Colors.orange,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "Nhắc nhở: ${item.reminder}",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                trailing: PopupMenuButton(
                  onSelected: (value) {
                    if (value == 'edit') {
                      _navigateToDetail(context, item: item, isEdit: true);
                    } else if (value == 'delete') {
                      _deleteConfirm(context, item.id!);
                    }
                  },
                  itemBuilder: (BuildContext context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Text('Sửa'),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Text('Xoá'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () => _navigateToDetail(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _navigateToDetail(BuildContext context,
      {ToDoItem? item, bool isEdit = false}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            PageToDoDetail(item: item, isEdit: isEdit, controller: controller),
      ),
    );
  }

  void _deleteConfirm(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Xác nhận xoá"),
        content: const Text("Bạn chắc chắn muốn xoá công việc này?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Hủy"),
          ),
          TextButton(
            onPressed: () {
              controller.deleteToDoItem(id);
              Navigator.pop(context);
            },
            child: const Text("Xoá", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Color _getPriorityColor(int? priority) {
    switch (priority) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
