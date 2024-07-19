import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm/controller/custom_widgets/widgets.dart';
import 'package:ttpdm/view/screens/campaign_section/add_campaign_duration.dart';

import '../../../controller/custom_widgets/app_colors.dart';
import '../../../controller/custom_widgets/custom_text_styles.dart';
import '../../../controller/utils/alert_box.dart';

class PosterScreen extends StatelessWidget {
  const PosterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold( appBar: AppBar(
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
      body:Stack(children: [

        PageView.builder(scrollDirection: Axis.vertical,
          itemCount: 4,
          itemBuilder: (context, index) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child:  Image.asset('assets/pngs/mainposter.png',fit: BoxFit.cover,),
          );
        },),
        Positioned(bottom:34.2.h ,right: 1.6.h,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              GestureDetector(onTap: (){
                Get.to(()=>AddCampaignDuration());
              },
                child: SizedBox(height: 6.h,width: 5.h,
                    child:const Image(image: AssetImage('assets/pngs/select.png'))),
              ),
             getVerticalSpace(.8.h),
              SizedBox(height: 6.h,width: 5.h,
                  child:const Image(image: AssetImage('assets/pngs/like.png'))),
                getVerticalSpace(.8.h),
                SizedBox(height: 6.h,width: 5.h,
                  child:const Image(image: AssetImage('assets/pngs/dislike.png'))),
                getVerticalSpace(.8.h),
                GestureDetector(onTap: (){
                  openCampaignPoster(context);
                },
                  child: SizedBox(height: 6.h,width: 5.h,
                    child:const Image(image: AssetImage('assets/pngs/edit.png'))),
                ),
            ],) ),
        Positioned(top: 2.h,right: 1,left: 1.5.h,
          child: SizedBox(
            height: .6.h,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 1.h),
                    width: MediaQuery.of(context).size.width / 5.2 - 2.4.h,
                    height: .4.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1.h),
                        color: index==0||index==1||index==2
                            ? AppColors.mainColor
                            : const Color(0xffC3C3C2)),
                  );

              },
            ),
          ),
        ),
      ],)
    );
  }
}
