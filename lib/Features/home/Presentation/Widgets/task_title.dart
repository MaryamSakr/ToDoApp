import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/constans/appSize.dart';
import 'package:todo/constans/colors.dart';
import 'package:todo/constans/routes.dart';

class TasksHeaderRow extends StatelessWidget {
  const TasksHeaderRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Tasks",
          style: TextStyle(
            color: AppColors.fontColor,
            fontSize: 20 * SizeConfig.textRatio,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, tasks);
          },
          child: Text(
            "See More",
            style: TextStyle(
              color: AppColors.fontColor,
              fontSize: 14 * SizeConfig.textRatio,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
