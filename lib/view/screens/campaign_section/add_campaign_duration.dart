import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:ttpdm/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm/controller/custom_widgets/widgets.dart';
import 'package:ttpdm/controller/getx_controllers/get_campaign_rules_controller.dart';
import 'package:ttpdm/controller/utils/alert_box.dart';
import 'package:ttpdm/view/screens/campaign_section/campaign_details.dart';
import '../../../controller/getx_controllers/add_campaign_controller.dart';

class AddCampaignDuration extends StatefulWidget {
  final String businessId;
  final String businessName;
  final String campaignName;
  final String campaignDescription;
  final File selectedPoster;
  final String token;
  const AddCampaignDuration(
      {super.key,
      required this.businessId,
      required this.campaignName,
      required this.campaignDescription,
      required this.selectedPoster,
      required this.businessName,
      required this.token});

  @override
  State<AddCampaignDuration> createState() => _AddCampaignDurationState();
}

class _AddCampaignDurationState extends State<AddCampaignDuration> {
  final AddCampaignController addCampaignController =
      Get.put(AddCampaignController());

  final Rx<DateTime> minTime = DateTime(2023, 01, 01, 1).obs;
  // 1:00 AM
  final Rx<DateTime> maxTime = DateTime(2023, 01, 02, 0).obs;
  // 24:00 PM
  final Rx<DateTime> startTime = DateTime(2023, 01, 01, 8).obs;
  // Default start time: 8:00 AM
  final Rx<DateTime> endTime = DateTime(2023, 01, 01, 16).obs;
  // Default end time: 4:00 PM (16:00)
  late CampaignRuleController campaignRuleController;

