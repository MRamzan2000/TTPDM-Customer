import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm/controller/custom_widgets/widgets.dart';
import 'package:ttpdm/view/screens/profile_section/business_profile.dart';

import '../../../controller/custom_widgets/app_colors.dart';
import '../../../controller/custom_widgets/custom_text_styles.dart';
import 'edit_profile.dart';
import 'settng_screen.dart';


class ProfileScreen extends StatelessWidget {
   ProfileScreen({super.key});
final RxList<String>profilesList=<String>['Business Profile One','Business Profile Two',
'Business Profile Three'].obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(   
      appBar: AppBar(
      backgroundColor: AppColors.whiteColor,
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: Text(
        'Profile ',
        style: CustomTextStyles.buttonTextStyle.copyWith(
            fontSize: 20.px,
            fontWeight: FontWeight.w600,
            color: AppColors.mainColor),
      ),
      actions:  [
        Padding(
          padding:  EdgeInsets.only(right: 2.h),
          child: GestureDetector(onTap: (){
            Get.to(()=>const LogOutScreen());
          },
            child: SizedBox(height: 3.h,width: 3.h,
                child:const Image(image: AssetImage('assets/pngs/settingicon.png'))),
          ),
        )
      ],
    ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getVerticalSpace(2.4.h),
            ListView.builder(shrinkWrap: true,
               padding: EdgeInsets.zero,
               itemCount: profilesList.length,
              itemBuilder: (context, index) {
              return
                Column(
                  children: [
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 2.6.h),
                      child: Row(children: [
                      index==0?  Text('Approved',style: TextStyle(
                          fontFamily: 'regular',
                          color: AppColors.mainColor,
                          fontSize: 12.px,
                          fontWeight: FontWeight.w400
                        ),):index==1?Text('Pending Approval',style: TextStyle(
                          fontFamily: 'regular',
                          color: const Color(0xff007AFF),
                          fontSize: 12.px,
                          fontWeight: FontWeight.w400
                      ),):Text('Rejected ',style: TextStyle(
                          fontFamily: 'regular',
                          color:Color(0xffFF3B30),
                          fontSize: 12.px,
                          fontWeight: FontWeight.w400
                      ),),
                        getHorizentalSpace(2.h),
                        const Expanded(child: Divider(color: Colors.grey,))
                      ],),
                    ),
                    GestureDetector(onTap: (){
                    Get.to(()=>const BusinessProfile());
                                  },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 2.4.h,vertical: 1.6.h),
                      padding: EdgeInsets.symmetric(horizontal: 1.6.h,
                      vertical: 2.0.h),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(1.h)
                      ),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(profilesList[index],
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: 'bold',
                            fontSize: 14.px,
                            color: const Color(0xff282827)
                          ),),
                          Icon(Icons.arrow_forward_ios_sharp,
                          size: 2.4.h,color:
                            const Color(0xff191918),)
                        ],
                      ),
                    ),
                                  ),
                  ],
                );
            },),
            getVerticalSpace(1.6.h),
            GestureDetector(onTap: (){
              Get.to(()=>EditProfile());
            },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 2.4.h,vertical: 1.6.h),
                padding: EdgeInsets.symmetric(horizontal: 1.6.h,
                    vertical: 2.0.h),
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(1.h)
                ),
                child: Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.add,
                     size: 3.h,
                     color: AppColors.mainColor,
                         ),
                    Text('Add New Business',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: 'bold',
                          fontSize: 14.px,
                          color: AppColors.mainColor
                      ),),

                  ],
                ),
              ),
            )


                                ])),
                          );





  }
}
