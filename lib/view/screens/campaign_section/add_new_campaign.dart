
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:ttpdm/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm/controller/custom_widgets/widgets.dart';
import 'package:ttpdm/controller/getx_controllers/add_campaign_controller.dart';




class AddsCampaign extends StatefulWidget {
    const AddsCampaign({super.key});

  @override
  State<AddsCampaign> createState() => _AddsCampaignState();
}

class _AddsCampaignState extends State<AddsCampaign> {


final AddCampaignController addCampaignController=Get.put(AddCampaignController());
  @override
  Widget build(BuildContext context) {
    Rx<DateTime> minTime = DateTime(2023, 01, 01, 1).obs; // 1:00 AM
    Rx<DateTime> maxTime = DateTime(2023, 01, 02, 0).obs; // 24:00 PM
    Rx<DateTime> startTime = DateTime(2023, 01, 01, 8).obs; // Default start time: 8:00 AM
    Rx<DateTime> endTime = DateTime(2023, 01, 01, 16).obs; // Default end time: 4:00 PM (16:00)

    return Scaffold(
        body: SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.4.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getVerticalSpace(5.h),
              Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios_outlined,
                    size: 2.4.h,
                    color: const Color(0xff191918),
                  ),
                  const Expanded(child: SizedBox()),
                  Text('Add Campaign',
                      style: CustomTextStyles.onBoardingHeading.copyWith(
                          fontWeight: FontWeight.w600, fontSize: 20.px)),
                  const Expanded(child: SizedBox()),
                ],
              ),
              getVerticalSpace(2.4.h),
              Text(
                "Ads Name",
                style: CustomTextStyles.onBoardingHeading.copyWith(
                    color: const Color(0xff191918),
                    fontSize: 14.px,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'bold'),
              ),
              getVerticalSpace(.8.h),
              customTextFormField(
                bgColor: AppColors.whiteColor,
              ),
              getVerticalSpace(1.2.h),
              Text(
                "What’s the business name?",
                style: CustomTextStyles.onBoardingHeading.copyWith(
                    color: const Color(0xff191918),
                    fontSize: 14.px,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'bold'),
              ),
              getVerticalSpace(.8.h),
              customTextFormField(
                bgColor: AppColors.whiteColor,
              ),
              getVerticalSpace(1.2.h),
              Text(
                "What’s your website URL?",
                style: CustomTextStyles.onBoardingHeading.copyWith(
                    color: const Color(0xff191918),
                    fontSize: 14.px,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'bold'),
              ),
              getVerticalSpace(.4.h),
              Text(
                "This could be a web page or social media page",
                style: CustomTextStyles.onBoardingHeading.copyWith(
                    color: const Color(0xff6E6E6D),
                    fontSize: 12.px,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'bold'),
              ),
              getVerticalSpace(.8.h),
              customTextFormField(bgColor: AppColors.whiteColor),
              getVerticalSpace(1.2.h),
              Text(
                "Campaign Descriptions",
                style: CustomTextStyles.onBoardingHeading.copyWith(
                    color: const Color(0xff191918),
                    fontSize: 14.px,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'bold'),
              ),
              getVerticalSpace(.8.h),
              customTextFormField(bgColor: AppColors.whiteColor, maxLine: 4),
              getVerticalSpace(1.2.h),
              Text(
                "Total Campaign Budget",
                style: CustomTextStyles.onBoardingHeading.copyWith(
                    color: const Color(0xff191918),
                    fontSize: 14.px,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'bold'),
              ),
              getVerticalSpace(.4.h),
              Text(
                "This could be up and down according to ad scheduling.",
                style: CustomTextStyles.onBoardingHeading.copyWith(
                    color: const Color(0xff6E6E6D),
                    fontSize: 12.px,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'bold'),
              ),
              getVerticalSpace(.8.h),
              customTextFormField(bgColor: AppColors.whiteColor),
              getVerticalSpace(1.2.h),
            Container(padding: EdgeInsets.all(1.6.h),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(2.h)
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
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

                GestureDetector(
                  onTap: () async {
                    addCampaignController.showDateRangePicker(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 1.2.h, vertical: .85.h),

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
                        Obx(()=>
                            Text(
                              addCampaignController.range.value.isNotEmpty ? addCampaignController.range.value : 'Select',
                              style: TextStyle(
                                color: addCampaignController.range.value.isNotEmpty ? AppColors.blackColor:AppColors.mainColor,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'bold',
                                fontSize: 12.px,
                              ),
                            ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],),
            ),
              getVerticalSpace(1.6.h),

              Container(
                padding: EdgeInsets.all(1.6.h),
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
                    Obx(()=>
                        SfRangeSlider(
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
                          tooltipTextFormatterCallback: (actualValue, formattedText) {
                            DateTime date = DateTime.fromMillisecondsSinceEpoch(actualValue.toInt());
                            return DateFormat('HH:mm').format(date); // Show time in 24-hour format with minutes
                          },
                          labelFormatterCallback: (actualValue, formattedText) {
                            DateTime date = DateTime.fromMillisecondsSinceEpoch(actualValue.toInt());
                            if (actualValue == minTime.value.millisecondsSinceEpoch.toDouble() ||
                                actualValue == maxTime.value.millisecondsSinceEpoch.toDouble()) {
                              return DateFormat('HH').format(date); // Show time for min and max values
                            }
                            return '';
                          },
                          onChanged: (SfRangeValues values) {
                            // Ensure the selected range end time is not more than 8 hours from start time
                            if (values.end - values.start <= 8 * 60 * 60 * 1000) {
                              startTime.value = DateTime.fromMillisecondsSinceEpoch(values.start.toInt());
                              endTime.value = DateTime.fromMillisecondsSinceEpoch(values.end.toInt());
                            } else {
                              // If end time is more than 8 hours from start time, adjust end time
                              startTime.value = DateTime.fromMillisecondsSinceEpoch(values.end.toInt() - 8 * 60 * 60 * 1000);
                              endTime.value = DateTime.fromMillisecondsSinceEpoch(values.end.toInt());
                            }
                          },
                        ),
                    ),


                  ],
                ),
              ),

              getVerticalSpace(1.2.h),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: 'Add Image or video',
                  style: CustomTextStyles.onBoardingHeading.copyWith(
                      color: const Color(0xff191918),
                      fontSize: 14.px,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'bold'),
                ),
                TextSpan(
                  text: '( Its optional )',
                  style: CustomTextStyles.onBoardingHeading.copyWith(
                      color: const Color(0xff6E6E6D),
                      fontSize: 14.px,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'bold'),
                )
              ])),
              getVerticalSpace(1.2.h),
              Obx(()=>
                 ListView.builder(shrinkWrap: true,padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: addCampaignController.pickedMediaList.length,
                    itemBuilder: (context, index) {
                  return
                      Container(padding: EdgeInsets.all(.8.h),
                        margin: EdgeInsets.symmetric(vertical: .5.h),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                        ),
                        child:Row(crossAxisAlignment: CrossAxisAlignment.center
                          ,mainAxisAlignment: MainAxisAlignment.start,children: [
                          SizedBox(height: 4.h,width: 4.h,
                              child:
                              addCampaignController.pickedMediaList[index]['isVideo']=="true"?SvgPicture.asset('assets/svgs/videoicon.svg'):

                              Image.asset('assets/pngs/pngicon.png',fit: BoxFit.cover,)),
                          getHorizentalSpace(.8.h),
                          Column(crossAxisAlignment: CrossAxisAlignment.start
                            ,mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              addCampaignController.pickedMediaList[index]['isVideo']=="true"?
                              Text("video.${addCampaignController.pickedMediaList[index]['type']!}",style: TextStyle(
                                  color: const Color(0xff191918),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'bold',
                                  fontSize: 14.px
                              ),):
                              Text("Image.${addCampaignController.pickedMediaList[index]['type']!}",style: TextStyle(
                                color: const Color(0xff191918),
                                fontWeight: FontWeight.w400,
                                fontFamily: 'bold',
                                fontSize: 14.px
                            ),),
                            getVerticalSpace(.4.h),
                            Text(addCampaignController.pickedMediaList[index]['size']!,style: TextStyle(
                                color: const Color(0xff191918),
                                fontWeight: FontWeight.w400,
                                fontFamily: 'bold',
                                fontSize: 14.px
                            ),),

                          ],),const Expanded(child: SizedBox()),
                            GestureDetector(onTap: (){

                            },
                                child: SvgPicture.asset('assets/svgs/crossicon.svg'))
                        ],)
                      );
                }),
              ),
              getVerticalSpace(1.2.h),
              Row(
                children: [
                  GestureDetector(onTap: (){
                    addCampaignController.pickMedia();
                  },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 1.h, vertical: .85.h),
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
                                image: AssetImage('assets/pngs/attachfile.png'),
                                fit: BoxFit.cover,
                              )),
                          getHorizentalSpace(.8.h),
                          Text(
                            'Attachment ',
                            style: TextStyle(
                                color: AppColors.mainColor,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'bold',
                                fontSize: 12.px),
                          )
                        ],
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                ],
              ),
              getVerticalSpace(4.h),
              Align(
                alignment: Alignment.center,
                child: customElevatedButton(
                    title:Text(
                      'Submit',
                      style: CustomTextStyles.buttonTextStyle.copyWith(color:AppColors.whiteColor ),
                    ),
                    onTap: () {
                      // Get.to(() =>   CampaignName( ));
                    },
                    bgColor: AppColors.mainColor,
                    titleColor: AppColors.whiteColor,
                    verticalPadding: 1.2.h,
                    horizentalPadding: 5.h),
              ),
              getVerticalSpace(2.4.h)
            ],
          ),
        ),
      ),
    ));
  }


}






