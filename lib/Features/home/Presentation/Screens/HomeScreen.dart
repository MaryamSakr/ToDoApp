import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/Features/home/Domain/Entities/task_entity.dart';
import 'package:todo/Features/home/Presentation/Cubit/task_cubit.dart';
import 'package:todo/Features/home/Presentation/Widgets/header_section.dart';
import 'package:todo/Features/home/Presentation/Widgets/task_list.dart';
import 'package:todo/Features/home/Presentation/Widgets/task_title.dart';
import 'package:todo/Features/home/Presentation/Widgets/add_task.dart';
import 'package:todo/constans/appSize.dart';
import 'package:todo/constans/colors.dart';
import '../../../../Common/my_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<TaskEntity> allTasks;

  @override
  void initState() {
    super.initState();
    context.read<TaskCubit>().getFirst5Tasks();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primary,
        appBar: MyAppBar(),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20 * SizeConfig.horizontalBlock,
                vertical: 15 * SizeConfig.verticalBlock,
              ),
              child: Stack(
                children: [
                  Column(
                    children: [
                      HeaderSection(),
                      SizedBox(height: 40 * SizeConfig.verticalBlock),
                      TasksHeaderRow(),
                      SizedBox(height: 10 * SizeConfig.verticalBlock),
                      SizedBox(
                        height: 600 * SizeConfig.verticalBlock,
                        child: TasksList(),
                      ),
                    ],
                  ),
                  PositionedAddTaskButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
