import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm/controller/custom_widgets/widgets.dart';
import 'package:ttpdm/controller/utils/alert_box.dart';

import '../../../controller/custom_widgets/app_colors.dart';


class CampaignDetails  extends StatelessWidget {
  const CampaignDetails ({super.key});

  @override
  Widget build(BuildContext context) {
    String range = '';

    return  Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Add Campaign',
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
          padding:  EdgeInsets.symmetric(horizontal: 2.5.h),
          child: SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getVerticalSpace(2.4.h),
                SizedBox(
                  height: .6.h,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 1.h),
                        width: MediaQuery.of(context).size.width / 5.2 - 2.4.h,
                        height: .4.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1.h),
                            color:
                            index == 0 || index == 1 || index == 2 || index == 3||index==4
                                ? AppColors.mainColor
                                : const Color(0xffC3C3C2)),
                      );
                    },
                  ),
                ),
                getVerticalSpace(2.4.h),
                Align(alignment: Alignment.topCenter,
                  child: Text(
                    'Pay Campaign Fee to Upload',
                    style: CustomTextStyles.buttonTextStyle.copyWith(
                        fontSize: 14.px,
                        fontWeight: FontWeight.w600,
                        color: AppColors.blackColor),
                  ),
                ),
                getVerticalSpace(1.6.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.5.h),

                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(2.h)
                ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text('Ad Banner',style: TextStyle(
                      fontSize: 14.px,
                      fontFamily: 'bold',
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff191918)
                  ),),
getVerticalSpace(.5.h),
                  Container(
                    height: 24.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1.h)
                          ,image: const DecorationImage(image: AssetImage('assets/pngs/mainposter.png'),fit: BoxFit.cover)
                    ),

                  ),
                  getVerticalSpace(1.2.h),
                    const Divider(color: Color(0xff6E6E6D),
                      thickness: 1,),
                    getVerticalSpace(1.2.h),
                    Text('Business Profile',style: TextStyle(
                        fontSize: 14.px,
                        fontFamily: 'bold',
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff191918)
                    ),),
                    getVerticalSpace(.8.h),
                    Text('Business name',style: TextStyle(
                        fontSize: 14.px,
                        fontFamily: 'bold',
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff6E6E6D)
                    ),),
                    getVerticalSpace(1.2.h),
                    const Divider(color: Color(0xff6E6E6D),
                      thickness: 1,),
                    Text('Ads Name',style: TextStyle(
                      fontSize: 14.px,
                      fontFamily: 'bold',
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff191918)
                  ),),
                  getVerticalSpace(.8.h),
                  Text('Ads Name',style: TextStyle(
                      fontSize: 14.px,
                      fontFamily: 'bold',
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff6E6E6D)
                  ),),
                  getVerticalSpace(1.2.h),
                  const Divider(color: Color(0xff6E6E6D),
                    thickness: 1,),
                  getVerticalSpace(1.2.h),
                  Text('What’s the business name?',style: TextStyle(
                      fontSize: 14.px,
                      fontFamily: 'bold',
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff191918)
                  ),),
                  getVerticalSpace(.8.h),
                  Text('What’s the business name?',style: TextStyle(
                      fontSize: 14.px,
                      fontFamily: 'bold',
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff6E6E6D)
                  ),),
                  getVerticalSpace(1.2.h),
                  const Divider(color: Color(0xff6E6E6D),
                    thickness: 1,),
                  getVerticalSpace(1.2.h),
                  Text('What’s your website URL?',style: TextStyle(
                      fontSize: 14.px,
                      fontFamily: 'bold',
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff191918)
                  ),),
                  getVerticalSpace(.8.h),
                  Text('www.com',style: TextStyle(
                      fontSize: 14.px,
                      fontFamily: 'bold',
                      fontWeight: FontWeight.w500,
                      color: const  Color(0xff007AFF)
                  ),),
                  getVerticalSpace(1.2.h),
                  const Divider(color: Color(0xff6E6E6D),
                    thickness: 1,),
                  getVerticalSpace(1.2.h),
                  Text('Campaign Descriptions',style: TextStyle(
                      fontSize: 14.px,
                      fontFamily: 'bold',
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff191918)
                  ),),
                  Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',style: TextStyle(
                      fontSize: 12.px,
                      fontFamily: 'bold',
                      fontWeight: FontWeight.w400,
                      color: const  Color(0xff6E6E6D)
                  ),),
                  getVerticalSpace(2.4.h),
                  getVerticalSpace(1.2.h),
                  Text('Campaign Platform ',style: TextStyle(
                      fontSize: 14.px,
                      fontFamily: 'bold',
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff191918)
                  ),),
                  getVerticalSpace(.8.h),
                  Text('Google    Facebook    Instagram',style: TextStyle(
                      fontSize: 14.px,
                      fontFamily: 'bold',
                      fontWeight: FontWeight.w500,
                      color: AppColors.mainColor
                  ),),
                  getVerticalSpace(1.2.h),
                  const Divider(color: Color(0xff6E6E6D)),
                  getVerticalSpace(1.2.h),
                  Text('Date Schedule',style: TextStyle(
                      fontSize: 14.px,
                      fontFamily: 'bold',
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff191918)
                  ),),
                  getVerticalSpace(1.2.h),
                  Row(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 2.4.h,
                            width: 2.4.h,
                            child: const Image(
                              image: AssetImage('assets/pngs/dateicon.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: .8.h),
                          Text(
                            range.isNotEmpty ? range : '25 May 24 TO 04 June 24',
                            style: TextStyle(
                              color: range.isNotEmpty ? AppColors.blackColor:AppColors.mainColor,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'bold',
                              fontSize: 12.px,
                            ),
                          ),

                        ],
                      ),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                  const Divider(color: Color(0xff6E6E6D)),
                  getVerticalSpace(1.2.h),
                  Text('Time Duration',style: TextStyle(
                      fontSize: 14.px,
                      fontFamily: 'bold',
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff191918)
                  ),),
                  getVerticalSpace(1.2.h),
                  Text(
                    range.isNotEmpty ? range : 'From 8am to 4pm',
                    style: TextStyle(
                      color: range.isNotEmpty ? AppColors.blackColor:AppColors.mainColor,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'bold',
                      fontSize: 12.px,
                    ),
                  ),





                ],),
              ),
                getVerticalSpace(1.h),
                Row(children: [
                  Text('Your Campaign Fee',style: TextStyle(
                      fontSize: 14.px,
                      fontFamily: 'bold',
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff191918)
                  ),),
const Expanded(child: SizedBox()),
SizedBox(height: 2.h,width: 2.h,
    child: const Image(image: AssetImage('assets/pngs/coins.png'))),
                  Text('1200',style: TextStyle(
                      fontSize: 14.px,
                      fontFamily: 'bold',
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff191918)
                  ),),
                ],),

                getVerticalSpace(4.3.h),
                Align(alignment: Alignment.bottomCenter,
                  child: customElevatedButton(onTap: (){
                    openCampaignFee(context);
                  },
                      title: 'Submit',
                      bgColor: AppColors.mainColor,
                      titleColor: AppColors.whiteColor,
                      horizentalPadding: 5.h,verticalPadding: .8.h),
                ),
                getVerticalSpace(3.h),

               ]
            ),
          ),
        ),
      ),
    );
  }


}
