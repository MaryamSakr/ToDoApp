class TaskEntity{
  final int id;
  final int userId;
  final String toDo;
  final bool completed;

  TaskEntity({
    required this.id,
    required this.userId,
    required this.toDo,
    required this.completed,
  });
}