import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/todo.dart';

class TaskStorage {
  static const _key = 'tasks';

  Future<TodoList> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);

    if (jsonString != null) {
      final jsonMap = jsonDecode(jsonString);
      return TodoList.fromJson(jsonMap);
    } else {
      return TodoList([]);
    }
  }

  Future<void> saveTasks(TodoList tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(tasks.toJson());
    await prefs.setString(_key, jsonString);
  }
}
