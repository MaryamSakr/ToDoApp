import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/Features/home/Domain/Entities/task_entity.dart';

class TaskPrefs {
  static const String _tasksKey = 'tasks_cache';

  /// حفظ كل الـ tasks
  static Future<void> saveTasks(List<TaskEntity> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = tasks.map((t) => jsonEncode({
      "id": t.id,
      "userId": t.userId,
      "toDo": t.toDo,
      "completed": t.completed,
    })).toList();
    await prefs.setStringList(_tasksKey, tasksJson);
  }

  static Future<List<TaskEntity>> getTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = prefs.getStringList(_tasksKey) ?? [];
    return tasksJson.map((t) {
      final map = jsonDecode(t);
      return TaskEntity(
        id: map['id'],
        userId: map['userId'],
        toDo: map['toDo'],
        completed: map['completed'],
      );
    }).toList();
  }

  static Future<void> clearTasks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tasksKey);
  }
}
