import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm/controller/custom_widgets/widgets.dart';
import 'package:ttpdm/controller/getx_controllers/login_user_controller.dart';
import 'package:ttpdm/controller/utils/apis_constant.dart';
import 'package:ttpdm/view/screens/auth_section/register_screen.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

import 'reset_otp.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  late LoginUserController loginUserController;
  late WebViewControllerPlus _controler;
  bool isCaptchaVerified = false;
  double webViewHeight = 400;

  @override
  void initState() {
    super.initState();
    loginUserController = Get.put(LoginUserController(context: context));
    _controler = WebViewControllerPlus()
      ..loadFlutterAssetServer('assets/webpages/index.html')
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..enableZoom(false)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(NavigationDelegate(
        onPageFinished: (url) {
          _controler.getWebViewHeight().then((value) {
            var height = int.parse(value.toString()).toDouble();
            if (height != 20.0) {
              setState(() {
                // Set the WebView height based on the content
              });
            }
          });
        },
      ));
    _controler.addJavaScriptChannel(
      'Captcha',
      onMessageReceived: (message) {
        final token = message.message;
        if (token.isNotEmpty) {
          log('Received reCAPTCHA token: $token');
          setState(() {
            isCaptchaVerified = true; // Update your verification state
          });
        }
      },
    );

    _controler.addJavaScriptChannel(
      'Captcha',
      onMessageReceived: (message) {
        if (message.message == 'verified') {
          setState(() {
            isCaptchaVerified = true;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f9fa),
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
                customTextFormField(controller: emailController),
                getVerticalSpace(1.6.h),
                Text(
                  'Password',
                  style: CustomTextStyles.hintTextStyle
                      .copyWith(color: const Color(0xff000000)),
                ),
                getVerticalSpace(.4.h),
                customTextFormField(controller: passwordController),
                getVerticalSpace(.6.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => ResetOtpScreen());
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
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: SizedBox(
                    height: 180,
                    child: WebViewWidget(
                      controller: _controler,
                    ),
                  ),
                ),
                getVerticalSpace(4.4.h),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      customElevatedButton(
                        title: loginUserController.isLoading.value == true
                            ? spinkit
                            : Text(
                                'Login ',
                                style: CustomTextStyles.buttonTextStyle
                                    .copyWith(color: AppColors.whiteColor),
                              ),
                        onTap: () {
                          if (emailController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please enter the email')),
                            );
                          } else if (passwordController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please enter the password')),
                            );
                          } else if (!isCaptchaVerified) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please complete the CAPTCHA')),
                            );
                          } else {
                            loginUserController.userLogin(
                                email: emailController.text,
                                password: passwordController.text);
                          }
                        },
                        bgColor: AppColors.mainColor,
                        verticalPadding: 1.2.h,
                        horizentalPadding: 4.8.h,
                      ),
                    ],
                  ),
                ),
                getVerticalSpace(1.2.h),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => RegisterScreen());
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
