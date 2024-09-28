import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ttpdm/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm/controller/custom_widgets/widgets.dart';
import 'package:ttpdm/controller/getx_controllers/get_stripe_key_controller.dart';
import 'package:ttpdm/controller/getx_controllers/user_profile_controller.dart';
import 'package:ttpdm/controller/utils/alert_box.dart';
import 'package:ttpdm/controller/utils/my_shared_prefrence.dart';
import 'package:ttpdm/controller/utils/preference_key.dart';
import 'package:ttpdm/view/screens/chat_support/chat_support.dart';

class LogOutScreen extends StatefulWidget {
  const LogOutScreen({super.key});

  @override
  State<LogOutScreen> createState() => _LogOutScreenState();
}

class _LogOutScreenState extends State<LogOutScreen> {
  late UserProfileController userProfileController;
  late GetStripeKeyController getStripeKeyController;
  RxString token = "".obs;
  RxString subscriptionEnd = "".obs;
  DateTime dateTime=DateTime.now();
  String formattedDate="";
  @override
  void initState() {
    super.initState();
    userProfileController = Get.put(UserProfileController(context: context));
    getStripeKeyController = Get.put(GetStripeKeyController(context: context));

    // Initialize token and subscriptionEnd
    token.value = MySharedPreferences.getString(authToken);
    subscriptionEnd.value = MySharedPreferences.getString(subscription);
    log("subscriptionEnd.value :${subscriptionEnd.value}");

    if (subscriptionEnd.value.isNotEmpty) {
      try {
        dateTime = DateTime.parse(subscriptionEnd.value);
        formattedDate = DateFormat('dd MMMM').format(dateTime);
      } catch (e) {
        log("Error parsing date: $e");
      }
    }
    // Fetch Stripe key
    getStripeKeyController.fetchStripeKey(loading: true).then((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        getStripeKeyController.keyLoading.value = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f9fa),
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios_outlined,
            size: 2.4.h,
            color: const Color(0xff191918),
          ),
        ),
        backgroundColor: AppColors.whiteColor,
        centerTitle: true,
        title: Text(
          'Setting',
          style: CustomTextStyles.buttonTextStyle.copyWith(
            fontSize: 20.px,
            fontWeight: FontWeight.w600,
            color: AppColors.mainColor,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              userProfileController.deleteUserAccount(token: token.value).then((value) {
                MySharedPreferences.setBool(isLoggedInKey, false);
              });
            },
            child: Text(
              "Delete Account",
              style: CustomTextStyles.buttonTextStyle.copyWith(
                fontSize: 12.px,
                fontWeight: FontWeight.w600,
                color: AppColors.mainColor,
              ),
            ),
          ),
          getHorizentalSpace(1.h),
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.4.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getVerticalSpace(1.6.h),
              // Use Obx to make it reactive
              Obx(() {
                return GestureDetector(
                  onTap: () {
                    openChooseSubscription(
                      context,
                      token.value,
                      getStripeKeyController.stripeKey.value!.secretKey.toString(),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Subscription ',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'bold',
                          color: const Color(0xff191918),
                          fontSize: 14.px,
                        ),
                      ),
                      Text(
                        getStripeKeyController.keyLoading.value ? "Loading..." : formattedDate.isEmpty?"No Plan Buy" : 'Expire on $formattedDate',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'bold',
                          color: AppColors.mainColor,
                          fontSize: 12.px,
                        ),
                      ),
                    ],
                  ),
                );
              }),
              getVerticalSpace(.8.h),
              const Divider(color: Color(0xff6E6E6D)),
              getVerticalSpace(1.h),
              GestureDetector(
                onTap: () {
                  Get.to(const ChatSupportScreen());
                },
                child: Row(
                  children: [
                    Text(
                      'Chat Support',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: 'bold',
                        color: const Color(0xff191918),
                        fontSize: 14.px,
                      ),
                    ),
                  ],
                ),
              ),
              getVerticalSpace(.8.h),
              const Divider(color: Color(0xff6E6E6D)),
              getVerticalSpace(1.h),
              Text(
                'Privacy policy',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: 'bold',
                  color: const Color(0xff191918),
                  fontSize: 14.px,
                ),
              ),
              getVerticalSpace(.8.h),
              const Divider(color: Color(0xff6E6E6D)),
              getVerticalSpace(1.h),
              GestureDetector(
                onTap: () {
                  logoutPopUp(context);
                },
                child: Text(
                  'Logout',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'bold',
                    color: const Color(0xff191918),
                    fontSize: 16.px,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
