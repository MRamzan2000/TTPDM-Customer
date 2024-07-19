import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm/controller/custom_widgets/widgets.dart';

import '../../../controller/custom_widgets/app_colors.dart';
import '../../../controller/custom_widgets/custom_text_styles.dart';
import '../../../controller/getx_controllers/add_campaign_controller.dart';
import 'business_profile.dart';

class EditProfile extends StatelessWidget {
  final String? title;
  final AddCampaignController addCampaignController =
      Get.put(AddCampaignController());
  final TextEditingController bsNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController targetController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  EditProfile({super.key,this.title});
  final RxList<String> profilesList = <String>[
    'Business Profile One',
    'Business Profile Two',
    'Business Profile Three'
  ].obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Edit Business Profile',
          style: CustomTextStyles.buttonTextStyle.copyWith(
              fontSize: 20.px,
              fontWeight: FontWeight.w600,
              color: AppColors.mainColor),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              if (phoneNumberController.text.isEmpty &&
                  bsNameController.text.isEmpty &&
                  descriptionController.text.isEmpty &&
                  locationController.text.isEmpty &&
                  targetController.text.isEmpty &&
                  addCampaignController.pickedMediaList.isEmpty) {
                Get.snackbar('Sorry', 'All fields are required');
              } else {
                Get.to(() => BusinessProfile(
                      phoneNumber: phoneNumberController.text,
                      businessName: bsNameController.text,
                      description: descriptionController.text,
                      location: locationController.text,
                      targetArea: targetController.text,
                      imagesList: addCampaignController.pickedMediaList,
                  logo:addCampaignController.image.value ,
                    ));
              }
            },
            child: Padding(
                padding: EdgeInsets.only(right: 2.h),
                child: Text(
                  'Save',
                  style: TextStyle(
                      fontSize: 16.px,
                      color: const Color(0xff34C759),
                      fontFamily: 'bold',
                      fontWeight: FontWeight.w600),
                )),
          )
        ],
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
                    Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(onTap: () {
                            addCampaignController
                                .pickImage(ImageSource.gallery);
                          }, child: Obx(() {
                            // Check if image is not null
                            if (addCampaignController.image.value != null) {
                              return ClipOval(
                                child: Image.file(
                                  addCampaignController.image.value!,
                                  fit: BoxFit.cover,
                                  width: 4.2.h *
                                      2, // Adjust width to match CircleAvatar's diameter
                                  height: 4.2.h *
                                      2, // Adjust height to match CircleAvatar's diameter
                                ),
                              );
                            } else {
                              return CircleAvatar(
                                radius: 4.2.h,
                                child: const Icon(Icons.add_a_photo),
                              );
                            }
                          })),
                          getVerticalSpace(.8.h),
                          Text(
                            'Logo',
                            style: TextStyle(
                                fontSize: 14.px,
                                color: const Color(0xff454544),
                                fontFamily: 'regular',
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    ),
                    getVerticalSpace(4.h),
                    Text(
                      'Business Name',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'bold',
                          color: const Color(0xff454544),
                          fontSize: 14.px),
                    ),
                    getVerticalSpace(.8.h),
                    customTextFormField(
                        controller: bsNameController,
                        bgColor: AppColors.whiteColor),
                    getVerticalSpace(1.6.h),
                    Text(
                      'Phone Number',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'bold',
                          color: const Color(0xff454544),
                          fontSize: 14.px),
                    ),
                    getVerticalSpace(.8.h),
                    customTextFormField(
                        controller: phoneNumberController,
                        keyboardType: TextInputType.number,
                        bgColor: AppColors.whiteColor),
                    getVerticalSpace(1.6.h),
                    Text(
                      'Location',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'bold',
                          color: const Color(0xff454544),
                          fontSize: 14.px),
                    ),
                    getVerticalSpace(.8.h),
                    customTextFormField(
                        controller: locationController,
                        keyboardType: TextInputType.text,
                        bgColor: AppColors.whiteColor),
                    getVerticalSpace(1.6.h),
                    Text(
                      'Target Map Area',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'bold',
                          color: const Color(0xff454544),
                          fontSize: 14.px),
                    ),
                    getVerticalSpace(.8.h),
                    customTextFormField(
                        controller: targetController,
                        keyboardType: TextInputType.text,
                        bgColor: AppColors.whiteColor),
                    getVerticalSpace(1.6.h),
                    Text(
                      "What’s your website URL?",
                      style: CustomTextStyles.onBoardingHeading.copyWith(
                          color: const Color(0xff191918),
                          fontSize: 14.px,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'bold'),
                    ),getVerticalSpace(.8.h),
                    Text(
                      "This could be a web page or social media page",
                      style: CustomTextStyles.onBoardingHeading.copyWith(
                          color: const Color(0xff6E6E6D),
                          fontSize: 12.px,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'regular'),
                    ),
                    getVerticalSpace(.8.h),
                    customTextFormField(bgColor: AppColors.whiteColor),
                    getVerticalSpace(1.6.h),
                    Text(
                      "Facebook",
                      style: CustomTextStyles.onBoardingHeading.copyWith(
                          color: const Color(0xff191918),
                          fontSize: 14.px,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'bold'),
                    ),getVerticalSpace(.8.h),
                    customTextFormField(bgColor: AppColors.whiteColor, title: 'Enter your Facebook Account',),
                    getVerticalSpace(1.6.h),
                    Text(
                      "Instagram",
                      style: CustomTextStyles.onBoardingHeading.copyWith(
                          color: const Color(0xff191918),
                          fontSize: 14.px,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'bold'),
                    ),
                    getVerticalSpace(.8.h),
                    customTextFormField(bgColor: AppColors.whiteColor,title: "Enter your Instagram Account"),
                    getVerticalSpace(1.6.h),
                    Text(
                      "Tiktok",
                      style: CustomTextStyles.onBoardingHeading.copyWith(
                          color: const Color(0xff191918),
                          fontSize: 14.px,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'bold'),
                    ),
                    getVerticalSpace(.8.h),
                    customTextFormField(bgColor: AppColors.whiteColor,title: "Enter your Tiktok Account"),
                    getVerticalSpace(1.6.h),
                    Text(
                      "Linkedin",
                      style: CustomTextStyles.onBoardingHeading.copyWith(
                          color: const Color(0xff191918),
                          fontSize: 14.px,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'bold'),
                    ),
                    getVerticalSpace(.8.h),
                    customTextFormField(bgColor: AppColors.whiteColor,title: "Enter your linkedin Account"),
                    getVerticalSpace(1.6.h),
                    Text(
                      'Business description',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'bold',
                          color: const Color(0xff454544),
                          fontSize: 14.px),
                    ),
                    getVerticalSpace(.8.h),
                    customTextFormField(
                        controller: descriptionController,
                        maxLine: 4,
                        keyboardType: TextInputType.text,
                        bgColor: AppColors.whiteColor),

                    getVerticalSpace(1.6.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Gallery',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'bold',
                              fontSize: 14.px,
                              color: const Color(0xff282827)),
                        ),
                        GestureDetector(
                          onTap: () {
                            addCampaignController.pickMedia();
                          },
                          child: Text(
                            'Upload',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: 'bold',
                                fontSize: 14.px,
                                color: const Color(0xff007AFF)),
                          ),
                        ),
                      ],
                    ),
                    getVerticalSpace(1.2.h),
                    addCampaignController.pickedMediaList.isEmpty|| title=='edit'
                        ? const SizedBox.shrink()
                        : Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              'You can upload your business images and videos',
                              style: TextStyle(
                                  fontSize: 12.px,
                                  color: const Color(0xff7C7C7C),
                                  fontFamily: 'regular',
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                    Obx(
                      () => addCampaignController.pickedMediaList.isEmpty
                          ? const SizedBox.shrink()
                          : SizedBox(
                              height: 50.3.h,
                              child: GridView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: addCampaignController
                                    .pickedMediaList.length,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        mainAxisSpacing: 2.1.h,
                                        crossAxisSpacing: 1.6.h),
                                itemBuilder: (context, index) {
                                  return Stack(
                                    children:[
                                      Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: .5.h, vertical: .5.h),
                                      height: 11.3.h,
                                      width: 11.6.h,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(1.h),
                                          color: AppColors.whiteColor,
                                          boxShadow: const [
                                            BoxShadow(
                                                offset: Offset(0, 1),
                                                spreadRadius: 0,
                                                blurRadius: 8,
                                                color: Color(0xffFFE4EA))
                                          ]),
                                      child: addCampaignController
                                                      .pickedMediaList[index]
                                                  ['isVideo'] ==
                                              "true"
                                          ? Image(
                                              image: FileImage(File(
                                                  addCampaignController
                                                          .pickedMediaList[index]
                                                      ['path']!)),fit: BoxFit.cover,)
                                          : Image(
                                              image: FileImage(File(
                                                  addCampaignController
                                                          .pickedMediaList[
                                                      index]['path']!)),fit: BoxFit.cover,),
                                    ),
                                  ]
                                  );
                                },
                              ),
                            ),
                    ),
                    getVerticalSpace(2.h),
                  ]),
            ),
          )),
    );
  }
}
