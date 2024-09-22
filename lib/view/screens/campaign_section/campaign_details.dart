import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm/controller/custom_widgets/widgets.dart';
import 'package:ttpdm/controller/getx_controllers/add_campaign_controller.dart';
import 'package:ttpdm/controller/getx_controllers/get_stripe_key_controller.dart';
import 'package:ttpdm/controller/getx_controllers/subcription_controller.dart';
import 'package:ttpdm/controller/utils/alert_box.dart';

import '../../../controller/custom_widgets/app_colors.dart';

class CampaignDetails extends StatefulWidget {
  final String businessId;
  final String businessName;
  final String campaignName;
  final String campaignDescription;
  final File selectedPoster;
  final String campaignPlatForms;
  final String startDate;
  final String endDate;
  final String startTime;
  final String endTime;
  final String token;
  final int numberOfPlatforms;
  const CampaignDetails(
      {super.key,
      required this.businessId,
      required this.campaignName,
      required this.campaignDescription,
      required this.selectedPoster,
      required this.campaignPlatForms,
      required this.startDate,
      required this.endDate,
      required this.startTime,
      required this.endTime,
      required this.businessName,
      required this.numberOfPlatforms,
      required this.token});

  @override
  State<CampaignDetails> createState() => _CampaignDetailsState();
}

class _CampaignDetailsState extends State<CampaignDetails> {
  final AddCampaignController addCampaignController =
      Get.put(AddCampaignController());
  final SubscriptionController subscriptionController =
      Get.put(SubscriptionController());
  double socialFee = 0.5;
  int dayFee = 3;
  int hourFee = 1;
  double? totalFee;
  late GetStripeKeyController getStripeKeyController;
  @override
  void initState() {
    super.initState();
    getStripeKeyController=Get.put(GetStripeKeyController(context: context));
    getStripeKeyController.fetchStripeKey(loading: true).then((_) {
      getStripeKeyController.keyLoading.value = false; // Update loading state
    });
    feeCalculation();
  }

  void feeCalculation() {
    DateTime startDate = DateTime.parse(widget.startDate);
    DateTime endDate = DateTime.parse(widget.endDate);
    final difference = endDate.difference(startDate);
    int totalDays = difference.inDays;
    DateTime dateForTime = startDate; // Use startDate or another valid date
    DateTime startTime = DateTime.parse('${dateForTime.toIso8601String().split("T")[0]} ${widget.startTime}'); // E.g., "2024-05-25 09:00"
    DateTime endTime = DateTime.parse('${dateForTime.toIso8601String().split("T")[0]} ${widget.endTime}'); // E.g., "2024-05-25 17:30"
    Duration hours = endTime.difference(startTime);
    int numberOfHours = hours.inHours;
    totalFee = (socialFee * widget.numberOfPlatforms) +
        (dayFee * totalDays) +
        (hourFee * numberOfHours) ;

    log("platform:${widget.campaignPlatForms}");
    log("totalDays:$totalDays");
    log("numberOfHours:$numberOfHours");
    // Round off total fee to 2 decimal places
    totalFee = double.parse(totalFee!.toStringAsFixed(2));

    // Debug output
    log('Total fee: $totalFee');
  }

