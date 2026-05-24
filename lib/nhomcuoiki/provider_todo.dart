import 'package:flutter/material.dart';
import 'todo_model.dart';

class ToDoProvider with ChangeNotifier {
  final DatabaseHelperToDo _dbHelper = DatabaseHelperToDo();
  List<ToDoItem>? _toDoItems;
  bool _isLoading = false;

  List<ToDoItem>? get toDoItems => _toDoItems;
  bool get isLoading => _isLoading;

  ToDoProvider() {
    init();
  }

  Future<void> init() async {
    try {
      await _dbHelper.open();
      await loadToDoItems();
    } catch (e) {
      debugPrint("❌ Error initializing provider: $e");
    }
  }

  Future<void> loadToDoItems() async {
    try {
      _isLoading = true;
      notifyListeners();
      
      List<ToDoItem> items = await _dbHelper.getToDoItems();
      _toDoItems = items;
      debugPrint("✅ Loaded ${items.length} items");
    } catch (e) {
      debugPrint("❌ Error loading items: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addToDoItem(ToDoItem item) async {
    try {
      int id = await _dbHelper.insert(item);
      item.id = id;
      _toDoItems?.add(item);
      notifyListeners();
      debugPrint("✅ Added item: $id");
      return true;
    } catch (e) {
      debugPrint("❌ Error adding item: $e");
      return false;
    }
  }

  Future<bool> updateToDoItem(ToDoItem item, int id) async {
    try {
      await _dbHelper.update(item, id);
      int index = _toDoItems?.indexWhere((p) => p.id == id) ?? -1;
      if (index != -1) {
        _toDoItems![index] = item;
        notifyListeners();
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
      _toDoItems?.removeWhere((item) => item.id == id);
      notifyListeners();
      debugPrint("✅ Deleted item: $id");
      return true;
    } catch (e) {
      debugPrint("❌ Error deleting item: $e");
      return false;
    }
  }

  Future<bool> toggleCompleted(int id) async {
    try {
      int index = _toDoItems?.indexWhere((p) => p.id == id) ?? -1;
      if (index != -1) {
        _toDoItems![index].isCompleted = !_toDoItems![index].isCompleted;
        await _dbHelper.update(_toDoItems![index], id);
        notifyListeners();
        debugPrint("✅ Toggled completion: $id");
        return true;
      }
      return false;
    } catch (e) {
      debugPrint("❌ Error toggling completion: $e");
      return false;
    }
  }
}
