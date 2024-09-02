import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'app_colors.dart';
import 'custom_text_styles.dart';

//get height
Widget getVerticalSpace(double height) {
  return SizedBox(
    height: height,
  );
}

//get width
Widget getHorizentalSpace(double width) {
  return SizedBox(
    width: width,
  );
}

//used svg
Widget svgImage(String path,{Color? color,double? height}) {
  return SvgPicture.asset(path,fit: BoxFit.cover,color:color ,height:height ,);
}

//used png
Widget pngImage(String name) {
  return Image.asset(name);
}

//Custom Elevated Button
Widget customElevatedButton(
    {Callback? onTap,
    required Widget title,
    Color? bgColor,
    double? horizentalPadding,
    double? verticalPadding,
    double? borderRadius,
    Color? titleColor}) {
  return ElevatedButton(
    onPressed: onTap,
    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(bgColor)),
    child: Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizentalPadding ?? 6.h,
          vertical: verticalPadding ?? 1.h),
      child: title
    ),
  );
}

//CustomTextFormField

Widget customTextFormField({
  String? title,
  TextEditingController? controller,
  TextInputType? keyboardType,
  int? maxLine,
  String? errorText,
  Color? focusBorderColor,
  Color? bgColor,
  Color? borderColor,
  String? prefix,
  Widget? prefixIcons,
  bool? readOnly,
  Callback? onTap
}) {
  return TextFormField(
    cursorColor:AppColors.mainColor,
    onTap: onTap,
    readOnly:readOnly??false ,
    maxLines: maxLine??1,
    keyboardType: keyboardType,
    controller: controller,
    decoration: InputDecoration(
      hintText: title,
     prefixText:prefix ,
      prefixStyle: TextStyle(
        fontWeight: FontWeight.w500,
        color: const Color(0xff292D32),
        fontFamily: 'bold',
        fontSize: 16.px,

      ),
      hintStyle: CustomTextStyles.hintTextStyle,
      isCollapsed: true,
      labelText: errorText,
      labelStyle: TextStyle(
        fontSize: 15.sp,
        color:AppColors.mainColor,
        fontWeight: FontWeight.w400,
        fontFamily: 'regular',
      ),

      prefixIcon: prefixIcons,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: focusBorderColor ?? Colors.transparent),
        borderRadius: BorderRadius.circular(1.h),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide:  BorderSide(color:borderColor?? Colors.transparent),
        borderRadius: BorderRadius.circular(1.h),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(1.h),
        borderSide: const BorderSide(color: Colors.transparent),
      ),
      filled: true,
      fillColor: bgColor ?? AppColors.textFieldGreyColor,
      contentPadding: EdgeInsets.symmetric(horizontal: 1.6.h, vertical: 1.h),
    ),
  );
}
