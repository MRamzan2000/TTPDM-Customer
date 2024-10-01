import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm/controller/custom_widgets/widgets.dart';
import 'package:ttpdm/controller/getx_controllers/signup_user_controller.dart';
import 'package:ttpdm/controller/utils/apis_constant.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController phoneNumber = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController = TextEditingController();
  bool isCaptchaVerified = false;
  double webViewHeight = 400;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final SignUpController signUpController = Get.put(SignUpController(context: context));
    return Scaffold(
      backgroundColor: const Color(0xfff8f9fa),
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
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(height: 16.h, width: 16.h, child: pngImage('assets/pngs/logo.png')),
                ),
                getVerticalSpace(.8.h),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Sign up',
                    style: CustomTextStyles.onBoardingHeading,
                  ),
                ),
                getVerticalSpace(2.4.h),
                Text(
                  'Full Name',
                  style: TextStyle(color: AppColors.blackColor, fontSize: 14.px, fontWeight: FontWeight.w400, fontFamily: 'regular'),
                ),
                getVerticalSpace(.4.h),
                customTextFormField(controller: nameController, keyboardType: TextInputType.name),
                getVerticalSpace(1.6.h),
                Text(
                  'Email Address',
                  style: TextStyle(color: AppColors.blackColor, fontSize: 14.px, fontWeight: FontWeight.w400, fontFamily: 'regular'),
                ),
                getVerticalSpace(.4.h),
                customTextFormField(controller: emailController, keyboardType: TextInputType.emailAddress),
                getVerticalSpace(1.6.h),
                Text(
                  'Phone Number',
                  style: TextStyle(color: AppColors.blackColor, fontSize: 14.px, fontWeight: FontWeight.w400, fontFamily: 'regular'),
                ),
                getVerticalSpace(.4.h),
                customTextFormField(controller: phoneNumber, keyboardType: TextInputType.phone),
                getVerticalSpace(1.6.h),
                Text(
                  'Enter Password',
                  style: TextStyle(color: AppColors.blackColor, fontSize: 14.px, fontWeight: FontWeight.w400, fontFamily: 'regular'),
                ),
                getVerticalSpace(.4.h),
                customTextFormField(controller: passwordController, keyboardType: TextInputType.visiblePassword),
                getVerticalSpace(1.6.h),
                Text(
                  'Confirm Password',
                  style: TextStyle(color: AppColors.blackColor, fontSize: 14.px, fontWeight: FontWeight.w400, fontFamily: 'regular'),
                ),
                getVerticalSpace(.4.h),
                customTextFormField(controller: confirmPasswordController, keyboardType: TextInputType.visiblePassword),
                getVerticalSpace(1.6.h),
                getVerticalSpace(2.4.h),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                          } else if (!isCaptchaVerified) {
                            showWebViewDialog(context, webViewHeight);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Success')),
                            );
                            // signUpController.userSignUp(
                            //   fullName: nameController.text,
                            //   email: emailController.text,
                            //   phoneNumber: phoneNumber.text,
                            //   password: passwordController.text,
                            //   confirmPassword: confirmPasswordController.text,
                            //   role: 'customer',
                            // );
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
                    Get.to(() => const LoginScreen());
                  },
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: 'Already have a Account? ',
                              style: CustomTextStyles.buttonTextStyle.copyWith(color: const Color(0xff444545), fontSize: 14.px)),
                          TextSpan(text: 'Login', style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.mainColor, fontSize: 16.px))
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showWebViewDialog(BuildContext context, double webViewHeight) {
    late WebViewControllerPlus controller; // Declare controller locally

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            // Initialize the WebView controller here
            controller = WebViewControllerPlus()
              ..loadFlutterAssetServer('assets/webpages/index.html')
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..enableZoom(false)
              ..setBackgroundColor(const Color(0x00000000))
              ..setNavigationDelegate(NavigationDelegate(
                onPageFinished: (url) {
                  controller.getWebViewHeight().then((value) {
                    var height = int.parse(value.toString()).toDouble();
                    if (height != 20.0) {
                      setState(() {
                        // Optionally, adjust webViewHeight here if needed
                      });
                    }
                  });
                },
              ));

            // Add JavaScript channel for reCAPTCHA token
            controller.addJavaScriptChannel(
              'Captcha',
              onMessageReceived: (message) {
                final token = message.message;
                if (token.isNotEmpty) {
                  log('Received reCAPTCHA token: $token');
                  setState(() {
                    isCaptchaVerified = true;
                  });
                }
              },
            );

            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.6,
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 5.px, horizontal: 10.px),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Close",
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                            Icon(Icons.close),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: WebViewWidget(controller: controller),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    ).then((value) {
      setState(() {
        isCaptchaVerified = false; // Reset the verification state if needed
      });
    });
  }
}
