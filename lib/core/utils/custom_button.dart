import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/app_colors.dart' show AppColors;
import '../constants/app_fonts_family.dart';
import 'custom_text.dart';
class CustomButton extends StatelessWidget {
  final Color btnColor;
  final double btnWidth;
  final double btnHeight;
  final VoidCallback onTap;
  final String text;
  final TextStyle? styleFromTheme;

  const CustomButton({
    super.key,
    required this.btnColor,
    required this.btnWidth,
    required this.btnHeight,
    required this.onTap,
    required this.text,
    this.styleFromTheme,  Widget? child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: btnWidth,
        height: btnHeight,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: CustomText(
          text,
          style: styleFromTheme ?? Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}



class CustomImageButton extends StatelessWidget {
  final VoidCallback onTap;
  final String image;
  Color? btnColor, imageColor, borderColor;
  final double? btnWidth, borderWidth, borderRadius;
  final EdgeInsets? padding;

  CustomImageButton(
      {super.key, required this.onTap,
      this.btnColor,
      this.imageColor,
      required this.image,
      this.borderColor,
      this.borderWidth,
      this.btnWidth,
      this.borderRadius,
      this.padding});

  @override
  Widget build(BuildContext context) {
    if (btnColor == null) btnColor = AppColors.blue;
    if (imageColor == null) imageColor = AppColors.black;
    if (borderColor == null) borderColor = btnColor;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: btnWidth == null ? double.infinity : btnWidth,
        padding: padding ?? EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: btnColor,
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 24)),
            border: Border.all(
                width: borderWidth == null ? 1 : borderWidth!,
                color: borderColor!)),
        child: Center(
          child: SvgPicture.asset(
            image,
            fit: BoxFit.cover,
            color: imageColor,
          ),
        ),
      ),
    );
  }
}
