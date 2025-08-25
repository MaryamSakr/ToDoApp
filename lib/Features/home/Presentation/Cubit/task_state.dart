part of 'task_cubit.dart';

@immutable
sealed class TaskState {}

final class TaskInitial extends TaskState {}
final class TaskLoading extends TaskState {}


final class TaskLoaded extends TaskState {
  final List<TaskEntity> tasks;
  TaskLoaded(this.tasks);
}

final class TaskDeleted extends TaskState {
  final List<dynamic> tasks;
  final String message;

  TaskDeleted({required this.tasks, required this.message});
}

final class TaskUpdate extends TaskState {
  final List<dynamic> tasks;
  final String message;

  TaskUpdate({required this.tasks, required this.message});
}

final class AddTask extends TaskState {
  final List<dynamic> tasks;
  final String message;

  AddTask({required this.tasks, required this.message});
}

class TaskError extends TaskState {
  final String message;
  TaskError(this.message);
}

class TaskSuccess extends TaskState {
  final String message;
  TaskSuccess(this.message);
}