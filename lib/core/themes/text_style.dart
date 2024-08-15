import 'package:flutter/material.dart';
import 'package:news_connect/core/themes/app_colors.dart';

class AppTextStyle {
  static TextStyle h1 = TextStyle(
    fontSize: 16.0,
    color: AppColors.primaryColor,
  );

  static TextStyle h1Bold = TextStyle(
    fontSize: 16.0,
    color: AppColors.primaryColor,
    fontWeight: FontWeight.bold,
  );

  static TextStyle h2 = TextStyle(
    fontSize: 14.0,
    color: AppColors.midGrey,
  );

  static TextStyle h2Bold = TextStyle(
    fontSize: 14.0,
    color: AppColors.midGrey,
    fontWeight: FontWeight.bold,
  );

  static TextStyle h3 = TextStyle(
    fontSize: 12.0,
    color: AppColors.lightGrey,
  );

  static TextStyle h3Bold = TextStyle(
    fontSize: 12.0,
    color: AppColors.lightGrey,
    fontWeight: FontWeight.bold,
  );

  static TextStyle labelStyle = const TextStyle(
    fontSize: 13.0,
    color: AppColors.black,
    letterSpacing: .7,
  );
  static TextStyle hintStyle = TextStyle(
    fontSize: 14.0,
    color: AppColors.midGrey,
  );

  static TextStyle buttonText = const TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );
  static TextStyle normalText = const TextStyle(
    fontSize: 13.0,
    color: AppColors.black,
  );
}
