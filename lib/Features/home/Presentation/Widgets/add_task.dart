import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/Features/home/Presentation/Widgets/update_todo.dart';
import 'package:todo/constans/appSize.dart';
import 'package:todo/constans/colors.dart';

class PositionedAddTaskButton extends StatelessWidget {
  const PositionedAddTaskButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20 * SizeConfig.verticalBlock,
      right: 20 * SizeConfig.horizontalBlock,
      child: FloatingActionButton(
        backgroundColor: AppColors.fontColor,
        onPressed: () {
          showTaskDialog(
            parentContext: context,
            isUpdate: false,
          );
        },
        child: Icon(
          CupertinoIcons.add,
          color: AppColors.secondary,
          size: 30 * SizeConfig.textRatio,
        ),
      ),
    );
  }
}
