import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm/controller/custom_widgets/widgets.dart';
import 'package:ttpdm/view/screens/auth_section/login_screen.dart';

class CreateNewPassword extends StatelessWidget {
  const CreateNewPassword({super.key});

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
                  'Create a new password',
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.onBoardingHeading
                      .copyWith(fontSize: 24.px),
                ),
                getVerticalSpace(1.2.h),
                Text(
                  "Your new password must be different from previous used passwords.",
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.onBoardingLight.copyWith(
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.px,
                      fontFamily: 'bold'),
                ),
                getVerticalSpace(4.h),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Enter Password',
                    style: CustomTextStyles.hintTextStyle
                        .copyWith(color: const Color(0xff000000)),
                  ),
                ),
                getVerticalSpace(.4.h),
                customTextFormField(),
                getVerticalSpace(1.6.h),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Confirm Password',
                    style: CustomTextStyles.hintTextStyle
                        .copyWith(color: const Color(0xff000000)),
                  ),
                ),
                getVerticalSpace(.4.h),
                customTextFormField(),
                getVerticalSpace(2.4.h),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: customElevatedButton(
                      title: 'Save ',
                      bgColor: AppColors.mainColor,
                      onTap: () {
                        Get.to(()=>const LoginScreen());
                      },
                      horizentalPadding: 5.9.h,
                      verticalPadding: 1.2.h),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
