import 'package:sqflite/sqflite.dart';

const String tableToDo = "ToDo";

class ToDoItem {
  int? id;
  String? title;
  String? description;
  String? dueDate;
  String? reminder;
  bool isCompleted;
  int? priority; // 1=High, 2=Medium, 3=Low

  ToDoItem({
    this.id,
    required this.title,
    this.description,
    this.dueDate,
    this.reminder,
    this.isCompleted = false,
    this.priority = 2,
  });

  factory ToDoItem.fromJson(Map<String, dynamic> json) {
    return ToDoItem(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      dueDate: json['dueDate'],
      reminder: json['reminder'],
      isCompleted: json['isCompleted'] == 1 ? true : false,
      priority: json['priority'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'dueDate': dueDate,
    'reminder': reminder,
    'isCompleted': isCompleted ? 1 : 0,
    'priority': priority,
  };
}

class DatabaseHelperToDo {
  Database? database;
  String? _path;

  Future<String?> _getDatatbasePath(String databaseName) async {
    String p = await getDatabasesPath();
    String _path = "$p/$databaseName";
    this._path = _path;
    return _path;
  }

  Future<Database?> open() async {
    String? _path = await _getDatatbasePath('todo.db');
    database = await openDatabase(
      _path!,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE $tableToDo (id INTEGER PRIMARY KEY, title TEXT, description TEXT, dueDate TEXT, reminder TEXT, isCompleted INTEGER, priority INTEGER)',
        );
      },
    );
    return database;
  }

  Future<int> insert(ToDoItem todo) async {
    int id = await database!.transaction(
      (Transaction txn) async {
        int id = await txn.rawInsert(
          'INSERT INTO $tableToDo(title, description, dueDate, reminder, isCompleted, priority) VALUES(?, ?, ?, ?, ?, ?)',
          [
            todo.title,
            todo.description,
            todo.dueDate,
            todo.reminder,
            todo.isCompleted ? 1 : 0,
            todo.priority
          ],
        );
        return id;
      },
    );
    return id;
  }

  Future<int> update(ToDoItem newTodo, int id) async {
    int count = await database!.transaction((Transaction txn) async {
      int count = await txn.rawUpdate(
        'UPDATE $tableToDo SET title = ?, description = ?, dueDate = ?, reminder = ?, isCompleted = ?, priority = ? WHERE id = ?',
        [
          newTodo.title,
          newTodo.description,
          newTodo.dueDate,
          newTodo.reminder,
          newTodo.isCompleted ? 1 : 0,
          newTodo.priority,
          id
        ],
      );
      return count;
    });
    return count;
  }

  Future<int> delete(int id) async {
    int count = await database!.rawDelete(
      "DELETE FROM $tableToDo WHERE id = ?",
      [id],
    );
    return count;
  }

  Future<List<ToDoItem>> getToDoItems() async {
    List<Map> list = await database!.rawQuery("SELECT * FROM $tableToDo ORDER BY dueDate ASC");
    return list
        .map((todoJson) => ToDoItem.fromJson(todoJson as Map<String, dynamic>))
        .toList();
  }

  Future<void> closeDatabase() async {
    await database?.close();
  }

  Future<void> deleteDB() async {
    if (_path != null) {
      await deleteDatabase(_path!);
    }
  }
}
