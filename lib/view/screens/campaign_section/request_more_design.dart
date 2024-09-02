import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm/controller/custom_widgets/widgets.dart';
import 'package:ttpdm/controller/utils/alert_box.dart';
import 'package:ttpdm/controller/utils/my_shared_prefrence.dart';


class RequestMoreDesign extends StatefulWidget {
  const RequestMoreDesign({super.key});

  @override
  State<RequestMoreDesign> createState() => _RequestMoreDesignState();
}

class _RequestMoreDesignState extends State<RequestMoreDesign> {
  String? token;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkToken();
  }
  Future<void> _checkToken() async {
    token = await PreferencesService().getAuthToken();
    if (token != null) {
      // Use the token as needed
      log("Token: $token");
    } else {
      // Handle the case where the token is not available
      log("No token available");
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(    appBar: AppBar(
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
        child: Column(children: [
getVerticalSpace(4.h),
          SizedBox(height: 28.h,width: 28.h,
              child: const Image(image: AssetImage('assets/pngs/requestmore.png'))),
          getVerticalSpace(2.4.h),
          Text('Request for More Designs',style: CustomTextStyles.onBoardingHeading.copyWith(fontSize: 20.px),),
          getVerticalSpace(4.h),
          GestureDetector(onTap: (){
            openCampaignPoster(context, token!);
          },
            child: Container(padding: EdgeInsets.symmetric(horizontal: 4.h,vertical: 1.2.h),
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(1.h)
                ),
                   child: Text( 'Request',style: TextStyle(color: AppColors.whiteColor),),
            ),
          )],),
      ),
    );
  }
}
