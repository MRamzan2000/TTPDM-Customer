import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm/controller/custom_widgets/widgets.dart';
import 'package:ttpdm/controller/getx_controllers/signup_user_controller.dart';
import 'package:ttpdm/controller/utils/apis_constant.dart';

import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
   RegisterScreen({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {

    final SignUpController signUpController=Get.put(SignUpController(context: context));
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.4.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getVerticalSpace(5.h),
                Align(alignment: Alignment.topCenter,
                  child: SizedBox(
                      height: 16.h,
                      width: 16.h,
                      child: pngImage('assets/pngs/logo.png')),
                ),
                getVerticalSpace(.8.h),
                Align(alignment: Alignment.topCenter,
                  child: Text(
                    'Sign up',
                    style: CustomTextStyles.onBoardingHeading,
                  ),
                ),
                getVerticalSpace(2.4.h),
                Text(
                  'Full Name',
                  style: TextStyle(
                      color: AppColors.blackColor,
                      fontSize: 14.px,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'regular'),
                ),
                getVerticalSpace(.4.h),
                customTextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name),
                getVerticalSpace(1.6.h),
                Text(
                  'Email Address',
                  style: TextStyle(
                      color: AppColors.blackColor,
                      fontSize: 14.px,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'regular'),
                ),
                getVerticalSpace(.4.h),
                customTextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress),
                getVerticalSpace(1.6.h),
                Text(
                  'Phone Number',
                  style: TextStyle(
                      color: AppColors.blackColor,
                      fontSize: 14.px,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'regular'),
                ),
                getVerticalSpace(.4.h),
                customTextFormField(
                    controller: phoneNumber,
                    keyboardType: TextInputType.phone),
                getVerticalSpace(1.6.h),
                Text(
                  'Enter Password',
                  style: TextStyle(
                      color: AppColors.blackColor,
                      fontSize: 14.px,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'regular'),
                ),
                getVerticalSpace(.4.h),
                customTextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword),
                getVerticalSpace(1.6.h),
                Text(
                  'Confirm Password',
                  style: TextStyle(
                      color: AppColors.blackColor,
                      fontSize: 14.px,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'regular'),
                ),
                getVerticalSpace(.4.h),
                customTextFormField(
                    controller: confirmPasswordController,
                    keyboardType: TextInputType.visiblePassword),
                getVerticalSpace(1.6.h),
                // Container(
                //   width: 24.2.h,
                //   height: 6.2.h,
                //   decoration: BoxDecoration(
                //     color: AppColors.textFieldGreyColor.withOpacity(0.2),
                //   ),
                //   child: Image.asset(
                //     'assets/pngs/capcha.png',
                //     fit: BoxFit.cover,
                //   ),
                // ),
                getVerticalSpace(2.4.h),
                Obx(() =>
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        customElevatedButton(
                          title: signUpController.isLoading.value == true
                              ? spinkit
                              : Text(
                            'Sign Up',
                            style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.whiteColor),
                          ),
                          onTap: () {
                            if (nameController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Please enter the name')),
                              );
                            } else if (emailController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Please enter the email')),
                              );
                            } else if (phoneNumber.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Please enter the phone number')),
                              );
                            } else if (!signUpController.isValidCanadianPhoneNumber(phoneNumber.text)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Please enter a valid Canadian phone number')),
                              );
                            } else if (passwordController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Please enter the password')),
                              );
                            } else if (confirmPasswordController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Please confirm your password')),
                              );
                            } else if (passwordController.text != confirmPasswordController.text) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Password and Confirm Password do not match')),
                              );
                            } else {
                              signUpController.userSignUp(
                                fullName: nameController.text,
                                email: emailController.text,
                                phoneNumber: phoneNumber.text,
                                password: passwordController.text,
                                confirmPassword: confirmPasswordController.text,
                                role: 'customer',
                              );
                            }
                          },
                          bgColor: AppColors.mainColor,
                          verticalPadding: 1.2.h,
                          horizentalPadding: 4.8.h,
                        ),
                      ],
                    ),


                ),
                getVerticalSpace(2.h),
                GestureDetector(
                  onTap: () {
                    Get.to(() =>  LoginScreen());
                  },
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: 'Already have a Account? ',
                          style: CustomTextStyles.buttonTextStyle.copyWith(
                              color: const Color(0xff444545), fontSize: 14.px)),
                      TextSpan(
                          text: 'Login',
                          style: CustomTextStyles.buttonTextStyle.copyWith(
                              color: AppColors.mainColor, fontSize: 16.px))
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
