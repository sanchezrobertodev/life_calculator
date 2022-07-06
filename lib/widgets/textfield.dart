import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField {
  const CustomTextField({
    required this.controller,
    required this.focusNode,
    this.height = 60,
    this.width = 200,
    this.hintText,
    this.keyboardType,
  });
  final TextEditingController controller;
  final FocusNode focusNode;
  final double height;
  final double width;
  final String? hintText;
  final TextInputType? keyboardType;

  SizedBox textField() {
    return SizedBox(
      width: width,
      height: height,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: keyboardType ?? TextInputType.name,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(3),
        ],
        textAlign: TextAlign.start,
        style: const TextStyle(
          fontSize: 16,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 2)
          ),
          hintText: hintText ?? 'Your Name',
          focusColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
        ),
      ),
    );
  }
}