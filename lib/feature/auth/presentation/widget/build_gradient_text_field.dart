
import 'package:flutter/material.dart';

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
      borderRadius: BorderRadius.circular(12),
    ),
    child: TextFormField(
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        filled: true,
        fillColor: Colors.transparent,
      ),
      style: const TextStyle(color: Colors.black),
    ),
  );
}
