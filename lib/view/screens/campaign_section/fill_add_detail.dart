import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm/controller/custom_widgets/widgets.dart';
import 'package:ttpdm/view/screens/campaign_section/poster_screen.dart';

class FillAddDetails extends StatelessWidget {
  final String businessId;
  final String token;
  final String businessName;
  FillAddDetails(
      {super.key,
      required this.businessId,
      required this.businessName,
      required this.token});

  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController businessDescriptionController =
      TextEditingController();

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
          "Add Campaign",
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
          padding: EdgeInsets.symmetric(horizontal: 2.4.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                            color: index == 0 || index == 1
                                ? AppColors.mainColor
                                : const Color(0xffC3C3C2)),
                      );
                    },
                  ),
                ),
                getVerticalSpace(2.4.h),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Fill Campaign details',
                    style: CustomTextStyles.buttonTextStyle.copyWith(
                        fontSize: 14.px,
                        fontWeight: FontWeight.w600,
                        color: AppColors.blackColor),
                  ),
                ),
                getVerticalSpace(3.3.h),
                Text(
                  "Ads Name",
                  style: CustomTextStyles.onBoardingHeading.copyWith(
                      color: const Color(0xff191918),
                      fontSize: 14.px,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'bold'),
                ),
                getVerticalSpace(.4.h),
                customTextFormField(
                  controller: businessNameController,
                  bgColor: AppColors.whiteColor,
                ),
                getVerticalSpace(1.2.h),
                Text(
                  "Campaign Descriptions",
                  style: CustomTextStyles.onBoardingHeading.copyWith(
                      color: const Color(0xff191918),
                      fontSize: 14.px,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'bold'),
                ),
                getVerticalSpace(.4.h),
                customTextFormField(
                    controller: businessDescriptionController,
                    maxLine: 4,
                    bgColor: AppColors.whiteColor),
                getVerticalSpace(27.h),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: customElevatedButton(
                      onTap: () {
                        if (businessNameController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Please enter your campaign name')));
                        } else if (businessDescriptionController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Please enter your campaign Description')));
                        } else if (businessDescriptionController.text.length <
                            50) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  'Description length At least 50 character')));
                        } else {
                          Get.to(() => PosterScreen(
                                businessId: businessId,
                                businessName: businessName,
                                campaignName: businessNameController.text,
                                campaignDescription:
                                    businessDescriptionController.text,
                                token: token,
                              ));
                        }
                      },
                      title: Text(
                        'Next',
                        style: CustomTextStyles.buttonTextStyle
                            .copyWith(color: AppColors.whiteColor),
                      ),
                      horizentalPadding: 5.h,
                      verticalPadding: .8.h,
                      bgColor: AppColors.mainColor,
                      titleColor: AppColors.whiteColor),
                ),
                getVerticalSpace(6.4.h)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
