import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm/controller/custom_widgets/widgets.dart';
import 'package:ttpdm/view/screens/auth_section/create_new_password.dart';
import 'package:ttpdm/view/screens/auth_section/login_screen.dart';
import 'package:ttpdm/view/screens/auth_section/register_screen.dart';

class OtpVerification extends StatelessWidget {
  final String title;
  const OtpVerification({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.4.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                getVerticalSpace(12.h),
                Text(
                  'Enter the verification code',
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.onBoardingHeading
                      .copyWith(fontSize: 24.px),
                ),
                getVerticalSpace(1.2.h),
                Text(
                  'We have just sent you a 4-digit code on example@gmail.com',
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.onBoardingLight.copyWith(
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.px,
                      fontFamily: 'bold'),
                ),
                getVerticalSpace(5.2.h),
                OtpTextField(
                  textStyle: TextStyle(
                      fontSize: 24.px,
                      color: const Color(0xff4D4F53),
                      fontWeight: FontWeight.w700,
                      fontFamily: 'bold'),
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  enabledBorderColor: Colors.transparent,
                  focusedBorderColor: AppColors.mainColor,
                  fieldHeight: 6.h,
                  fieldWidth: 6.h,
                  margin: EdgeInsets.symmetric(horizontal: 2.h),
                  borderColor: Colors.transparent,
                  filled: true,
                  fillColor: const Color(0xffF3F3F3),
                ),
                getVerticalSpace(4.2.h),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: customElevatedButton(
                      title: 'Next ',
                      bgColor: AppColors.mainColor,
                      onTap: () {
                        if(title=='resetpassword'){
                          Get.to(() => const CreateNewPassword());

                        }else{
                          Get.to(() => const LoginScreen());

                        }
                      },
                      horizentalPadding: 5.9.h,
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
                          text: "Didn't receive?",
                          style: CustomTextStyles.buttonTextStyle.copyWith(
                              color: const Color(0xff444545), fontSize: 14.px)),
                      TextSpan(
                        text: '\n           59',
                        style: CustomTextStyles.buttonTextStyle.copyWith(
                          color: AppColors.mainColor,
                          fontSize: 14.px,
                        ),
                      ),
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