  @override
  void initState() {
    super.initState();
    campaignRuleController = Get.put(CampaignRuleController(context: context));
    fetchRules();

  }
void fetchRules(){
  WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) async {
      await campaignRuleController
          .fetchCampaignRules(
          isLoading: campaignRuleController.allRules.value == null)
          .then(
            (value) {
          log("campaignRuleController :${campaignRuleController.allRules.value?.advyroSocialPages}");
        },
      );
    },
  );
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
          style: CustomTextStyles.buttonTextStyle.copyWith(
              fontSize: 20.px,
              fontWeight: FontWeight.w600,
              color: AppColors.mainColor),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
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
                            index == 0 || index == 1 || index == 2 || index == 3
                                ? AppColors.mainColor
                                : const Color(0xffC3C3C2)),
                  );
                },
              ),
            ),
            getVerticalSpace(2.4.h),
            Text(
              'Add Campaign Duration & Platform',
              style: CustomTextStyles.buttonTextStyle.copyWith(
                  fontSize: 14.px,
                  fontWeight: FontWeight.w600,
                  color: AppColors.blackColor),
            ),
            getVerticalSpace(2.1.h),
            Obx(
              () => Container(
                margin: EdgeInsets.symmetric(horizontal: 2.4.h),
                padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.5.h),
                decoration: BoxDecoration(
                    color: const Color(0xffFFFFFF),
                    borderRadius: BorderRadius.circular(2.h)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Campaign Platform ',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.px,
                          color: const Color(0xff191918),
                          fontFamily: 'bold'),
                    ),
                    getVerticalSpace(.8.h),
                    Text(
                      'Please select the platform',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.px,
                          color: const Color(0xff454544),
                          fontFamily: 'regular'),
                    ),
                    getVerticalSpace(1.h),
                    campaignRuleController.rulesLoading.value
                        ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: List.generate(6, (index) => Container(
                            width: 100,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.h),
                            ),
                          )),
                        ),
                      ),
                    )
                        :
                    Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 8.0, // Adjust spacing between items as needed
                      runSpacing: 8.0, // Adjust vertical spacing
                      children: [
                        if (campaignRuleController
                            .allRules.value!.advyroSocialPages)
                          GestureDetector(
                            onTap: () {
                              if (!selectionLst
                                  .contains('Advyro Social Media pages')) {
                                selectionLst.add('Advyro Social Media pages');
                              } else {
                                selectionLst
                                    .remove('Advyro Social Media pages');
                              }
                              log("$selectionLst");
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: .8.h, vertical: 1.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.h),
                                color: selectionLst
                                        .contains('Advyro Social Media pages')
                                    ? AppColors.mainColor
                                    : const Color(0xffE0E0DF),
                              ),
                              child: Text(
                                'Advyro Social Media pages',
                                style: TextStyle(
                                  fontFamily: 'bold',
                                  color: selectionLst
                                          .contains('Advyro Social Media pages')
                                      ? AppColors.whiteColor
                                      : const Color(0xff454544),
                                  fontSize: 11.px,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        if (campaignRuleController.allRules.value!.facebook)
                          GestureDetector(
                            onTap: () {
                              if (!selectionLst.contains('Facebook')) {
                                selectionLst.add('Facebook');
                              } else {
                                selectionLst.remove('Facebook');
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: .8.h, vertical: 1.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.h),
                                color: selectionLst.contains('Facebook')
                                    ? AppColors.mainColor
                                    : const Color(0xffE0E0DF),
                              ),
                              child: Text(
                                'Facebook',
                                style: TextStyle(
                                  fontFamily: 'bold',
                                  color: selectionLst.contains('Facebook')
                                      ? AppColors.whiteColor
                                      : const Color(0xff454544),
                                  fontSize: 11.px,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        if (campaignRuleController.allRules.value!.tiktok)
                          GestureDetector(
                            onTap: () {
                              if (!selectionLst.contains('TIKTOK')) {
                                selectionLst.add('TIKTOK');
                              } else {
                                selectionLst.remove('TIKTOK');
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: .8.h, vertical: 1.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.h),
                                color: selectionLst.contains('TIKTOK')
                                    ? AppColors.mainColor
                                    : const Color(0xffE0E0DF),
                              ),
                              child: Text(
                                'TIKTOK',
                                style: TextStyle(
                                  fontFamily: 'bold',
                                  color: selectionLst.contains('TIKTOK')
                                      ? AppColors.whiteColor
                                      : const Color(0xff454544),
                                  fontSize: 11.px,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        if (campaignRuleController.allRules.value!.instagram)
                          GestureDetector(
                            onTap: () {
                              if (!selectionLst.contains('Instagram')) {
                                selectionLst.add('Instagram');
                              } else {
                                selectionLst.remove('Instagram');
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 1.6.h, vertical: 1.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.h),
                                color: selectionLst.contains('Instagram')
                                    ? AppColors.mainColor
                                    : const Color(0xffE0E0DF),
                              ),
                              child: Text(
                                'Instagram',
                                style: TextStyle(
                                  fontFamily: 'bold',
                                  color: selectionLst.contains('Instagram')
                                      ? AppColors.whiteColor
                                      : const Color(0xff454544),
                                  fontSize: 11.px,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        if (campaignRuleController.allRules.value!.youtube)
                          GestureDetector(
                            onTap: () {
                              if (!selectionLst.contains('Youtube')) {
                                selectionLst.add('Youtube');
                              } else {
                                selectionLst.remove('Youtube');
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 1.6.h, vertical: 1.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.h),
                                color: selectionLst.contains('Youtube')
                                    ? AppColors.mainColor
                                    : const Color(0xffE0E0DF),
                              ),
                              child: Text(
                                'Youtube',
                                style: TextStyle(
                                  fontFamily: 'bold',
                                  color: selectionLst.contains('Youtube')
                                      ? AppColors.whiteColor
                                      : const Color(0xff454544),
                                  fontSize: 11.px,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        if (campaignRuleController.allRules.value!.google)
                          GestureDetector(
                            onTap: () {
                              if (!selectionLst.contains('Google')) {
                                selectionLst.add('Google');
                              } else {
                                selectionLst.remove('Google');
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 1.6.h, vertical: 1.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.h),
                                color: selectionLst.contains('Google')
                                    ? AppColors.mainColor
                                    : const Color(0xffE0E0DF),
                              ),
                              child: Text(
                                'Google',
                                style: TextStyle(
                                  fontFamily: 'bold',
                                  color: selectionLst.contains('Google')
                                      ? AppColors.whiteColor
                                      : const Color(0xff454544),
                                  fontSize: 12.px,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            getVerticalSpace(1.6.h),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 2.4.h),
              padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.5.h),
              decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(2.h)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Date Schedule",
                    style: CustomTextStyles.onBoardingHeading.copyWith(
                        color: const Color(0xff191918),
                        fontSize: 14.px,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'bold'),
                  ),
                  getVerticalSpace(.4.h),
                  Text(
                    "Campaign duration",
                    style: CustomTextStyles.onBoardingHeading.copyWith(
                        color: const Color(0xff6E6E6D),
                        fontSize: 12.px,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'bold'),
                  ),
                  getVerticalSpace(1.2.h),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          addCampaignController.showDateRangePicker(context);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 1.2.h, vertical: .85.h),
                          height: 4.h,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.mainColor,
                            ),
                            borderRadius: BorderRadius.circular(5.h),
                          ),
                          child: Row(
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
                              Obx(
                                () => Text(
                                  addCampaignController.range.value.isNotEmpty
                                      ? addCampaignController.range.value
                                      : 'Select',
                                  style: TextStyle(
                                    color: addCampaignController
                                            .range.value.isNotEmpty
                                        ? AppColors.blackColor
                                        : AppColors.mainColor,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'bold',
                                    fontSize: 12.px,
                                  ),
                                ),
                              ),
                              getHorizentalSpace(3.h)
                            ],
                          ),
                        ),
                      ),
                      const Expanded(child: SizedBox())
                    ],
                  ),
                ],
              ),
            ),
            getVerticalSpace(1.6.h),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 2.4.h),
              padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.5.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2.h),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Time Duration",
                    style: TextStyle(
                        color: const Color(0xff191918),
                        fontSize: 14.px,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'bold'),
                  ),
                  SizedBox(height: 0.4.h),
                  Text(
                    "Choose the number of hours and the 8-hour time range.",
                    style: TextStyle(
                        color: const Color(0xff6E6E6D),
                        fontSize: 12.px,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'bold'),
                  ),
                  SizedBox(height: 1.2.h),
                  Obx(
                    () => SfRangeSlider(
                      min: minTime.value.millisecondsSinceEpoch.toDouble(),
                      max: maxTime.value.millisecondsSinceEpoch.toDouble(),
                      values: SfRangeValues(
                        startTime.value.millisecondsSinceEpoch.toDouble(),
                        endTime.value.millisecondsSinceEpoch.toDouble(),
                      ),
                      interval: 1000 * 60 * 60, // 1 hour in milliseconds
                      showTicks: true,
                      showLabels: true,
                      enableTooltip: true,
                      activeColor: AppColors.mainColor,
                      inactiveColor: const Color(0xffC3C3C2),
                      dateFormat: DateFormat('HH:mm'),
                      tooltipTextFormatterCallback:
                          (actualValue, formattedText) {
                        DateTime date = DateTime.fromMillisecondsSinceEpoch(
                            actualValue.toInt());
                        return DateFormat('HH:mm').format(
                            date); // Show time in 24-hour format with minutes
                      },
                      labelFormatterCallback: (actualValue, formattedText) {
                        DateTime date = DateTime.fromMillisecondsSinceEpoch(
                            actualValue.toInt());
                        if (actualValue ==
                                minTime.value.millisecondsSinceEpoch
                                    .toDouble() ||
                            actualValue ==
                                maxTime.value.millisecondsSinceEpoch
                                    .toDouble()) {
                          return DateFormat('HH')
                              .format(date); // Show time for min and max values
                        }
                        return '';
                      },
                      onChanged: (SfRangeValues values) {
                        if (values.end - values.start <= 8 * 60 * 60 * 1000) {
                          startTime.value = DateTime.fromMillisecondsSinceEpoch(
                              values.start.toInt());
                          endTime.value = DateTime.fromMillisecondsSinceEpoch(
                              values.end.toInt());
                        } else {
                          // If end time is more than 8 hours from start time, adjust end time
                          startTime.value = DateTime.fromMillisecondsSinceEpoch(
                              values.end.toInt() - 8 * 60 * 60 * 1000);
                          endTime.value = DateTime.fromMillisecondsSinceEpoch(
                              values.end.toInt());
                          log('Start Time: ${DateFormat('HH:mm').format(startTime.value)}');
                          log('End Time: ${DateFormat('HH:mm').format(endTime.value)}');
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            getVerticalSpace(11.3.h),
            customElevatedButton(
                onTap: () {
                  String concatenatedString = selectionLst.join(', ');
                  if (widget.campaignName.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Campaign name is required')));
                  } else if (widget.campaignDescription.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Campaign description is required')));
                  } else if (widget.businessId.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('business Id null')));
                  } else if (widget.selectedPoster.path.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Campaign poster is null')));
                  } else if (concatenatedString.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('At least one platform is selected')));
                  } else if (addCampaignController
                      .startFormatDate.value.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('please select campaign start date')));
                  } else if (addCampaignController
                      .endFormatDate.value.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('please select campaign end date')));
                  } else if (DateFormat('HH:mm')
                      .format(startTime.value)
                      .isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('please select campaign start time')));
                  } else if (DateFormat('HH:mm')
                      .format(endTime.value)
                      .isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('please select campaign end time')));
                  } else {
                    Get.to(() => CampaignDetails(
                          campaignName: widget.campaignName,
                          campaignDescription: widget.campaignDescription,
                          businessId: widget.businessId,
                          selectedPoster: widget.selectedPoster,
                          campaignPlatForms: concatenatedString,
                          startDate:
                              addCampaignController.startFormatDate.value,
                          endDate: addCampaignController.endFormatDate.value,
                          startTime:
                              DateFormat('HH:mm').format(startTime.value),
                          endTime: DateFormat('HH:mm').format(endTime.value),
                          businessName: widget.businessName,
                          token: widget.token,
                          numberOfPlatforms: selectionLst.length,
                      dayFee: campaignRuleController.allRules.value?.dayFee??0.0,
                      hourFee: campaignRuleController.allRules.value?.hourFee??0.0,
                      advyroSocialMediaPagesFee: campaignRuleController.allRules.value?.advyroSocialMediaPagesFee??0.0,
                      advyroFacebookFee: campaignRuleController.allRules.value?.advyroFacebookFee??0.0,
                      advyroTiktokFee: campaignRuleController.allRules.value?.advyroTiktokFee??0.0,
                      advyroInstagramFee: campaignRuleController.allRules.value?.advyroInstagramFee??0.0,
                      advyroYoutubeFee: campaignRuleController.allRules.value?.advyroYoutubeFee??0.0,
                      advyroGoogleFee: campaignRuleController.allRules.value?.advyroGoogleFee??0.0,
                        ));
                  }
                },
                title: Text(
                  'Next',
                  style: CustomTextStyles.buttonTextStyle
                      .copyWith(color: AppColors.whiteColor),
                ),
                bgColor: AppColors.mainColor,
                titleColor: AppColors.whiteColor,
                horizentalPadding: 5.h,
                verticalPadding: .8.h)
          ],
        ),
      ),
    );
  }
}
