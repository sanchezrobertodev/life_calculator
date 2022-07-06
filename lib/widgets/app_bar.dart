import 'package:flutter/material.dart';
import 'package:life_calculator/utils/colors.dart';

import 'custom_text.dart';

class CustomAppBar{
  const CustomAppBar({
    Key? key,
    required this.title,
    this.icon
    });
  final String title;
  final Icon? icon;


  AppBar appBar() {
    return AppBar(
      title: Center(
        child: CustomText(
          text: title,
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        )),
      backgroundColor: AppColors().black,
      // actions: <Widget>[
      //   IconButton(
      //     icon: const Icon(Icons.light_mode),
      //     onPressed: () {print('Hey');},
      //   ),
      // ],
    );
  }
}

