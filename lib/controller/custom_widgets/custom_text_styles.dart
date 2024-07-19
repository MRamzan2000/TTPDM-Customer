import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm/controller/custom_widgets/app_colors.dart';

class CustomTextStyles {
  static TextStyle onBoardingHeading = TextStyle(
      fontSize: 30.px,
      fontFamily: 'bold',
      color: AppColors.mainColor,
      fontWeight: FontWeight.w700);
  static TextStyle onBoardingLight = TextStyle(
      fontSize: 16.px,
      fontFamily: 'light',
      color: AppColors.onBoardingTextColor,
      fontWeight: FontWeight.w400);
  static TextStyle buttonTextStyle = TextStyle(
      fontSize: 16.px,
      fontFamily: 'regular',
      color: AppColors.whiteColor,
      fontWeight: FontWeight.w400);
  static TextStyle hintTextStyle = TextStyle(
      fontSize: 14.px,
      fontFamily: 'regular',
      color: AppColors.textFieldTextColor,
      fontWeight: FontWeight.w400);
}
