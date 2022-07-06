import 'package:flutter/material.dart';
import 'package:life_calculator/utils/colors.dart';

Widget dotLife(){
  return Container(
    // duration: const Duration(seconds: 2),
    height: 10,
    width: 10,
    // curve: Curves.easeInOut,
    decoration: BoxDecoration(
      color: AppColors().dot,
      shape: BoxShape.circle,
    ),
  );
}

Widget dotUsed(){
  return Container(
    // duration: const Duration(seconds: 2),
    height: 10,
    width: 10,
    // curve: Curves.easeInOut,
    decoration: BoxDecoration(
      color: AppColors().dotUsed,
      shape: BoxShape.circle,
    ),
  );
}
