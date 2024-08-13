import 'package:flutter/material.dart';
import 'package:news_connect/core/themes/app_colors.dart';
import 'package:news_connect/core/themes/text_style.dart';

class AppTheme {
  static final ThemeData themeData = ThemeData(
    useMaterial3: false,
    scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,

    ///
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.white,
      iconTheme: IconThemeData(
        color: AppColors.primaryColor,
      ),
      actionsIconTheme: IconThemeData(
        color: AppColors.primaryColor,
      ),
    ),

    ///
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.primaryColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      fillColor: AppColors.textFillColor,
      filled: true,
      hintStyle: AppTextStyle.hintStyle,
      contentPadding: const EdgeInsets.all(14),
    ),

    ///
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.white,
        backgroundColor: AppColors.primaryColor,
        disabledForegroundColor: AppColors.darkGrey,
        minimumSize: const Size(double.maxFinite, 36),
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        disabledBackgroundColor: AppColors.textFillColor,
        textStyle: AppTextStyle.buttonText,
      ),
    ),

    ///
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryColor,
        disabledForegroundColor: AppColors.darkGrey,
        disabledBackgroundColor: AppColors.textFillColor,
        textStyle: AppTextStyle.buttonText.copyWith(color: AppColors.white),
        side: BorderSide(color: AppColors.primaryColor),
        minimumSize: const Size(double.maxFinite, 36),
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    ),

    ///
  );
}
