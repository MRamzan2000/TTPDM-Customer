import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm/controller/getx_controllers/business_profile_controller.dart';
import 'package:ttpdm/controller/utils/my_shared_prefrence.dart';
import 'package:ttpdm/controller/utils/preference_key.dart';
import 'package:ttpdm/view/screens/campaign_section/addcampaign.dart';
import 'package:ttpdm/view/screens/home_section/home_screen.dart';
import 'package:ttpdm/view/screens/notification_section/notification_screen.dart';
import 'package:ttpdm/view/screens/profile_section/personal_profile.dart';
import 'package:ttpdm/view/screens/wallet.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  final BusinessProfileController businessProfileController = Get.find(tag: 'business');
  RxString token = "".obs;

  @override
  void initState() {
    super.initState();
    token.value = MySharedPreferences.getString(authToken);
  }

  @override
  Widget build(BuildContext context) {
    RxInt isSelectedIndex = 0.obs;

    return Scaffold(
      backgroundColor: const Color(0xfff8f9fa),
      resizeToAvoidBottomInset: false,
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.mainColor,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.h),
          borderSide: BorderSide.none,
        ),
        onPressed: () {
          log('is this token $token');

          Get.to(() => AddNewCampaign(token: token.value));
        },
        child: Icon(
          Icons.add,
          size: 3.5.h,
          color: AppColors.whiteColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Obx(
        () => BottomAppBar(
          color: Colors.white,
          shape: const CircularNotchedRectangle(),
          notchMargin: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                flex: 5,
                child: GestureDetector(
                  onTap: () {
                    isSelectedIndex.value = 0;
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: 3.5.h,
                        child: Image(
                          image: const AssetImage('assets/pngs/homeicon.png'),
                          color: isSelectedIndex.value == 0 ? AppColors.mainColor : const Color(0xff999999),
                        ),
                      ),
                      Text(
                        'Home',
                        style: CustomTextStyles.buttonTextStyle.copyWith(
                          fontSize: 12.px,
                          color: isSelectedIndex.value == 0 ? AppColors.mainColor : const Color(0xff999999),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: GestureDetector(
                  onTap: () {
                    isSelectedIndex.value = 1;
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: 3.5.h,
                        child: Image(
                          image: const AssetImage('assets/pngs/wallet.png'),
                          color: isSelectedIndex.value == 1 ? AppColors.mainColor : const Color(0xff999999),
                        ),
                      ),
                      Text(
                        'Wallet ',
                        style: CustomTextStyles.buttonTextStyle.copyWith(
                          fontSize: 12.px,
                          color: isSelectedIndex.value == 1 ? AppColors.mainColor : const Color(0xff999999),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 9,
                child: GestureDetector(
                  onTap: () {
                    isSelectedIndex.value = 2;
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: 3.5.h,
                        child: Image(
                          image: const AssetImage('assets/pngs/notificationicon.png'),
                          color: isSelectedIndex.value == 2 ? AppColors.mainColor : const Color(0xff999999),
                        ),
                      ),
                      Text(
                        'Notification ',
                        style: CustomTextStyles.buttonTextStyle.copyWith(
                          fontSize: 12.px,
                          color: isSelectedIndex.value == 2 ? AppColors.mainColor : const Color(0xff999999),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: GestureDetector(
                  onTap: () {
                    isSelectedIndex.value = 3;
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: 3.5.h,
                        child: Image(
                          image: const AssetImage('assets/pngs/profileicon.png'),
                          color: isSelectedIndex.value == 3 ? AppColors.mainColor : const Color(0xff999999),
                        ),
                      ),
                      Text(
                        'Profile ',
                        style: CustomTextStyles.buttonTextStyle.copyWith(
                          fontSize: 12.px,
                          color: isSelectedIndex.value == 3 ? AppColors.mainColor : const Color(0xff999999),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Obx(
        () => Column(
          children: [
            Expanded(
              child: isSelectedIndex.value == 0
                  ? const HomeScreen()
                  : isSelectedIndex.value == 1
                      ? const WalletScreen()
                      : isSelectedIndex.value == 2
                          ? const NotificationScreen()
                          : const ProfileScreen(),
            ),
            SizedBox(height: 8.h), // Adjust the height as needed
          ],
        ),
      ),
    );
  }
}
