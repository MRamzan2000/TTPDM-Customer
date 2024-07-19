import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm/view/screens/home_section/home_screen.dart';
import 'package:ttpdm/view/screens/notification_section/notification_screen.dart';
import 'package:ttpdm/view/screens/profile_section/personal_profile.dart';
import 'package:ttpdm/view/screens/subscription_main.dart';

import 'campaign_section/addcampaign.dart';


class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    RxInt isSelectedIndex = 0.obs;
    return Scaffold(
        extendBody: true,
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.mainColor,
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                10.h,
              ),
              borderSide: BorderSide.none),
          onPressed: () {
            Get.to(() =>  AddNewCampaign());
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
            padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.h),
            height: 8.h,
            color: AppColors.whiteColor,
            shape: const CircularNotchedRectangle(),
            notchMargin: 5,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    isSelectedIndex.value = 0;
                  },
                  child: Column(
                    children: [
                      SizedBox(
                          height: 3.5.h,
                          child: Image(
                            image: const AssetImage(
                              'assets/pngs/homeicon.png',
                            ),
                            color: isSelectedIndex.value == 0
                                ? AppColors.mainColor
                                : const Color(0xff999999),
                          )),
                      Text(
                        'Home',
                        style: CustomTextStyles.buttonTextStyle.copyWith(
                            fontSize: 14.px,
                            color: isSelectedIndex.value == 0
                                ? AppColors.mainColor
                                : const Color(0xff999999)),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    isSelectedIndex.value = 1;
                  },
                  child: Column(
                    children: [
                      SizedBox(
                          height: 3.5.h,
                          child: Image(
                            image:
                                const AssetImage('assets/pngs/calendar 1.png'),
                            color: isSelectedIndex.value == 1
                                ? AppColors.mainColor
                                : const Color(0xff999999),
                          )),
                      Text(
                        'Subscription ',
                        style: CustomTextStyles.buttonTextStyle.copyWith(
                            fontSize: 14.px,
                            color: isSelectedIndex.value == 1
                                ? AppColors.mainColor
                                : const Color(0xff999999)),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 3.h,
                ),
                GestureDetector(
                  onTap: () {
                    isSelectedIndex.value = 2;
                  },
                  child: Column(
                    children: [
                      SizedBox(
                          height: 3.5.h,
                          child: Image(
                              image: const AssetImage(
                                  'assets/pngs/notificationicon.png'),
                              color: isSelectedIndex.value == 2
                                  ? AppColors.mainColor
                                  : const Color(0xff999999))),
                      Text(
                        'Notification ',
                        style: CustomTextStyles.buttonTextStyle.copyWith(
                            fontSize: 14.px,
                            color: isSelectedIndex.value == 2
                                ? AppColors.mainColor
                                : const Color(0xff999999)),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    isSelectedIndex.value = 3;
                  },
                  child: Column(
                    children: [
                      SizedBox(
                          height: 3.5.h,
                          child: Image(
                              image: const AssetImage(
                                  'assets/pngs/profileicon.png'),
                              color: isSelectedIndex.value == 3
                                  ? AppColors.mainColor
                                  : const Color(0xff999999))),
                      Text(
                        'Profile ',
                        style: CustomTextStyles.buttonTextStyle.copyWith(
                            fontSize: 14.px,
                            color: isSelectedIndex.value == 3
                                ? AppColors.mainColor
                                : const Color(0xff999999)),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Obx(
          () => isSelectedIndex.value == 0
              ? const HomeScreen()
              : isSelectedIndex.value == 1
                  ?  Subscription()
                  :isSelectedIndex.value == 2? const NotiFicationScreen():ProfileScreen(),
        ));
  }
}
