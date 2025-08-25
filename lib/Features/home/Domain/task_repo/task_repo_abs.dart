import 'package:todo/Features/home/Domain/Entities/task_entity.dart';

abstract class TaskRepoAbs{
  Future<List<TaskEntity>> getFirst5Tasks();
  Future<List<TaskEntity>> getAllTasks({int skip , int limit});
  Future<String> deleteTask(int id);
  Future<String> updateTask({
    required int id,
    required String todo,
    required bool status,
  });
  Future<dynamic> addTask({
    required int userId,
    required String todo,
    required bool status,
  });
}