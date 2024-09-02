
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm/controller/custom_widgets/widgets.dart';
import 'package:ttpdm/controller/getx_controllers/add_campaign_controller.dart';
import 'package:ttpdm/controller/getx_controllers/business_profile_controller.dart';
import 'package:ttpdm/controller/utils/firebase_push_notification.dart';
import 'package:ttpdm/controller/utils/my_shared_prefrence.dart';
import 'package:ttpdm/view/screens/bottom_navigationbar.dart';
import 'package:ttpdm/view/screens/onboarding_section/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // final NotificationServices notificationServices=NotificationServices();
  RxBool isLoggedInValue = false.obs;
 Future <void> checkLoginStatus() async {
    PreferencesService preferencesService = PreferencesService();
    bool isLoggedIn = await preferencesService.isLoggedIn();
    isLoggedInValue.value = isLoggedIn;
    navigateBasedOnLoginStatus();
  }

  void navigateBasedOnLoginStatus() {
    if (isLoggedInValue.value) {
      Get.off(() => const CustomBottomNavigationBar());
    } else {
      Get.off(() => const OnBoardingScreen());
    }
  }

  @override
  void initState() {
    super.initState();
    // notificationServices.getDeviceToken().then((value) {
    //   log("device token is that :$value");
    // },);
    Get.put(BusinessProfileController(context: context), tag: 'business');
    checkLoginStatus();
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
