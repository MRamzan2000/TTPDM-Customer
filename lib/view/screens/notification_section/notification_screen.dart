import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm/controller/custom_widgets/widgets.dart';

class NotiFicationScreen extends StatelessWidget {
  const NotiFicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
       return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Notification ',
          style: CustomTextStyles.buttonTextStyle.copyWith(
              fontSize: 20.px,
              fontWeight: FontWeight.w600,
              color: AppColors.mainColor),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.4.h),
        child: Column(
          children: [
            getVerticalSpace(4.6.h),
            Row(crossAxisAlignment: CrossAxisAlignment.end,
              children: [
              Text('Today',style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.mainColor),),
                getHorizentalSpace(.5.h),const Expanded(child:  Divider(color: Colors.grey,))
              ],
            ),
            getVerticalSpace(1.2.h),
            ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: 1,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical:index==0?0.h: 3.h),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Companies',
                            style: TextStyle(
                                fontSize: 18.px,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'bold',
                                color: const Color(0xff15141F)),
                          ),
                         Text('4:00am',style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.mainColor),)
                        ],
                      ),
                      getVerticalSpace(.8.h),
                      Text('Your new companies will be started at 4:00 pm today',style: TextStyle(
                        fontSize: 12.px,
                        color: const Color(0xff454544),
                        fontFamily: 'regular',
                        fontWeight: FontWeight.w400
                      ),)
                    ],
                  ),
                );
              },
            ),
            getVerticalSpace(1.4.h),
            Row(crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Yesterday',style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.mainColor),),
                getHorizentalSpace(.5.h),const Expanded(child:  Divider(color: Colors.grey,))
              ],
            ),
            getVerticalSpace(1.2.h),
            ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: 1,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical:index==0?0.h: 3.h),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Companies',
                            style: TextStyle(
                                fontSize: 18.px,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'bold',
                                color: const Color(0xff15141F)),
                          ),
                          Text('4:00am',style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.mainColor),)
                        ],
                      ),
                      getVerticalSpace(.8.h),
                      Text('Your new companies will be started at 4:00 pm today',style: TextStyle(
                          fontSize: 12.px,
                          color: const Color(0xff454544),
                          fontFamily: 'regular',
                          fontWeight: FontWeight.w400
                      ),)
                    ],
                  ),
                );
              },
            ),
            getVerticalSpace(1.4.h),
            Row(crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('30/06/24',style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.mainColor),),
                getHorizentalSpace(.5.h),const Expanded(child:  Divider(color: Colors.grey,))
              ],
            ),
            getVerticalSpace(1.2.h),
            ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: 1,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical:index==0?0.h: 3.h),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Companies',
                            style: TextStyle(
                                fontSize: 18.px,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'bold',
                                color: const Color(0xff15141F)),
                          ),
                          Text('4:00am',style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.mainColor),)
                        ],
                      ),
                      getVerticalSpace(.8.h),
                      Text('Your new companies will be started at 4:00 pm today',style: TextStyle(
                          fontSize: 12.px,
                          color: const Color(0xff454544),
                          fontFamily: 'regular',
                          fontWeight: FontWeight.w400
                      ),)
                    ],
                  ),
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}
