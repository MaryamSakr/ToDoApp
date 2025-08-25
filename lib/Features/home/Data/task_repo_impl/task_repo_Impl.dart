import 'package:todo/Features/home/Data/remote_data_source/task_remote_datasource.dart';
import 'package:todo/Features/home/Domain/Entities/task_entity.dart';
import 'package:todo/Features/home/Domain/task_repo/task_repo_abs.dart';

class TaskRepoImpl extends TaskRepoAbs {
  TaskRemoteDataSource taskRemoteDataSource;

  TaskRepoImpl(this.taskRemoteDataSource);

  @override
  Future<List<TaskEntity>> getFirst5Tasks() async {
    final tasks = await taskRemoteDataSource.getFirst5Tasks();
    return tasks.map((task) => task.toEntity()).toList();
  }

  @override
  Future<List<TaskEntity>> getAllTasks({int skip = 0, int limit = 14}) async {
    final tasks = await taskRemoteDataSource.getAllTasks(
      skip: skip,
      limit: limit,
    );
    return tasks.map((task) => task.toEntity()).toList();
  }

  @override
  Future<String> deleteTask(int id) async {
    return await taskRemoteDataSource.deleteTask(id);
  }

  @override
  Future<String> updateTask({
    required int id,
    required String todo,
    required bool status,
  }) async {
    return await taskRemoteDataSource.updateTask(
      id: id,
      status: status,
      todo: todo,
    );
  }

  @override
  Future<dynamic> addTask({
    required int userId,
    required String todo,
    required bool status,
  }) async {
    return await taskRemoteDataSource.addTask(
      userId: userId,
      status: status,
      todo: todo,
    );
  }
}
