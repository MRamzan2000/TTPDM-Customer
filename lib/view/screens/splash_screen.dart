import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm/controller/custom_widgets/widgets.dart';
import 'package:ttpdm/view/screens/onboarding_section/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 5)).then(
      (value) => Get.to(() => const OnBoardingScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FA),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.0.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                getVerticalSpace(6.5.h),
                SizedBox(
                    height: 24.h,
                    width: 24.h,
                    child: Image.asset('assets/pngs/logo.png')),
                getVerticalSpace(1.6.h),
                Text(
                  "TTPDM",
                  style: CustomTextStyles.onBoardingHeading,
                ),
                getVerticalSpace(8.h),
                SizedBox(
                  height: 2.4.h,
                  width: 2.4.h,
                  child: CircularProgressIndicator(
                    color: AppColors.mainColor,
                    strokeWidth: 5,
                  ),
                ),
                getVerticalSpace(11.8.h),
                Text(
                  'Welcome to TTPDM',
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.onBoardingHeading,
                ),
                getVerticalSpace(2.1.h),
                Text(
                  'The best digital marketing app for your business',
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.onBoardingLight,
                ),
                getVerticalSpace(15.h)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
