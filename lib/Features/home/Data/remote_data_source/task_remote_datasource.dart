import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todo/Features/home/Data/Models/task_model.dart';
import 'package:todo/constans/api_urls.dart';

class TaskRemoteDataSource {
  final http.Client client;

  TaskRemoteDataSource({required this.client});

  Future<List<TaskModel>> getAllTasks({int skip = 0, int limit = 14}) async {
    final url = Uri.parse('$baseUrl?skip=$skip&limit=$limit');

    try {
      final response = await client.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final List<dynamic> tasksJson = data['todos'];

        return tasksJson
            .map((task) => TaskModel.fromJson(task as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception("Failed to load tasks: ${response.statusCode}");
      }
    } catch (e) {
      print("Error in getAllTasks: $e");
      return [];
    }
  }

  Future<List<TaskModel>> getFirst5Tasks() async {
    final url = Uri.parse('${baseUrl}?limit=5');

    try {
      final response = await client.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final List<dynamic> tasksJson = data['todos'];

        return tasksJson
            .map((task) => TaskModel.fromJson(task as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception("Failed to load task: ${response.statusCode}");
      }
    } catch (e) {
      print("Error in getAllTasks: $e");
      return [];
    }
  }

  Future<String> deleteTask(int id) async {
    final url = Uri.parse('$baseUrl/$id');

    try {
      final response = await client.delete(url);

      if (response.statusCode == 200) {
        return "Task Deleted Successfully";
      } else {
        final data = jsonEncode(response.body) ;

        return data;
      }
    } catch (e) {
      print("Error in Delete Task: $e");
      return "Error in Delete Task: $e";
    }
  }

  Future<String> updateTask({
    required int id,
    required String todo,
    required bool status,
  }) async {
    final url = Uri.parse('$baseUrl/$id');

    try {
      final response = await client.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'completed': status, 'todo': todo}),
      );

      if (response.statusCode == 200) {
        return "Task Updated Successfully";
      } else {
        final data = jsonEncode(response.body) ;

        return data;
      }
    } catch (e) {
      print("Error in update Task: $e");
      return "Error in update Task: $e";
    }
  }

  Future<dynamic> addTask({
    required String todo,
    required bool status,
    int userId = 1,

  }) async {
    final url = Uri.parse('$baseUrl/add');
    try {
      final response = await client.post(
        url,
        headers: { 'Content-Type': 'application/json' },
        body:  jsonEncode({
          'todo': todo,
          'completed': status,
          'userId': userId,
        }),
      );
      // print(jsonDecode(response.body));
      // print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        print("///////////////////////");
        return data['id'];
      } else {
        final data = jsonEncode(response.body) ;

        return data;
      }
    } catch (e) {
      print("Error in add Task: $e");
      return "Error in add Task: $e";
    }
  }
}
