import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo/Features/home/Data/remote_data_source/task_remote_datasource.dart';
import 'package:todo/Features/home/Domain/task_repo/task_repo_abs.dart';
import 'package:todo/Features/home/Data/task_repo_impl/task_repo_Impl.dart';
import 'package:todo/Features/home/Presentation/Cubit/task_cubit.dart';
import 'package:todo/Features/home/Presentation/Screens/HomeScreen.dart';
import 'package:todo/Features/home/Presentation/Screens/tasks_screen.dart';
import 'constans/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AppRoutes{
  late TaskRepoAbs taskRepoAbs;
  late TaskCubit taskCubit;


  AppRoutes(){
    final client = http.Client();
   taskRepoAbs = TaskRepoImpl(TaskRemoteDataSource(client:client));
   taskCubit = TaskCubit(taskRepoAbs);
  }

  Route? generateRoutes(RouteSettings settings){
    switch(settings.name){
      case home:
        return MaterialPageRoute(builder: (_) => BlocProvider(
          create: (context) => TaskCubit(taskRepoAbs),
          child: HomeScreen(),
        ));
      case tasks:
        return MaterialPageRoute(builder: (_) => BlocProvider(
          create: (context) => TaskCubit(taskRepoAbs),
          child: TasksScreen(),
        ));

    }
  }
}