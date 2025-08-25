import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/constans/appSize.dart';
import 'package:todo/constans/colors.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(10.0 * SizeConfig.verticalBlock),
      child: AppBar(
        automaticallyImplyLeading: false,
        title: Text("MY TODO" , style: TextStyle(color: AppColors.fontColor , fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
