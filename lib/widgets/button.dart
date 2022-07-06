import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomButton{
  const CustomButton({
    required this.text,
    this.height = 50,
    this.width = 125,
    this.onPressed,
    });
  final String text;
  final double height;
  final double width;
  final VoidCallback? onPressed;

  SizedBox elevatedButton(){
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            // side: const BorderSide(width: 2)
            ),
          )
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: CustomText(
            text: text,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            )
          ),
      ),
    );
  }
}