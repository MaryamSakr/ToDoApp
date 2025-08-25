
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/Features/home/Domain/Entities/task_entity.dart';
import 'package:todo/Features/home/Presentation/Cubit/task_cubit.dart';
import 'package:todo/Features/home/Presentation/Widgets/update_todo.dart';
import 'package:todo/constans/appSize.dart';
import 'package:todo/constans/colors.dart';

Widget TaskTile(TaskEntity task, BuildContext context) {
  return Padding(
    padding: EdgeInsets.all(5.0 * SizeConfig.verticalBlock),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: AppColors.secondary,
      ),
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.toDo,
              style: TextStyle(
                color: AppColors.fontColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5 * SizeConfig.verticalBlock),
            Text(
              task.completed == true ? "Completed" : "inProgress",
              style: TextStyle(
                color:
                task.completed == true
                    ? AppColors.completed
                    : AppColors.inProgress,
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blueAccent),
              onPressed: () {
                  showTaskDialog(
                    parentContext: context,
                    isUpdate: true,
                    task: task,
                    userId: task.userId,
                  );

              },
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.redAccent),
              onPressed: () {
                print(task.id);
                context.read<TaskCubit>().deleteTask(task.id);
              },
            ),
          ],
        ),
      ),
    ),
  );
}
