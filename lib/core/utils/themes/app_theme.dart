import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/constants/fonts.dart';

import '../constants/colors.dart';

abstract class AppTheme {
  //? LIGHT THEME
  static ThemeData get lightTheme {
    return ThemeData(
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          overlayColor: const WidgetStatePropertyAll(ColorManager.offWhite),
          iconSize: WidgetStatePropertyAll(6.sp),
          alignment: Alignment.center,
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          )),
          backgroundColor: WidgetStatePropertyAll(
            ColorManager.offWhite.withOpacity(0.7),
          ),
        ),
      ),
      switchTheme: const SwitchThemeData(
        trackOutlineColor: WidgetStatePropertyAll(ColorManager.black),
        thumbColor: WidgetStatePropertyAll(ColorManager.black),
        trackColor: WidgetStatePropertyAll(ColorManager.white),
        thumbIcon: WidgetStatePropertyAll(
          Icon(
            Icons.light_mode,
            color: ColorManager.white,
          ),
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: ColorManager.orange,
        selectionColor: ColorManager.orange.withOpacity(0.3),
        selectionHandleColor: ColorManager.orange,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: ColorManager.black,
          elevation: 2,
          textStyle: TextStyle(
            fontFamily: FontFamilyManager.kQuicksand,
            fontSize: 3.7.sp,
            color: ColorManager.black,
            fontWeight: FontWeight.w600,
          ),
          overlayColor: ColorManager.white.withOpacity(0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: ColorManager.orange,
          fixedSize: Size(double.maxFinite, 35.h),
        ),
      ),
      iconTheme: IconThemeData(color: ColorManager.black, size: 7.sp),
      fontFamily: FontFamilyManager.kQuicksand,
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: ColorManager.offWhite,
      appBarTheme: AppBarTheme(
        toolbarHeight: kToolbarHeight.h,
        elevation: BorderSide.strokeAlignOutside,
        backgroundColor: ColorManager.darkGrey,
        shadowColor: ColorManager.black,
        centerTitle: false,
        iconTheme: const IconThemeData(color: ColorManager.black),
        titleTextStyle: TextStyle(
            color: ColorManager.black,
            fontSize: 20.spMin,
            fontWeight: FontWeight.w600),
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(
            fontSize: 7.sp,
            color: ColorManager.orange,
            fontWeight: FontWeight.bold),
        bodyMedium: TextStyle(
          fontSize: 4.sp,
          fontWeight: FontWeight.w500,
          color: ColorManager.orange,
        ),
        bodySmall: TextStyle(
            fontSize: 3.2.sp,
            color: ColorManager.orange,
            fontWeight: FontWeight.w500),
        displaySmall: TextStyle(
            fontSize: 3.25.sp,
            color: ColorManager.black,
            fontWeight: FontWeight.w500),
        displayMedium: TextStyle(
            fontSize: 4.sp,
            color: ColorManager.black,
            fontWeight: FontWeight.w500),
        displayLarge: TextStyle(
            fontSize: 7.sp,
            color: ColorManager.black,
            fontWeight: FontWeight.bold),
      ),
      inputDecorationTheme: InputDecorationTheme(
        isCollapsed: true,
        isDense: true,
        errorStyle:
            TextStyle(fontSize: 12.spMin, color: ColorManager.red, height: 0.5),
        hintStyle: TextStyle(fontSize: 12.spMin, color: ColorManager.grey),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          borderSide: BorderSide(
            width: 1.2,
            color: ColorManager.black,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          borderSide: BorderSide(
            width: 1.2,
            color: ColorManager.black,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          borderSide: BorderSide(
            width: 1.2,
            color: ColorManager.red,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          borderSide: BorderSide(
            width: 1.2,
            color: ColorManager.red,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 12.4.h, horizontal: 10),
        filled: true,
        fillColor: ColorManager.offWhite2.withOpacity(0.3),
      ),
    );
  }
}
