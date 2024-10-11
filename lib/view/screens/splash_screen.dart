import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm/controller/custom_widgets/widgets.dart';
import 'package:ttpdm/controller/getx_controllers/business_profile_controller.dart';
import 'package:ttpdm/controller/utils/my_shared_prefrence.dart';
import 'package:ttpdm/controller/utils/preference_key.dart';
import 'package:ttpdm/view/screens/bottom_navigationbar.dart';

import '../../controller/getx_controllers/internet_connectvty_controller.dart';
import 'onboarding_section/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  RxBool isLoggedInValue = false.obs;
  void navigateBasedOnLoginStatus() {
    MySharedPreferences.init().then(
      (value) {
        if (MySharedPreferences.getBool(isLoggedInKey)) {
          Get.off(() => const CustomBottomNavigationBar());
          log("token is that :${MySharedPreferences.getString(authTokenKey)}");
        } else {
          Get.off(() => const OnBoardingScreen());
        }
      },
    );
  }
  @override
  void initState() {
    super.initState();
    Get.put(ConnectivityController());
    Get.put(BusinessProfileController(context: context), tag: 'business');
    navigateBasedOnLoginStatus();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f9fa),
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
                  "ADVYRO ",
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
                  'Welcome to Advyro ',
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
