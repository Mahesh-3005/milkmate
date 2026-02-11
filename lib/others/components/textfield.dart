import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hinttext;
  final int? maxlength;
  final TextInputType? type;
  final bool obscureText;
  final Widget? suffixicon;
  const MyTextfield({super.key, required this.hinttext, required this.controller, this.maxlength, this.type, this.obscureText = false, this.suffixicon});

  @override
  Widget build(BuildContext context) {
    return 

    TextField(
  controller: controller,
  keyboardType: type,
  obscureText: obscureText,
  maxLength: maxlength,

  cursorColor: Colors.grey[400],
  style: TextStyle(
    fontSize: 16.sp,
    height: 1.2, // 🔥 keeps text vertically balanced
  ),

  decoration: InputDecoration(
    counterText: '',
    hintText: hinttext,
    hintStyle: TextStyle(color: Colors.grey),

    /// ✅ FIX: use suffixIcon
    suffixIcon: suffixicon != null
        ? Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: suffixicon,
          )
        : null,

    filled: true,
    fillColor: Colors.grey.shade200,

    /// 🔥 KEY FIX
    contentPadding: EdgeInsets.symmetric(
      horizontal: 16.w,
      vertical: 16.h,
    ),

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
  ),
);
    // TextField(
    //   keyboardType: type,
    //   controller: controller,
    //   cursorColor: Colors.grey[400],
    //   cursorHeight: 15.h,
    //   maxLength: maxlength,
    //   obscureText: obscureText,
    //   decoration: InputDecoration(
    //     suffix: suffixicon,
    //     counterText: '',
    //     hintText: hinttext,
    //     hintStyle: TextStyle(color: Colors.grey),
    //     border: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(12),
    //       borderSide: BorderSide.none,
    //     ),
    //     enabledBorder: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(12),
    //       borderSide: BorderSide.none,
    //     ),
    //     focusedBorder: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(12),
    //       borderSide: BorderSide.none,
    //     ),
    //     filled: true, // Optional: adds background
    //     fillColor: Colors.grey.shade200, // Optional: background color
    //     contentPadding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 8.h),
    //   ),
    //   style: TextStyle(fontSize: 16.sp), // Optional: font styling
    // );
  }
}
