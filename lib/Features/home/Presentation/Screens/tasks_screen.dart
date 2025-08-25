import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/Common/my_app_bar.dart';
import 'package:todo/Features/home/Domain/Entities/task_entity.dart';
import 'package:todo/Features/home/Presentation/Cubit/task_cubit.dart';
import 'package:todo/constans/appSize.dart';
import 'package:todo/constans/colors.dart';
import '../Widgets/update_todo.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    context.read<TaskCubit>().loadTasks(isInitial: true);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      context.read<TaskCubit>().loadTasks();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primary,
        appBar: const MyAppBar(),
        body: BlocConsumer<TaskCubit, TaskState>(
      listener: (context, state) {
        if (state is TaskDeleted) {
          print(state.message);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is TaskError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is TaskLoading &&
            context.read<TaskCubit>().tasks.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          );
        } else if (state is TaskLoaded) {
          final tasks = state.tasks;
          return GridView.builder(
            controller: _scrollController,
            padding: EdgeInsets.all(8 * SizeConfig.horizontalBlock),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1.2,
            ),
            itemCount: tasks.length + 1,
            itemBuilder: (context, index) {
              if (index < tasks.length) {
                return TaskCard(tasks[index], context);
              } else {
                return context.read<TaskCubit>().hasMore
                    ? const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.white,
                    ),
                  ),
                )
                    : const SizedBox();
              }
            },
          );
        } else if (state is TaskError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox();
      },
      ),

      ),
    );
  }
}

Widget TaskCard(TaskEntity task, BuildContext context) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    color: AppColors.secondary,
    elevation: 4,
    child: Padding(
      padding: EdgeInsets.only(
        top: 12 * SizeConfig.horizontalBlock,
        left: 12 * SizeConfig.horizontalBlock,
        right: 12 * SizeConfig.horizontalBlock,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Task Title
          Text(
            task.toDo,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.fontColor,
              fontWeight: FontWeight.bold,
              fontSize: 16 * SizeConfig.textRatio,
            ),
          ),

          SizedBox(height: 10 * SizeConfig.verticalBlock),

          /// Status + Icon Row
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.completed ? "Completed" : "Pending",
                style: TextStyle(
                  color: task.completed ? Colors.greenAccent : Colors.redAccent,
                  fontSize: 13 * SizeConfig.textRatio,
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
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
                      context.read<TaskCubit>().deleteTask(task.id);
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
