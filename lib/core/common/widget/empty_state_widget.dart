import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../constants/app_colors.dart';

class EmptyStateWidget extends StatelessWidget {
  final String? svgPath;
  final IconData? icon;
  final String text;
  final double? iconSize;

  const EmptyStateWidget({
    super.key,
    this.svgPath,
    this.icon,
    required this.text,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (svgPath != null)
            SvgPicture.asset(
              svgPath!,
              width: iconSize ?? 80.w,
              height: iconSize ?? 80.h,
              colorFilter: const ColorFilter.mode(
                AppColors.grey,
                BlendMode.srcIn,
              ),
            )
          else if (icon != null)
            Icon(
              icon,
              size: iconSize ?? 80.sp,
              color: AppColors.grey,
            ),
          SizedBox(height: 16.h),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.grey,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
