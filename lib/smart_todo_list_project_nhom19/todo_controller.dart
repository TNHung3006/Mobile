import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'todo_model.dart';
import 'notification_service.dart';

class ToDoController extends GetxController {
  final DatabaseHelperToDo _dbHelper = DatabaseHelperToDo();
  final NotificationService _notificationService = NotificationService();
  RxList<ToDoItem> toDoItems = <ToDoItem>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    initDatabase();
  }

  Future<void> initDatabase() async {
    try {
      await _dbHelper.open();
      await loadToDoItems();
    } catch (e) {
      debugPrint("❌ Error initializing database: $e");
    }
  }

  Future<void> loadToDoItems() async {
    try {
      isLoading.value = true;
      List<ToDoItem> items = await _dbHelper.getToDoItems();
      toDoItems.value = items;
    } catch (e) {
      debugPrint("❌ Error loading items: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> addToDoItem(ToDoItem item) async {
    try {
      // 1. Lưu vào DB trước để lấy ID
      int id = await _dbHelper.insert(item);
      item.id = id;

      // 2. Lập lịch nhắc nhở nếu có cài đặt
      if (!item.isCompleted &&
          item.dueDate != null && item.dueDate!.isNotEmpty &&
          item.reminder != null && item.reminder!.isNotEmpty) {
        
        final int? notificationId = await _notificationService.scheduleReminder(
          title: item.title ?? "Công việc cần làm",
          body: item.description ?? "Bạn có một công việc sắp đến hạn!",
          dueDate: item.dueDate!,
          reminderTime: item.reminder!,
        );

        if (notificationId != null) {
          item.notificationId = notificationId;
          await _dbHelper.update(item, id);
        }
      }

      toDoItems.add(item);
      toDoItems.refresh();
      return true;
    } catch (e) {
      debugPrint("❌ Error adding item: $e");
      return false;
    }
  }

  Future<bool> updateToDoItem(ToDoItem newItem, int id) async {
    try {
      int index = toDoItems.indexWhere((p) => p.id == id);
      if (index == -1) return false;

      // 1. Hủy nhắc nhở cũ nếu có
      if (toDoItems[index].notificationId != null) {
        await _notificationService.cancelReminder(toDoItems[index].notificationId!);
      }

      // 2. Lập lịch nhắc nhở mới nếu công việc chưa xong và có cài đặt giờ
      if (!newItem.isCompleted &&
          newItem.dueDate != null && newItem.dueDate!.isNotEmpty &&
          newItem.reminder != null && newItem.reminder!.isNotEmpty) {
        
        final int? notificationId = await _notificationService.scheduleReminder(
          title: newItem.title ?? "Công việc cần làm",
          body: newItem.description ?? "Đã đến giờ thực hiện công việc!",
          dueDate: newItem.dueDate!,
          reminderTime: newItem.reminder!,
        );
        newItem.notificationId = notificationId;
      } else {
        newItem.notificationId = null;
      }

      // 3. Cập nhật DB và UI
      await _dbHelper.update(newItem, id);
      toDoItems[index] = newItem;
      toDoItems.refresh();
      return true;
    } catch (e) {
      debugPrint("❌ Error updating item: $e");
      return false;
    }
  }

  Future<bool> deleteToDoItem(int id) async {
    try {
      int index = toDoItems.indexWhere((item) => item.id == id);
      if (index != -1 && toDoItems[index].notificationId != null) {
        await _notificationService.cancelReminder(toDoItems[index].notificationId!);
      }

      await _dbHelper.delete(id);
      toDoItems.removeWhere((item) => item.id == id);
      return true;
    } catch (e) {
      debugPrint("❌ Error deleting item: $e");
      return false;
    }
  }

  Future<bool> toggleCompleted(int id) async {
    try {
      int index = toDoItems.indexWhere((p) => p.id == id);
      if (index == -1) return false;

      ToDoItem item = toDoItems[index];
      item.isCompleted = !item.isCompleted;

      if (item.isCompleted) {
        // Nếu đã hoàn thành -> Hủy nhắc nhở
        if (item.notificationId != null) {
          await _notificationService.cancelReminder(item.notificationId!);
          item.notificationId = null;
        }
      } else {
        // Nếu bỏ hoàn thành -> Thiết lập lại nhắc nhở nếu có giờ
        if (item.dueDate != null && item.reminder != null && item.reminder!.isNotEmpty) {
          item.notificationId = await _notificationService.scheduleReminder(
            title: item.title ?? "Công việc",
            body: "Nhắc nhở công việc chưa hoàn thành",
            dueDate: item.dueDate!,
            reminderTime: item.reminder!,
          );
        }
      }

      await _dbHelper.update(item, id);
      toDoItems.refresh();
      return true;
    } catch (e) {
      debugPrint("❌ Error toggling completion: $e");
      return false;
    }
  }

  Future<void> showInstantNotification(String title, String body) async {
    await _notificationService.showInstantNotification(title: title, body: body);
  }

  Future<void> debugPendingNotifications() async {
    final pending = await _notificationService.getPendingNotifications();
    debugPrint("🔔 Số thông báo đang đợi: ${pending.length}");
  }
}
