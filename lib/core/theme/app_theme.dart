import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../constants/app_fonts_family.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        splashColor: AppColors.skyBlue[AppColors.colorCode10],
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.skyBlue[AppColors.colorCode50]),
    scaffoldBackgroundColor: AppColors.white,
    primaryColor: AppColors.skyBlue[AppColors.colorCode50],
    secondaryHeaderColor: AppColors.black,
    fontFamily: GoogleFonts.cairo().fontFamily,
    dialogTheme: DialogThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      backgroundColor: AppColors.white,
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: AppColors.navy,
        fontWeight: FontWeight.w700,
        fontSize: 32.sp,
      ),
      titleMedium: TextStyle(
          color: AppColors.black,
          fontWeight: FontWeight.w500,
          fontSize: 20.sp),
      titleSmall: TextStyle(
          color: AppColors.black, fontWeight: FontWeight.w400, fontSize: 20.sp),
      labelLarge: TextStyle(
          color: AppColors.darkskyBlue,
          fontWeight: FontWeight.w500,
          fontSize: 24.sp),
      labelMedium: TextStyle(
          color: AppColors.rose, fontWeight: FontWeight.w500, fontSize: 12.sp),
      labelSmall: TextStyle(
          color: AppColors.black, fontWeight: FontWeight.w700, fontSize: 12.sp),
      bodyLarge: TextStyle(
          color: AppColors.darkRed, fontWeight: FontWeight.w500, fontSize: 18.sp),
      bodyMedium: TextStyle(
          color: AppColors.black,
          fontWeight: FontWeight.w700,
          fontSize: 25.sp),
      bodySmall: TextStyle(
          color: AppColors.grey500, fontWeight: FontWeight.w400, fontSize: 14.sp),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppColors.blue,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor:
        WidgetStateProperty.all(AppColors.blue),
        foregroundColor: WidgetStateProperty.all(AppColors.white),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10000),
          ),
        ),
        elevation: WidgetStateProperty.all(0),
        textStyle: WidgetStateProperty.all(
          TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
            color: AppColors.white,
          ),
        ),
        padding: WidgetStateProperty.all(
          EdgeInsets.all(14.w),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      errorStyle: TextStyle(
          color: AppColors.grey300,
          fontSize: 8.sp,
          fontStyle: FontStyle.italic),
      contentPadding: EdgeInsets.all(16.w),
      iconColor: AppColors.blue,
      hintStyle: TextStyle(
        color: AppColors.black26,
        fontSize: 14.sp,
      ),
      prefixIconColor: AppColors.black,
      suffixIconColor: AppColors.black,
      labelStyle: TextStyle(
        fontSize: 12.sp,
        color: AppColors.black38,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.r),
        borderSide: const BorderSide(
          width: 1,
          color: AppColors.black,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.r),
        borderSide: const BorderSide(
          width: 1,
          color: AppColors.black,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.r),
        borderSide: const BorderSide(
          width: 1,
          color: AppColors.black,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.r),
        borderSide: const BorderSide(
          width: 1,
          color: AppColors.red,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.r),
        borderSide: const BorderSide(
          width: 1,
          color: AppColors.red,
        ),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.black,
      surfaceTintColor: AppColors.white,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.black,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        foregroundColor:
        WidgetStateProperty.all(AppColors.blue),
        textStyle: WidgetStateProperty.all(
          TextStyle(
            decoration: TextDecoration.underline,
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
            color: AppColors.white,
          ),
        ),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
            (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return TextStyle(
                color: AppColors.blue,
                fontWeight: FontWeight.w600);
          }
          return TextStyle(
              color: AppColors.black26, fontWeight: FontWeight.w500);
        },
      ),
      elevation: 0,
      backgroundColor: AppColors.blue,
      surfaceTintColor: AppColors.blue,
      iconTheme: WidgetStateProperty.all(
        const IconThemeData(color: AppColors.blue),
      ),
      indicatorColor: AppColors.blue,
    ),
    radioTheme: RadioThemeData(
        fillColor:
        WidgetStatePropertyAll((AppColors.blue)),
        overlayColor:
        WidgetStatePropertyAll(AppColors.blue)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      selectedItemColor: AppColors.skyBlue[AppColors.colorCode50],
      showSelectedLabels: true,
      showUnselectedLabels: true,
      unselectedItemColor: AppColors.gray,
      selectedLabelStyle: TextStyle(
        fontSize: 14.sp,
        color: AppColors.skyBlue[AppColors.colorCode50],
        fontWeight: FontWeight.bold,
        fontFamily: GoogleFonts.cairo().fontFamily,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 14.sp,
        color: AppColors.gray,
        fontFamily: GoogleFonts.cairo().fontFamily,
      ),
    ),
    tabBarTheme: TabBarThemeData(
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: AppColors.skyBlue[AppColors.colorCode50],
      unselectedLabelColor: AppColors.white,
      dividerColor: Colors.transparent,
      labelStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16.sp,
      ),
      unselectedLabelStyle:
      TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp),
      indicator: UnderlineTabIndicator(
        insets: EdgeInsets.zero,
        borderSide: BorderSide(
            width: 3.w, color: AppColors.skyBlue[AppColors.colorCode50]!),
      ),
      labelPadding: EdgeInsets.only(right: 24.w),
      tabAlignment: TabAlignment.start,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      backgroundColor: AppColors.white,
      dragHandleSize: Size(80.w, 4.h),
      dragHandleColor: AppColors.black,
      showDragHandle: true,
      elevation: 0,
    ),
  );
}

// isScrollable: true,
//
//       unselectedLabelStyle: Theme.of(context).textTheme.titleSmall!,
//       dividerColor: Colors.transparent,
