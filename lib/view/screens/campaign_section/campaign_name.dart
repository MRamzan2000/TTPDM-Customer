import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm/controller/custom_widgets/widgets.dart';
import 'package:ttpdm/models/get_campaigns_by_status_model.dart';

import '../../../controller/utils/alert_box.dart';

class CampaignName extends StatelessWidget {
  final String businessId;
  final String businessName;
  final String campaignName;
  final String campaignDescription;
  final String selectedPoster;
  final List campaignPlatForms;
  final List<Analytics> analysis;
  final DateTime startDate;
  final DateTime endDate;
  final String startTime;
  final String endTime;
  final String status;
  CampaignName(
      {super.key,
      required this.businessId,
      required this.businessName,
      required this.campaignName,
      required this.campaignDescription,
      required this.selectedPoster,
      required this.campaignPlatForms,
      required this.startDate,
      required this.endDate,
      required this.startTime,
      required this.endTime,
      required this.status,
      required this.analysis,
      });
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
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 2.4.h,
              color: AppColors.blackColor,
            )),
        automaticallyImplyLeading: false,
        title: Text(
          campaignName,
          style: CustomTextStyles.buttonTextStyle.copyWith(
              fontSize: 20.px,
              fontWeight: FontWeight.w600,
              color: AppColors.mainColor),
        ),
        actions: [
          status == "pending"
              ? Padding(
                  padding: EdgeInsets.only(right: 1.h),
                  child: PopupMenuButton<String>(
                    onSelected: (String value) {
                      if (value == 'Cancel') {
                        openCampaignCancel(context);
                      } else if (value == 'Business') {
                        // Get.to(()=> const BusinessProfile());
                      } else if (value == 'Poster') {
                        // Get.to(()=> PosterScreen());
                      } else {
                        // Get.to(()=> AddCampaignDuration(businessId: '', campaignName: '', campaignDescription: '', selectedPoster: null,));
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return _buildPopupMenuItems(items);
                    },
                    icon: const Icon(Icons.more_vert),
                  ),
                )
              : const SizedBox.shrink(),
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
                                  image: DecorationImage(
                                    image: NetworkImage(selectedPoster),
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
                                businessName,
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
                                campaignName,
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
                                'Campaign Descriptions',
                                style: TextStyle(
                                  fontSize: 14.px,
                                  fontFamily: 'bold',
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff191918),
                                ),
                              ),
                              Text(
                                campaignDescription,
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
                              Wrap(
                                spacing: 8.0, // Horizontal space between items
                                children: campaignPlatForms.map((platform) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      // Optionally, you can add a border or background color if needed
                                      borderRadius: BorderRadius.circular(
                                          8.0), // Rounded corners
                                      color: Colors
                                          .transparent, // Background color (transparent in this case)
                                    ),
                                    child: Text(
                                      platform,
                                      style: TextStyle(
                                        fontSize: 14.px,
                                        fontFamily: 'bold',
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.mainColor,
                                      ),
                                    ),
                                  );
                                }).toList(),
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
                                        "${DateFormat('dd MMM yy').format(startDate)} To ${DateFormat('dd MMM yy').format(endDate)}",
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
                                "$startTime To $endTime",
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
                  status == "rejected" || status == "pending"
                      ? const SizedBox.shrink()
                      : GestureDetector(
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
                      ? status == "rejected" || status == "pending"
                          ? const SizedBox.shrink()
                          : Container(
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
                                    '${analysis.isEmpty?"0":analysis[0].impressions} Importation',
                                    style: CustomTextStyles.onBoardingHeading
                                        .copyWith(fontSize: 25.px),
                                  ),
                                  getVerticalSpace(.9.h),
                                  Text(
                                    '${analysis.isEmpty?"0":analysis[0].clicks} Clicks',
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
                  status == "rejected" || status == "pending"
                      ? getVerticalSpace(3.h)
                      : const SizedBox.shrink()
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
