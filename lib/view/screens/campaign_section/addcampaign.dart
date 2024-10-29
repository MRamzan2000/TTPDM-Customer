import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ttpdm/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm/controller/custom_widgets/widgets.dart';
import 'package:ttpdm/controller/getx_controllers/business_profile_controller.dart';
import 'package:ttpdm/view/screens/campaign_section/poster_screen.dart';

import 'fill_add_detail.dart';

class AddNewCampaign extends StatefulWidget {
  final String token;

  const AddNewCampaign({super.key, required this.token});

  @override
  State<AddNewCampaign> createState() => _AddNewCampaignState();
}

class _AddNewCampaignState extends State<AddNewCampaign> {
  final RxString businessId = ''.obs;
  final RxString businessName = ''.obs;
  final RxInt selectedIndex = 0.obs;
  final BusinessProfileController businessProfileController = Get.find<BusinessProfileController>(tag: 'business');

  @override
  void initState() {
    super.initState();
    businessProfileController.fetchBusiness(token: widget.token, context: context, loading: businessProfileController.allBusinessProfiles.isEmpty);
    log('Business are that :${businessProfileController.fetchBusiness}');
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
        automaticallyImplyLeading: false,
        title: Text(
          'Add Campaign',
          style: CustomTextStyles.buttonTextStyle.copyWith(fontSize: 20.px, fontWeight: FontWeight.w600, color: AppColors.mainColor),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.4.h),
          child: Obx(
            () => Column(
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
                            borderRadius: BorderRadius.circular(1.h), color: index == 0 ? AppColors.mainColor : const Color(0xffC3C3C2)),
                      );
                    },
                  ),
                ),
                getVerticalSpace(2.4.h),
                Text(
                  'Select business for campaign',
                  style: CustomTextStyles.buttonTextStyle.copyWith(fontSize: 14.px, fontWeight: FontWeight.w600, color: AppColors.blackColor),
                ),
                getVerticalSpace(2.1.h),
                businessProfileController.isLoading2.value
                    ? ListView.builder(
                        itemCount: widget.token.isNotEmpty ? 3 : businessProfileController.allBusinessProfiles.length, // Number of shimmer items
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                            baseColor: AppColors.baseColor,
                            highlightColor: AppColors.highlightColor,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 1.6.h, vertical: 2.h),
                              margin: EdgeInsets.symmetric(vertical: 1.6.h),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(1.h), color: AppColors.whiteColor),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(.3.h),
                                    height: 2.4.h,
                                    width: 2.4.h,
                                    child: CircleAvatar(radius: 1.h),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : businessProfileController.allBusinessProfiles.isEmpty
                        ? Text(
                            'No Business Available for Campaign',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'bold',
                              fontSize: 14.px,
                              color: AppColors.mainColor,
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                              itemCount: businessProfileController.approvedProfiles.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    selectedIndex.value = index;
                                    businessId.value = businessProfileController.approvedProfiles[selectedIndex.value]!.id;
                                    businessName.value = businessProfileController.approvedProfiles[selectedIndex.value]!.name;
                                    if (businessId.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(content: Text('Please Select your business for Campaign')));
                                    } else if (businessName.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(content: Text('Please Select your business for Campaign')));
                                    } else {
                                      Get.to(() => PosterScreen(
                                        businessId: businessId.value,
                                        businessName: businessName.value,
                                        token: widget.token,
                                      ));
                                    }
                                  },
                                  child: Obx(
                                    () => Container(
                                      padding: EdgeInsets.symmetric(horizontal: 1.6.h, vertical: 2.h),
                                      margin: EdgeInsets.symmetric(vertical: 1.6.h),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(1.h), color: AppColors.whiteColor),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(businessProfileController.approvedProfiles[index]!.name),
                                          Container(
                                            padding: EdgeInsets.all(.3.h),
                                            height: 2.4.h,
                                            width: 2.4.h,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.transparent,
                                                border: Border.all(
                                                    color: selectedIndex.value == index ? AppColors.mainColor : const Color(0xff7C7C7C), width: 2)),
                                            child: CircleAvatar(
                                              backgroundColor: selectedIndex.value == index ? AppColors.mainColor : Colors.transparent,
                                              radius: 1.h,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                // customElevatedButton(
                //     onTap: () {
                //       if (businessId.isEmpty) {
                //         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                //             content: Text(
                //                 'Please Select your business for Campaign')));
                //       } else if (businessName.isEmpty) {
                //         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                //             content: Text(
                //                 'Please Select your business for Campaign')));
                //       } else {
                //         Get.to(() => FillAddDetails(
                //               businessId: businessId.value,
                //               businessName: businessName.value,
                //               token: widget.token,
                //             ));
                //       }
                //     },
                //     title: Text(
                //       'Next',
                //       style: CustomTextStyles.buttonTextStyle
                //           .copyWith(color: AppColors.whiteColor),
                //     ),
                //     horizentalPadding: 5.h,
                //     verticalPadding: .8.h,
                //     bgColor: AppColors.mainColor,
                //     titleColor: AppColors.whiteColor),
                // getVerticalSpace(6.4.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
