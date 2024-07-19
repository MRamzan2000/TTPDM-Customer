import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm/controller/custom_widgets/widgets.dart';
import 'package:ttpdm/view/screens/auth_section/register_screen.dart';

import '../bottom_navigationbar.dart';
import 'reset_otp.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.7.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getVerticalSpace(8.h),
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                      height: 16.h,
                      width: 16.h,
                      child: pngImage('assets/pngs/logo.png')),
                ),
                getVerticalSpace(.8.h),
                Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Login',
                      style: CustomTextStyles.onBoardingHeading,
                    )),
                getVerticalSpace(1.6.h),
                Text(
                  'Email Address',
                  style: CustomTextStyles.hintTextStyle
                      .copyWith(color: const Color(0xff000000)),
                ),
                getVerticalSpace(.4.h),
                customTextFormField(),
                getVerticalSpace(1.6.h),
                Text(
                  'Password',
                  style: CustomTextStyles.hintTextStyle
                      .copyWith(color: const Color(0xff000000)),
                ),
                getVerticalSpace(.4.h),
                customTextFormField(),
                getVerticalSpace(.6.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(onTap: (){
                    Get.to(()=>const ResetOtpScreen());
                  },
                    child: Text(
                      'Forgot Password',
                      style: TextStyle(
                          fontSize: 14.px,
                          color: AppColors.mainColor,
                          fontFamily: 'italic',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                getVerticalSpace(1.6.h),
                Container(
                  width: 24.2.h,
                  height: 6.2.h,
                  decoration: BoxDecoration(
                    color: AppColors.textFieldGreyColor.withOpacity(0.2),
                  ),
                  child: Image.asset(
                    'assets/pngs/capcha.png',
                    fit: BoxFit.cover,
                  ),
                ),
                getVerticalSpace(4.4.h),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: customElevatedButton(
                      title: 'Login ',
                      bgColor: AppColors.mainColor,
                      onTap: () {
                        Get.to(() =>  const CustomBottomNavigationBar());
                      },
                      horizentalPadding: 5.6.h,
                      verticalPadding: 1.2.h),
                ),
                getVerticalSpace(1.2.h),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() =>  RegisterScreen());
                    },
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: 'Don’t have an account? ',
                          style: CustomTextStyles.buttonTextStyle.copyWith(
                              color: const Color(0xff444545), fontSize: 14.px)),
                      TextSpan(
                          text: 'Sign Up',
                          style: CustomTextStyles.buttonTextStyle.copyWith(
                              color: AppColors.mainColor, fontSize: 14.px))
                    ])),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
