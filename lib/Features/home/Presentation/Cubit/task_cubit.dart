import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/Features/home/Domain/Entities/task_entity.dart';
import 'package:todo/Features/home/Domain/task_repo/task_repo_abs.dart';

import '../../../../helper/shared_preference_helper.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final TaskRepoAbs taskRepoAbs;
  int skip = 0;
  final int limit = 14;
  bool isLoadingMore = false;
  bool hasMore = true;
  List<TaskEntity> tasks = [];

  TaskCubit(this.taskRepoAbs) : super(TaskInitial());

  Future<void> getFirst5Tasks() async {
    emit(TaskLoading());
    try {
      final tasks = await taskRepoAbs.getFirst5Tasks();
      emit(TaskLoaded(tasks));
    } catch (e) {
      emit(TaskError("Failed to fetch tasks"));
    }
  }

  Future<void> loadTasks({bool isInitial = false}) async {
    if (isInitial) {
      tasks.clear();
      hasMore = true;
      skip = 0;
      emit(TaskLoading());
      await TaskPrefs.clearTasks();
    }

    if (isLoadingMore || !hasMore) return;

    try {
      isLoadingMore = true;
      final newTasks = await taskRepoAbs.getAllTasks(skip: skip, limit: limit);

      if (newTasks.isEmpty) {
        hasMore = false;
      } else {
        tasks.addAll(newTasks);
        skip += limit;

        await TaskPrefs.saveTasks(tasks);
      }

      emit(TaskLoaded(List.from(tasks)));
    } catch (e) {
      emit(TaskError(e.toString()));
    } finally {
      isLoadingMore = false;
    }
  }

  Future<void> deleteTask(int id) async {
    try {
      final message = await taskRepoAbs.deleteTask(id);
      final currentTasks = state is TaskLoaded
          ? List<TaskEntity>.from((state as TaskLoaded).tasks)
          : [TaskEntity(id: 0, userId: 0, toDo: "", completed: false)];
      currentTasks.removeWhere((task) => task.id == id);

      await TaskPrefs.saveTasks(currentTasks);

      emit(TaskDeleted(tasks: currentTasks, message: message));
      emit(TaskLoaded(currentTasks));
    } catch (e) {
      emit(TaskError("Failed to delete task $e"));
    }
  }

  Future<void> taskUpdate({
    required int id,
    required String todo,
    required bool status,
  }) async {
    try {
      final message = await taskRepoAbs.updateTask(
        todo: todo,
        status: status,
        id: id,
      );

      final currentTasks = state is TaskLoaded
          ? List<TaskEntity>.from((state as TaskLoaded).tasks)
          : [TaskEntity(id: 0, userId: 0, toDo: "", completed: false)];

      final index = currentTasks.indexWhere((task) => task.id == id);
      if (index != -1) {
        final oldTask = currentTasks[index];
        currentTasks[index] = TaskEntity(
          id: oldTask.id,
          userId: oldTask.userId,
          toDo: todo,
          completed: status,
        );
      }

      await TaskPrefs.saveTasks(currentTasks);

      emit(TaskUpdate(tasks: currentTasks, message: message));
      emit(TaskLoaded(currentTasks));
    } catch (e) {
      emit(TaskError("Failed to update task: $e"));
    }
  }

  Future<void> addTask({
    required int userId,
    required String todo,
    required bool status,
  }) async {
    try {
      final id = await taskRepoAbs.addTask(
        todo: todo,
        status: status,
        userId: userId,
      );

      final currentTasks = state is TaskLoaded
          ? List<TaskEntity>.from((state as TaskLoaded).tasks)
          : [TaskEntity(id: 0, userId: 0, toDo: "", completed: false)];
      currentTasks.add(
        TaskEntity(id: id, userId: userId, toDo: todo, completed: status),
      );

      await TaskPrefs.saveTasks(currentTasks);

      emit(AddTask(tasks: currentTasks, message: "Task Added Successfully"));
      emit(TaskLoaded(currentTasks));
    } catch (e) {
      emit(TaskError("Failed to add task: $e"));
    }
  }
}

