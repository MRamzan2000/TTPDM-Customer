import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm/controller/custom_widgets/widgets.dart';

class NotiFication2Screen extends StatelessWidget {
  const NotiFication2Screen({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.4.h),
        child: Column(
          children: [
            getVerticalSpace(7.h),
            Row(
              children: [
                GestureDetector(onTap: (){
                  Get.back();
                },
                  child: Icon(
                    Icons.arrow_back_ios_outlined,
                    color: const Color(0xff121826),
                    size: 2.4.h,
                  ),
                ),
                const Expanded(child: SizedBox()),
                Text(
                  'Notifications',
                  style: CustomTextStyles.buttonTextStyle.copyWith(
                      color: const Color(0xff121826),
                      fontFamily: 'bold',
                      fontSize: 16.px),
                ),
                const Expanded(child: SizedBox())
              ],
            ),
            getVerticalSpace(4.h),
            ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.2.h),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(radius: 3.h,
                        backgroundColor:
                        AppColors.mainColor,
                        child:  CircleAvatar(radius: 2.8.h,
                          backgroundImage: const AssetImage('assets/pngs/profile.png'),
                        ),
                      ),
                      getHorizentalSpace(1.2.h),
                      Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                              ,
                              style: TextStyle(
                                  fontSize: 12.px,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'bold',
                                  color: AppColors.blackColor),
                            ),
                            Text('1m ago.'
                              ,
                              style: TextStyle(
                                  fontSize: 12.px,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'bold',
                                  color: const Color(0xff6C6C6C)),
                            ),
                          ],
                        ),
                      ),

                      Container(alignment: Alignment.center,
                        height: 2.7.h,
                        width: 2.7.h,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.mainColor),
                        child: Text('2',style: CustomTextStyles.buttonTextStyle,),
                      ),

                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
