import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm/controller/custom_widgets/widgets.dart';
import 'package:ttpdm/controller/utils/alert_box.dart';

class LogOutScreen extends StatelessWidget {
  const LogOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        automaticallyImplyLeading: false,
        title: Text(
          'Setting',
          style: CustomTextStyles.buttonTextStyle.copyWith(
              fontSize: 20.px,
              fontWeight: FontWeight.w600,
              color: AppColors.mainColor),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 2.4.h),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getVerticalSpace(1.6.h),
              GestureDetector(onTap: (){
                openChooseSubscription(context);
              },
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Subscription ',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'bold',
                          color: const Color(0xff191918),
                          fontSize: 14.px),
                    ),
                    Text(
                      'expire on 12 june',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'bold',
                          color: AppColors.mainColor,
                          fontSize: 12.px),
                    )
                  ],
                ),
              ),
              getVerticalSpace(.8.h),
              const Divider(color: Color(0xff6E6E6D),),
              getVerticalSpace(1.h),
              Text(
                'My card',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'bold',
                    color: const Color(0xff191918),
                    fontSize: 14.px),
              ),
              getVerticalSpace(.8.h),
              const Divider(color: Color(0xff6E6E6D),),
              getVerticalSpace(1.h),
              Text(
                'Chat Support',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'bold',
                    color: const Color(0xff191918),
                    fontSize: 14.px),
              ),
              getVerticalSpace(.8.h),
              const Divider(color: Color(0xff6E6E6D),),
              getVerticalSpace(1.h),
              Text(
                'Terms and conditions',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'bold',
                    color: const Color(0xff191918),
                    fontSize: 14.px),
              ),
              getVerticalSpace(.8.h),
              const Divider(color: Color(0xff6E6E6D),),
              getVerticalSpace(1.h),
              Text(
                'Privacy policy',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'bold',
                    color: const Color(0xff191918),
                    fontSize: 14.px),
              ),
              getVerticalSpace(.8.h),
              const Divider(color: Color(0xff6E6E6D),),
              getVerticalSpace(1.h),
              Text(
                'Logout',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'bold',
                    color: const Color(0xff191918),
                    fontSize: 16.px),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
