import '../../Domain/Entities/task_entity.dart';

class TaskModel {
  int id;
  int userId;
  String toDo;
  bool completed;

  TaskModel({
    required this.id,
    required this.userId,
    required this.toDo,
    required this.completed,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as int,
      userId: json['userId'] as int,
      toDo: json['todo'] as String,
      completed: json['completed'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'userId': userId, 'todo': toDo, 'completed': completed};
  }

  factory TaskModel.fromEntity(TaskEntity entity) {
    return TaskModel(
      id: entity.id,
      userId: entity.userId,
      toDo: entity.toDo,
      completed: entity.completed,
    );
  }

  TaskEntity toEntity() {
    return TaskEntity(id: id, userId: userId, toDo: toDo, completed: completed);
  }
}
