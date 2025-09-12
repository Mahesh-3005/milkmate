import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hinttext;
  final int? maxlength;
  final TextInputType? type;
  const MyTextfield({super.key, required this.hinttext, required this.controller, this.maxlength, this.type});

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: type,
      controller: controller,
      cursorColor: Colors.grey[400],
      cursorHeight: 15.h,
      maxLength: maxlength,
      decoration: InputDecoration(
        counterText: '',
        hintText: hinttext,
        hintStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        filled: true, // Optional: adds background
        fillColor: Colors.grey.shade200, // Optional: background color
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
      ),
      style: TextStyle(fontSize: 16.sp), // Optional: font styling
    );
  }
}