  @override
  Widget build(BuildContext context) {
    String range = '';

    return Scaffold(
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
          padding: EdgeInsets.symmetric(horizontal: 2.5.h),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                          color: index == 0 ||
                                  index == 1 ||
                                  index == 2 ||
                                  index == 3 ||
                                  index == 4
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
                    borderRadius: BorderRadius.circular(2.h)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ad Banner',
                      style: TextStyle(
                          fontSize: 14.px,
                          fontFamily: 'bold',
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff191918)),
                    ),
                    getVerticalSpace(.5.h),
                    Container(
                      height: 24.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1.h),
                          image: DecorationImage(
                              image: NetworkImage(widget.selectedPoster.path),
                              fit: BoxFit.cover)),
                    ),
                    getVerticalSpace(1.2.h),
                    const Divider(
                      color: Color(0xff6E6E6D),
                      thickness: 1,
                    ),
                    getVerticalSpace(1.2.h),
                    Text(
                      'Business Profile',
                      style: TextStyle(
                          fontSize: 14.px,
                          fontFamily: 'bold',
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff191918)),
                    ),
                    getVerticalSpace(.8.h),
                    Text(
                      widget.businessName,
                      style: TextStyle(
                          fontSize: 14.px,
                          fontFamily: 'bold',
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff6E6E6D)),
                    ),
                    getVerticalSpace(1.2.h),
                    const Divider(
                      color: Color(0xff6E6E6D),
                      thickness: 1,
                    ),
                    Text(
                      'Ads Name',
                      style: TextStyle(
                          fontSize: 14.px,
                          fontFamily: 'bold',
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff191918)),
                    ),
                    getVerticalSpace(.8.h),
                    Text(
                      widget.campaignName,
                      style: TextStyle(
                          fontSize: 14.px,
                          fontFamily: 'bold',
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff6E6E6D)),
                    ),
                    getVerticalSpace(1.2.h),
                    const Divider(
                      color: Color(0xff6E6E6D),
                      thickness: 1,
                    ),
                    getVerticalSpace(1.2.h),
                    Text(
                      'What’s the business name?',
                      style: TextStyle(
                          fontSize: 14.px,
                          fontFamily: 'bold',
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff191918)),
                    ),
                    getVerticalSpace(.8.h),
                    Text(
                      widget.businessName,
                      style: TextStyle(
                          fontSize: 14.px,
                          fontFamily: 'bold',
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff6E6E6D)),
                    ),
                    getVerticalSpace(1.2.h),
                    const Divider(
                      color: Color(0xff6E6E6D),
                      thickness: 1,
                    ),
                    getVerticalSpace(1.2.h),
                    Text(
                      'Campaign Descriptions',
                      style: TextStyle(
                          fontSize: 14.px,
                          fontFamily: 'bold',
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff191918)),
                    ),
                    getVerticalSpace(1.2.h),
                    Text(
                      widget.campaignDescription,
                      style: TextStyle(
                          fontSize: 12.px,
                          fontFamily: 'bold',
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff6E6E6D)),
                    ),
                    getVerticalSpace(1.2.h),
                    const Divider(
                      color: Color(0xff6E6E6D),
                      thickness: 1,
                    ),
                    getVerticalSpace(1.2.h),
                    Text(
                      'Campaign Platform ',
                      style: TextStyle(
                          fontSize: 14.px,
                          fontFamily: 'bold',
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff191918)),
                    ),
                    getVerticalSpace(.8.h),
                    Text(
                      widget.campaignPlatForms,
                      style: TextStyle(
                          fontSize: 14.px,
                          fontFamily: 'bold',
                          fontWeight: FontWeight.w500,
                          color: AppColors.mainColor),
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
                          color: const Color(0xff191918)),
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
                                image: AssetImage('assets/pngs/dateicon.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: .8.h),
                            Text(
                              range.isNotEmpty
                                  ? range
                                  : "${widget.startDate} To ${widget.endTime}",
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
                          color: const Color(0xff191918)),
                    ),
                    getVerticalSpace(1.2.h),
                    Text(
                      range.isNotEmpty
                          ? range
                          : "${widget.startTime} To ${widget.endTime}",
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
              ),
              getVerticalSpace(1.h),
              Row(
                children: [
                  Text(
                    'Your Campaign Fee',
                    style: TextStyle(
                        fontSize: 14.px,
                        fontFamily: 'bold',
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff191918)),
                  ),
                  const Expanded(child: SizedBox()),
                  Text(
                    "\$${totalFee.toString()}",
                    style: TextStyle(
                        fontSize: 14.px,
                        fontFamily: 'bold',
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff191918)),
                  ),
                ],
              ),
              getVerticalSpace(4.3.h),
               Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customElevatedButton(
                        onTap: () {
                          if (totalFee != null) {
                            openCampaignSubmit(
                                context ,totalFee!,
                              campaignName: widget .campaignName,
                              campaignDescription:widget . campaignDescription,
                              businessId:widget .businessId ,
                              selectedPoster:widget .selectedPoster ,
                              campaignPlatForms:widget.campaignPlatForms,
                              startDate:addCampaignController.startFormatDate.value ,
                              endDate: addCampaignController.endFormatDate.value ,
                              startTime:widget .startTime ,
                              endTime: widget.endTime,
                              businessName: widget.businessName,
                              token: widget .token, clientSecretKey:getStripeKeyController.stripeKey.value!.secretKey.toString(),
                            );
                          }

                        },
                        title:
                            Text(
                                'Submit',
                                style: CustomTextStyles.buttonTextStyle
                                    .copyWith(color: AppColors.whiteColor),
                              ),
                        bgColor: AppColors.mainColor,
                        titleColor: AppColors.whiteColor,
                        horizentalPadding: 5.h,
                        verticalPadding: .8.h),
                  ],
                ),

              getVerticalSpace(3.h),
            ]),
          ),
        ),
      ),
    );
  }
}
