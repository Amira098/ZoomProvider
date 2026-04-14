
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';

Widget buildGradientTextField({
  required String hint,
  bool obscureText = false,
}) {
  return Container(
    decoration: BoxDecoration(
      gradient:  LinearGradient(
        colors: [
          AppColors.pinkBlush,
          AppColors.rose,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.r),
    ),
    child: TextFormField(
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        filled: true,
        fillColor: Colors.transparent,
      ),
      style: TextStyle(color: Colors.black),
    ),
  );
}
