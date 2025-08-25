import 'package:flutter/material.dart';
import 'package:todo/app_routes.dart';

void main() {
  runApp(ToDoApp(appRoutes: AppRoutes(),));
}

class ToDoApp extends StatelessWidget {

  final AppRoutes appRoutes;

  ToDoApp({required this.appRoutes});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     onGenerateRoute: appRoutes.generateRoutes,
    );
  }
}

