import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'todo_model.dart';

class ToDoController extends GetxController {
  final DatabaseHelperToDo _dbHelper = DatabaseHelperToDo();
  RxList<ToDoItem> toDoItems = <ToDoItem>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    debugPrint("=== ToDoController: onInit ===");
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
      debugPrint("✅ Loaded ${items.length} items");
    } catch (e) {
      debugPrint("❌ Error loading items: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> addToDoItem(ToDoItem item) async {
    try {
      int id = await _dbHelper.insert(item);
      item.id = id;
      toDoItems.add(item);
      debugPrint("✅ Added item with ID: $id");
      return true;
    } catch (e) {
      debugPrint("❌ Error adding item: $e");
      return false;
    }
  }

  Future<bool> updateToDoItem(ToDoItem item, int id) async {
    try {
      await _dbHelper.update(item, id);
      int index = toDoItems.indexWhere((p) => p.id == id);
      if (index != -1) {
        toDoItems[index] = item;
        toDoItems.refresh();
      }
      debugPrint("✅ Updated item: $id");
      return true;
    } catch (e) {
      debugPrint("❌ Error updating item: $e");
      return false;
    }
  }

  Future<bool> deleteToDoItem(int id) async {
    try {
      await _dbHelper.delete(id);
      toDoItems.removeWhere((item) => item.id == id);
      debugPrint("✅ Deleted item: $id");
      return true;
    } catch (e) {
      debugPrint("❌ Error deleting item: $e");
      return false;
    }
  }

  Future<bool> toggleCompleted(int id) async {
    try {
      int index = toDoItems.indexWhere((p) => p.id == id);
      if (index != -1) {
        toDoItems[index].isCompleted = !toDoItems[index].isCompleted;
        await _dbHelper.update(toDoItems[index], id);
        toDoItems.refresh();
        debugPrint("✅ Toggled completion status: $id");
        return true;
      }
      return false;
    } catch (e) {
      debugPrint("❌ Error toggling completion: $e");
      return false;
    }
  }

  Future<void> closeDatabase() async {
    await _dbHelper.closeDatabase();
  }

  @override
  void onClose() {
    closeDatabase();
    super.onClose();
  }
}
