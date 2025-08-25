import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/Features/home/Domain/Entities/task_entity.dart';
import 'package:todo/Features/home/Presentation/Cubit/task_cubit.dart';
import 'package:todo/constans/appSize.dart';
import 'package:todo/constans/colors.dart';

void showTaskDialog({
  required BuildContext parentContext,
  bool isUpdate = false,
  TaskEntity? task,
  int userId = 1,
}) {
  final TextEditingController controller =
  TextEditingController(text: isUpdate ? task?.toDo : "");
  bool? isCompleted = isUpdate ? task?.completed : null;

  showDialog(
    context: parentContext,
    builder: (dialogContext) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            backgroundColor: AppColors.fontColor,
            title: Text(
              isUpdate ? "Update Task" : "Add Task",
              style:  TextStyle(color:AppColors.secondary ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Task",
                  ),
                ),
                SizedBox(height: 20 * SizeConfig.verticalBlock),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Task Status",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    RadioListTile<bool>(
                      value: true,
                      groupValue: isCompleted,
                      title: const Text("Completed"),
                      onChanged: (value) {
                        setState(() => isCompleted = value);
                      },
                    ),
                    RadioListTile<bool>(
                      value: false,
                      groupValue: isCompleted,
                      title: const Text("Pending"),
                      onChanged: (value) {
                        setState(() => isCompleted = value);
                      },
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  if (controller.text.isNotEmpty && isCompleted != null) {
                    if (isUpdate && task != null) {
                      parentContext.read<TaskCubit>().taskUpdate(
                        id: task.id,
                        todo: controller.text,
                        status: isCompleted!,
                      );
                      ScaffoldMessenger.of(parentContext).showSnackBar(
                        const SnackBar(
                          content: Text("Task Updated Successfully"),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else {

                      parentContext.read<TaskCubit>().addTask(
                        userId: userId,
                        todo: controller.text,
                        status: isCompleted!,
                      );
                      ScaffoldMessenger.of(parentContext).showSnackBar(
                        const SnackBar(
                          content: Text("Task Added Successfully"),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }

                    Navigator.pop(dialogContext);
                  } else {
                    ScaffoldMessenger.of(dialogContext).showSnackBar(
                      const SnackBar(
                        content: Text("Please enter task and select status"),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                child: Text(isUpdate ? "Update" : "Add"),
              ),
            ],
          );
        },
      );
    },
  );
}
