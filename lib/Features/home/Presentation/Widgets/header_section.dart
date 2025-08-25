import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/constans/appSize.dart';
import 'package:todo/constans/colors.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Hello In Our To Do List App",
          style: TextStyle(
            color: AppColors.fontColor,
            fontSize: 25 * SizeConfig.textRatio,
            fontWeight: FontWeight.bold,
          ),
        ),
        Icon(
          Icons.note_alt_outlined,
          color: AppColors.fontColor,
        ),
      ],
    );
  }
}
