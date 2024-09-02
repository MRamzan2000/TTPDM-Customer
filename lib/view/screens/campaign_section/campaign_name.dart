import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm/controller/custom_widgets/widgets.dart';
import 'package:ttpdm/view/screens/profile_section/business_profile.dart';

import '../../../controller/utils/alert_box.dart';

class CampaignName extends StatelessWidget {
  CampaignName({super.key});
  final RxBool isOpen1 = false.obs;
  final RxBool isOpen3 = false.obs;
  final String range = '';
  final RxList<String> imageList =
      <String>['assets/pngs/imageicon.png', 'assets/pngs/videos.png'].obs;
  final List<String> items = ['Business', 'Poster', 'Scheduling', 'Cancel'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Campaign Name',
          style: CustomTextStyles.buttonTextStyle.copyWith(
              fontSize: 20.px,
              fontWeight: FontWeight.w600,
              color: AppColors.mainColor),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 1.h),
            child: PopupMenuButton<String>(
              onSelected: (String value) {
                if (value == 'Cancel') {
                  openCampaignCancel(context);
                }else if(value=='Business'){
                  // Get.to(()=> const BusinessProfile());

                }else if(value=='Poster'){
                  // Get.to(()=> PosterScreen());

                }else{
                  // Get.to(()=> AddCampaignDuration(businessId: '', campaignName: '', campaignDescription: '', selectedPoster: null,));
                }
              },
              itemBuilder: (BuildContext context) {
                return _buildPopupMenuItems(items);
              },
              icon: const Icon(Icons.more_vert),
            ),
          ),
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.4.h),
          child: Obx(
            () => SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      isOpen1.value = !isOpen1.value;
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 1.h, vertical: 1.1.h),
                      margin: EdgeInsets.symmetric(vertical: 1.6.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1.h),
                        color: AppColors.whiteColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Campaign details',
                            style: TextStyle(
                              color: AppColors.blackColor,
                              fontSize: 14.px,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'bold',
                            ),
                          ),
                          isOpen1.value
                              ? SvgPicture.asset('assets/svgs/up.svg')
                              : SvgPicture.asset('assets/svgs/down.svg'),
                        ],
                      ),
                    ),
                  ),
                  isOpen1.value
                      ? Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.h, vertical: 1.5.h),
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(2.h),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ad Banner',
                                style: TextStyle(
                                  fontSize: 14.px,
                                  fontFamily: 'bold',
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff191918),
                                ),
                              ),
                              getVerticalSpace(.5.h),
                              Container(
                                height: 24.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(1.h),
                                  image: const DecorationImage(
                                    image: AssetImage(
                                        'assets/pngs/mainposter.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              getVerticalSpace(1.2.h),
                              const Divider(
                                  color: Color(0xff6E6E6D), thickness: 1),
                              getVerticalSpace(1.2.h),
                              Text(
                                'Business Profile',
                                style: TextStyle(
                                  fontSize: 14.px,
                                  fontFamily: 'bold',
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff191918),
                                ),
                              ),
                              getVerticalSpace(.8.h),
                              Text(
                                'Business name',
                                style: TextStyle(
                                  fontSize: 14.px,
                                  fontFamily: 'bold',
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff6E6E6D),
                                ),
                              ),
                              getVerticalSpace(1.2.h),
                              const Divider(
                                  color: Color(0xff6E6E6D), thickness: 1),
                              Text(
                                'Ads Name',
                                style: TextStyle(
                                  fontSize: 14.px,
                                  fontFamily: 'bold',
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff191918),
                                ),
                              ),
                              getVerticalSpace(.8.h),
                              Text(
                                'Ads Name',
                                style: TextStyle(
                                  fontSize: 14.px,
                                  fontFamily: 'bold',
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff6E6E6D),
                                ),
                              ),
                              getVerticalSpace(1.2.h),
                              const Divider(
                                  color: Color(0xff6E6E6D), thickness: 1),
                              getVerticalSpace(1.2.h),
                              Text(
                                'What’s the business name?',
                                style: TextStyle(
                                  fontSize: 14.px,
                                  fontFamily: 'bold',
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff191918),
                                ),
                              ),
                              getVerticalSpace(.8.h),
                              Text(
                                'What’s the business name?',
                                style: TextStyle(
                                  fontSize: 14.px,
                                  fontFamily: 'bold',
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff6E6E6D),
                                ),
                              ),
                              getVerticalSpace(1.2.h),
                              const Divider(
                                  color: Color(0xff6E6E6D), thickness: 1),
                              getVerticalSpace(1.2.h),
                              Text(
                                'What’s your website URL?',
                                style: TextStyle(
                                  fontSize: 14.px,
                                  fontFamily: 'bold',
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff191918),
                                ),
                              ),
                              getVerticalSpace(.8.h),
                              Text(
                                'www.com',
                                style: TextStyle(
                                  fontSize: 14.px,
                                  fontFamily: 'bold',
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff007AFF),
                                ),
                              ),
                              getVerticalSpace(1.2.h),
                              const Divider(
                                  color: Color(0xff6E6E6D), thickness: 1),
                              getVerticalSpace(1.2.h),
                              Text(
                                'Campaign Descriptions',
                                style: TextStyle(
                                  fontSize: 14.px,
                                  fontFamily: 'bold',
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff191918),
                                ),
                              ),
                              Text(
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                                style: TextStyle(
                                  fontSize: 12.px,
                                  fontFamily: 'bold',
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xff6E6E6D),
                                ),
                              ),
                              getVerticalSpace(2.4.h),
                              getVerticalSpace(1.2.h),
                              Text(
                                'Campaign Platform ',
                                style: TextStyle(
                                  fontSize: 14.px,
                                  fontFamily: 'bold',
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff191918),
                                ),
                              ),
                              getVerticalSpace(.8.h),
                              Text(
                                'Google    Facebook    Instagram',
                                style: TextStyle(
                                  fontSize: 14.px,
                                  fontFamily: 'bold',
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.mainColor,
                                ),
                              ),
                              getVerticalSpace(1.2.h),
                              const Divider(color: Color(0xff6E6E6D)),
                              getVerticalSpace(1.2.h),
                              Text(
                                'Date Schedule',
                                style: TextStyle(
                                  fontSize: 14.px,
                                  fontFamily: 'bold',
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff191918),
                                ),
                              ),
                              getVerticalSpace(1.2.h),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 2.4.h,
                                        width: 2.4.h,
                                        child: const Image(
                                          image: AssetImage(
                                              'assets/pngs/dateicon.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(width: .8.h),
                                      Text(
                                        range.isNotEmpty
                                            ? range
                                            : '25 May 24 TO 04 June 24',
                                        style: TextStyle(
                                          color: range.isNotEmpty
                                              ? AppColors.blackColor
                                              : AppColors.mainColor,
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
                              Text(
                                'Time Duration',
                                style: TextStyle(
                                  fontSize: 14.px,
                                  fontFamily: 'bold',
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff191918),
                                ),
                              ),
                              getVerticalSpace(1.2.h),
                              Text(
                                range.isNotEmpty ? range : 'From 8am to 4pm',
                                style: TextStyle(
                                  color: range.isNotEmpty
                                      ? AppColors.blackColor
                                      : AppColors.mainColor,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'bold',
                                  fontSize: 12.px,
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
                  GestureDetector(
                    onTap: () {
                      isOpen3.value = !isOpen3.value;
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 1.h, vertical: 1.1.h),
                      margin: EdgeInsets.symmetric(vertical: 1.6.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1.h),
                        color: AppColors.whiteColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Analysis',
                            style: TextStyle(
                              color: AppColors.blackColor,
                              fontSize: 14.px,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'bold',
                            ),
                          ),
                          isOpen3.value
                              ? SvgPicture.asset('assets/svgs/up.svg')
                              : SvgPicture.asset('assets/svgs/down.svg'),
                        ],
                      ),
                    ),
                  ),
                  isOpen3.value
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1.h),
                            color: AppColors.whiteColor,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Analytics',
                                style: TextStyle(
                                  color: AppColors.blackColor,
                                  fontSize: 17.px,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'bold',
                                ),
                              ),
                              getVerticalSpace(.9.h),
                              Text(
                                '5.000,00 Importation',
                                style: CustomTextStyles.onBoardingHeading
                                    .copyWith(fontSize: 25.px),
                              ),
                              getVerticalSpace(.9.h),
                              Text(
                                '50 Clicks',
                                style: TextStyle(
                                  color: AppColors.blackColor,
                                  fontSize: 17.px,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'regular',
                                ),
                              ),
                              getVerticalSpace(.9.h),
                              const Image(
                                  image: AssetImage(
                                      'assets/pngs/splinechart.png')),
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<PopupMenuEntry<String>> _buildPopupMenuItems(List<String> items) {
    List<PopupMenuEntry<String>> menuItems = [];
    for (int i = 0; i < items.length; i++) {
      menuItems.add(
        PopupMenuItem<String>(
          value: items[i],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(items[i]),
              if (i < items.length - 1) const Divider(thickness: 1),
            ],
          ),
        ),
      );
    }
    return menuItems;
  }
}
