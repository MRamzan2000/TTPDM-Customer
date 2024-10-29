import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ttpdm/controller/apis_services/get_fcm_send_notification_api.dart';
import 'package:ttpdm/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm/controller/custom_widgets/widgets.dart';
import 'package:ttpdm/controller/extensions.dart';
import 'package:ttpdm/controller/getx_controllers/add_campaign_controller.dart';
import 'package:ttpdm/controller/getx_controllers/add_card_controller.dart';
import 'package:ttpdm/controller/getx_controllers/get_fcm_token_send_notification_controller.dart';
import 'package:ttpdm/controller/getx_controllers/image_picker_controller.dart';
import 'package:ttpdm/controller/getx_controllers/poster_controller.dart';
import 'package:ttpdm/controller/getx_controllers/subcription_controller.dart';
import 'package:ttpdm/controller/getx_controllers/wallet_controller.dart';
import 'package:ttpdm/controller/utils/apis_constant.dart';
import 'package:ttpdm/controller/utils/preference_key.dart';
import 'package:ttpdm/controller/utils/stripe_method.dart';
import 'package:ttpdm/view/screens/auth_section/login_screen.dart';
import 'package:ttpdm/view/screens/bottom_navigationbar.dart';

import '../getx_controllers/user_profile_controller.dart';
import 'my_shared_prefrence.dart';

RxList<String> selectionLst = <String>[].obs;
final AddCampaignController addCampaignController = Get.put(AddCampaignController());

void openChooseEditProfile(
  BuildContext context, {
  required String name,
  required String token,
  required String profileImage,
}) {
  final TextEditingController nameController = TextEditingController();
  final ImagePickerController imagePickerController = Get.put(ImagePickerController());
  final UserProfileController userProfileController = Get.put(UserProfileController(context: context));


  void resetImagePicker() {
    imagePickerController.image.value = null;
  }

  showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.h),
          child: Material(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.h),
              height: 42.h,
              decoration: BoxDecoration(color: const Color(0xffF8F9FA), borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Expanded(child: SizedBox()),
                      getHorizentalSpace(5.h),
                      Text(
                        'Profile',
                        style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.blackColor, fontFamily: 'regular', fontSize: 20.px),
                      ),
                      const Expanded(child: SizedBox()),
                      getHorizentalSpace(5.h),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop(); // Close dialog
                          resetImagePicker(); // Reset image picker
                        },
                        child: SizedBox(height: 3.h, width: 3.h, child: const Image(image: AssetImage('assets/pngs/crossicon.png'))),
                      )
                    ],
                  ),
                  getVerticalSpace(2.h),
                  Obx(
                    () => GestureDetector(
                      onTap: () {
                        imagePickerController.pickImage(ImageSource.gallery);
                      },
                      child: imagePickerController.image.value == null
                          ? CircleAvatar(
                              radius: 6.h,
                              backgroundColor: AppColors.baseColor,
                              backgroundImage: NetworkImage(profileImage),
                            )
                          : CircleAvatar(
                              radius: 6.h,
                              backgroundColor: AppColors.baseColor,
                              backgroundImage: FileImage(File(imagePickerController.image.value!.path)),
                            ),
                    ),
                  ),
                  getVerticalSpace(1.3.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.h),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Name',
                        style: TextStyle(fontSize: 14.px, fontFamily: 'regular', fontWeight: FontWeight.w400, color: const Color(0xff454544)),
                      ),
                    ),
                  ),
                  getVerticalSpace(.8.h),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.h),
                        boxShadow: [
                          BoxShadow(color: const Color(0xff000000).withOpacity(0.25), blurRadius: 8, spreadRadius: 0, offset: const Offset(0, 1))
                        ],
                        color: AppColors.whiteColor),
                    child: customTextFormField1(
                      controller: nameController,
                      // Set the controller
                      title: name,
                      bgColor: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(3.h),
                      borderRadius1: BorderRadius.circular(3.h),
                    ),
                  ),
                  getVerticalSpace(2.6.h),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        customElevatedButton(
                            onTap: () {
                              userProfileController
                                  .uploadProfileImage(
                                      token: token,
                                      profileImage: imagePickerController.image.value?.path.isEmpty ?? true
                                          ? File("")
                                          : File(imagePickerController.image.value!.path),
                                      fullname: nameController.text.isEmpty ? name : nameController.text)
                                  .then(
                                (value) {
                                  Navigator.of(context).pop(); // Close dialog
                                },
                              );
                            },
                            title: userProfileController.uploading.value
                                ? spinkit
                                : Text(
                                    'Save',
                                    style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.whiteColor, fontFamily: 'bold'),
                                  ),
                            bgColor: AppColors.mainColor,
                            verticalPadding: .8.h,
                            horizentalPadding: 6.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

void openAlertBox(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.4.h),
          child: Material(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
              height: 60.5.h,
              decoration: BoxDecoration(color: const Color(0xffF8F9FA), borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(child: SizedBox()),
                      Text(
                        'Campaign poster design',
                        style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.blackColor),
                      ),
                      const Expanded(child: SizedBox()),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const SizedBox(height: 30, child: Image(image: AssetImage('assets/pngs/crossicon.png'))),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1.h),
                    child: Container(
                      height: 28.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1.h),
                          image: const DecorationImage(image: AssetImage('assets/pngs/poster.png'), fit: BoxFit.contain)),
                    ),
                  ),
                  getVerticalSpace(.6.h),
                  Padding(
                    padding: EdgeInsets.only(left: 1.6.h),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          text: 'Comment ',
                          style: CustomTextStyles.buttonTextStyle.copyWith(
                            color: AppColors.blackColor,
                          ),
                        ),
                        TextSpan(
                            text: ' (its optional )',
                            style: TextStyle(
                                fontFamily: 'bold', color: const Color(0xff454544).withOpacity(0.6), fontSize: 14.px, fontWeight: FontWeight.w400))
                      ])),
                    ),
                  ),
                  getVerticalSpace(.6.h),
                  Padding(
                    padding: EdgeInsets.only(left: 1.6.h),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: customTextFormField(maxLine: 4, bgColor: AppColors.whiteColor),
                    ),
                  ),
                  getVerticalSpace(.6.h),
                  Row(
                    children: [
                      Expanded(
                          child: customElevatedButton(
                              title: Text(
                                'Edit',
                                style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.whiteColor),
                              ),
                              verticalPadding: .8.h,
                              horizentalPadding: 1.6.h,
                              bgColor: const Color(0xffC3C3C2))),
                      getHorizentalSpace(1.4.h),
                      Expanded(
                          child: customElevatedButton(
                              onTap: () {
                                Get.back();
                              },
                              title: Text(
                                'Select',
                                style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.whiteColor),
                              ),
                              bgColor: AppColors.mainColor,
                              verticalPadding: .8.h,
                              horizentalPadding: 1.6.h)),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

void openCancelAlertBox(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.4.h),
          child: Material(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 2.h),
              height: 35.h,
              decoration: BoxDecoration(color: const Color(0xffF8F9FA), borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(child: SizedBox()),
                      Text(
                        'Campaign Cancel',
                        style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.blackColor),
                      ),
                      const Expanded(child: SizedBox()),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const SizedBox(height: 30, child: Image(image: AssetImage('assets/pngs/crossicon.png'))),
                      )
                    ],
                  ),
                  getVerticalSpace(.6.h),
                  const Divider(
                    color: Colors.grey,
                  ),
                  getVerticalSpace(2.4.h),
                  Text(
                    'Do you really want to cancel the campaign',
                    style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.mainColor),
                  ),
                  getVerticalSpace(.9.h),
                  Text(
                    'Admin fee will be apply on cancellation ',
                    style: CustomTextStyles.buttonTextStyle.copyWith(color: const Color(0xff7C7C7C)),
                  ),
                  getVerticalSpace(2.8.h),
                  Row(
                    children: [
                      Expanded(
                          child: customElevatedButton(
                              onTap: () {
                                Get.to(() => const CustomBottomNavigationBar());
                              },
                              title: Text(
                                'Yes',
                                style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.whiteColor),
                              ),
                              verticalPadding: .8.h,
                              horizentalPadding: 1.6.h,
                              bgColor: const Color(0xffC3C3C2))),
                      getHorizentalSpace(1.4.h),
                      Expanded(
                          child: customElevatedButton(
                              onTap: () {
                                Get.back();
                              },
                              title: Text(
                                'Continues',
                                style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.whiteColor),
                              ),
                              bgColor: AppColors.mainColor,
                              verticalPadding: .8.h,
                              horizentalPadding: 1.6.h)),
                    ],
                  ),
                  getVerticalSpace(1.6.h)
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

void openCampaignPoster(
  BuildContext context, {
  required String token,
  required String businessId,
  required String posterId,
  required String currentUserId,
  required String currentUserName,
}) {
  final TextEditingController descriptionController = TextEditingController();
  showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.4.h),
          child: Material(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 2.4.h, vertical: 1.h),
              height: 37.h,
              decoration: BoxDecoration(color: const Color(0xffF8F9FA), borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Campaign poster design',
                      style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.blackColor),
                    ),
                  ),
                  getVerticalSpace(4.h),
                  Text(
                    'Edit Descriptions',
                    style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.blackColor),
                  ),
                  getVerticalSpace(.8.h),
                  customTextFormField(controller: descriptionController, bgColor: const Color(0xffFAFAFA), maxLine: 3),
                  getVerticalSpace(2.4.h),
                  Row(
                    children: [
                      Expanded(
                          child: customElevatedButton(
                              onTap: () {
                                Get.back();
                              },
                              title: Text(
                                'Cancel',
                                style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.whiteColor),
                              ),
                              verticalPadding: .8.h,
                              horizentalPadding: 1.6.h,
                              bgColor: const Color(0xffC3C3C2))),
                      getHorizentalSpace(1.4.h),
                      Expanded(
                          child: Obx(
                        () => customElevatedButton(
                            onTap: () {
                              if (descriptionController.text.isEmpty) {
                                customScaffoldMessenger('Please enter the description Text');
                              } else {
                                addCampaignController
                                    .requestForMoreDesign(
                                  context: context,
                                  token: token,
                                  description: descriptionController.text.toString(),
                                  businessId: businessId,
                                )
                                    .then(
                                  (value) {
                                    GetFcmTokenApi(context: context).sendNotificationToAllMidAdmins(
                                        token: token,
                                        title: "Request",
                                        message: "$currentUserName requested for more design",
                                        info1: currentUserId,
                                        info2: "");

                                  },
                                );
                              }
                            },
                            title: addCampaignController.requestLoading.value
                                ? spinkit
                                : Text(
                                    'Send',
                                    style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.whiteColor),
                                  ),
                            bgColor: AppColors.mainColor,
                            verticalPadding: .8.h,
                            horizentalPadding: 1.6.h),
                      )),
                    ],
                  ),
                  getVerticalSpace(2.4.h)
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

void openCampaignPosterEdit(
  BuildContext context, {
  required String token,
  required String businessId,
  required String posterId,
  required String ownerId,
  required String currentUserId,
  required String currentUserName,
}) {
  final TextEditingController descriptionController = TextEditingController();
  final GetFcmTokenSendNotificationController getFcmTokenSendNotificationController =
      Get.put(GetFcmTokenSendNotificationController(context: context));
  final PosterController posterController = Get.put(PosterController(context: context));

  showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.4.h),
          child: Material(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 2.4.h, vertical: 1.h),
              height: 37.h,
              decoration: BoxDecoration(color: const Color(0xffF8F9FA), borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Campaign poster design',
                      style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.blackColor),
                    ),
                  ),
                  getVerticalSpace(4.h),
                  Text(
                    'Edit Descriptions',
                    style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.blackColor),
                  ),
                  getVerticalSpace(.8.h),
                  customTextFormField(controller: descriptionController, bgColor: const Color(0xffFAFAFA), maxLine: 3),
                  getVerticalSpace(2.4.h),
                  Row(
                    children: [
                      Expanded(
                          child: customElevatedButton(
                              onTap: () {
                                Get.back();
                              },
                              title: Text(
                                'Deny',
                                style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.whiteColor),
                              ),
                              verticalPadding: .8.h,
                              horizentalPadding: 1.6.h,
                              bgColor: const Color(0xffC3C3C2))),
                      getHorizentalSpace(1.4.h),
                      Expanded(
                          child: Obx(
                        () => customElevatedButton(
                            onTap: () {
                              if (descriptionController.text.isEmpty) {
                                customScaffoldMessenger('Please enter the description Text');
                              } else {
                                posterController
                                    .editDesign(
                                  businessId: businessId,
                                  designId: posterId,
                                  comment: descriptionController.text,
                                )
                                    .then(
                                  (value) {
                                    getFcmTokenSendNotificationController.fetchFcmToken(
                                        loading: getFcmTokenSendNotificationController.fcmToken.value == null,
                                        userId: ownerId,
                                        token: token,
                                        title: "Request",
                                        message: "$currentUserName for more design",
                                        info1: currentUserId,
                                        info2: "");
                                  },
                                );
                              }
                            },
                            title: posterController.editLoading.value
                                ? spinkit
                                : Text(
                                    'Send',
                                    style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.whiteColor),
                                  ),
                            bgColor: AppColors.mainColor,
                            verticalPadding: .8.h,
                            horizentalPadding: 1.6.h),
                      )),
                    ],
                  ),
                  getVerticalSpace(2.4.h)
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

void openCampaignFeeAdd(BuildContext context, double totalFee, Callback onTap) {
  showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 2.h,
          ),
          child: Material(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.h),
              height: 29.h,
              decoration: BoxDecoration(color: const Color(0xffF8F9FA), borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(child: SizedBox()),
                      Text(
                        'Campaign Fee Payment',
                        style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.blackColor),
                      ),
                      const Expanded(child: SizedBox()),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const SizedBox(height: 30, child: Image(image: AssetImage('assets/pngs/crossicon.png'))),
                      )
                    ],
                  ),
                  getVerticalSpace(2.4.h),
                  Row(
                    children: [
                      Text(
                        'Your Campaign Fee',
                        style: TextStyle(fontSize: 14.px, fontFamily: 'bold', fontWeight: FontWeight.w500, color: const Color(0xff191918)),
                      ),
                      const Expanded(child: SizedBox()),
                      Text(
                        "\$$totalFee",
                        style: TextStyle(fontSize: 14.px, fontFamily: 'bold', fontWeight: FontWeight.w500, color: const Color(0xff191918)),
                      ),
                    ],
                  ),
                  getVerticalSpace(2.4.h),
                  customElevatedButton(
                      onTap: onTap,
                      title: Text(
                        'Recharge ',
                        style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.whiteColor),
                      ),
                      bgColor: AppColors.mainColor,
                      verticalPadding: .6.h,
                      horizentalPadding: 1.6.h),
                  getVerticalSpace(1.6.h)
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

void openCampaignSubmit(
  BuildContext context,
  double totalFee, {
  required String businessId,
  required String businessName,
  required String campaignName,
  required String campaignDescription,
  required File selectedPoster,
  required String campaignPlatForms,
  required String startDate,
  required String endDate,
  required String startTime,
  required String endTime,
  required String token,
  required String clientSecretKey,
}) {
  RxInt isPressedCount = 0.obs;
  showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 2.h,
          ),
          child: Material(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.h),
              height: 24.h,
              decoration: BoxDecoration(color: const Color(0xffF8F9FA), borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(child: SizedBox()),
                      Text(
                        'Campaign Fee Payment',
                        style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.blackColor),
                      ),
                      const Expanded(child: SizedBox()),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const SizedBox(height: 33, child: Image(image: AssetImage('assets/pngs/crossicon.png'))),
                      )
                    ],
                  ),
                  getVerticalSpace(2.4.h),
                  Row(
                    children: [
                      Text(
                        'Your Campaign Fee',
                        style: TextStyle(fontSize: 14.px, fontFamily: 'bold', fontWeight: FontWeight.w500, color: const Color(0xff191918)),
                      ),
                      const Expanded(child: SizedBox()),
                      Text(
                        "\$$totalFee",
                        style: TextStyle(fontSize: 14.px, fontFamily: 'bold', fontWeight: FontWeight.w500, color: const Color(0xff191918)),
                      ),
                    ],
                  ),
                  getVerticalSpace(2.4.h),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        customElevatedButton(
                          title: isPressedCount.value == 1
                              ? spinkit
                              : Text(
                                  'Pay Now',
                                  style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.whiteColor),
                                ),
                          onTap: () async {
                            isPressedCount.value = isPressedCount.value + 1;
                            if (isPressedCount.value == 1) {
                              await StripePayments.name(totalFee,
                                      context: context,
                                      clientSecretKey: clientSecretKey,
                                      token: token,
                                      businessId: businessId,
                                      businessName: businessName,
                                      campaignDescription: campaignDescription,
                                      campaignName: campaignName,
                                      campaignPlatForms: campaignPlatForms,
                                      endDate: endDate,
                                      endTime: endTime,
                                      plan: "no plan",
                                      selectedPoster: selectedPoster,
                                      startDate: startDate,
                                      startTime: startTime,
                                      cost: totalFee.toString())
                                  .startPayment()
                                  .then(
                                (value) {
                                  isPressedCount.value = 2;
                                },
                              );
                            }
                          },
                          bgColor: const Color(0xff34C759),
                          verticalPadding: 1.h,
                          horizentalPadding: 4.8.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

void openCampaignCancel(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 2.h,
          ),
          child: Material(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 2.h),
              height: 34.h,
              decoration: BoxDecoration(color: const Color(0xffF8F9FA), borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(child: SizedBox()),
                      Text(
                        'Campaign Cancel',
                        style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.blackColor),
                      ),
                      const Expanded(child: SizedBox()),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const SizedBox(height: 30, child: Image(image: AssetImage('assets/pngs/crossicon.png'))),
                      )
                    ],
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  getVerticalSpace(2.h),
                  Text(
                    'Do you really want to cancel the campaign',
                    style: TextStyle(fontSize: 16.px, fontFamily: 'bold', fontWeight: FontWeight.w600, color: AppColors.mainColor),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'If you cancel the campaign admin fee will be apply on it.',
                    style: TextStyle(fontSize: 14.px, fontFamily: 'regular', fontWeight: FontWeight.w400, color: const Color(0xff535352)),
                    textAlign: TextAlign.center,
                  ),
                  getVerticalSpace(2.4.h),
                  Row(
                    children: [
                      Expanded(
                        child: customElevatedButton(
                            onTap: () {
                              Get.to(() => const CustomBottomNavigationBar());
                            },
                            title: Text(
                              'Yes ',
                              style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.whiteColor),
                            ),
                            bgColor: const Color(0xff7C7C7C),
                            verticalPadding: .6.h,
                            horizentalPadding: 1.6.h),
                      ),
                      getHorizentalSpace(1.2.h),
                      Expanded(
                        child: customElevatedButton(
                            onTap: () {},
                            title: Text(
                              'Continue',
                              style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.whiteColor),
                            ),
                            bgColor: AppColors.mainColor,
                            verticalPadding: .6.h,
                            horizentalPadding: 1.6.h),
                      ),
                    ],
                  ),
                  getVerticalSpace(1.6.h)
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

void openChooseSubscription(
{
 required String token,
  required BuildContext context,
 required String clientSecretKey,
 required int plan,
 required String planName,
  required DateTime expiry,
}
) {
  RxInt isPressedCount = 0.obs;

  RxBool isPressed = false.obs;
  final SubscriptionController subscriptionController = Get.put(SubscriptionController());
  RxInt isSelected = (planName.isNotEmpty) ? plan.obs : (-1).obs; // Default to -1 if no plan is selected
  int currentPlan = isSelected.value;

  subscriptionController.fetchAllPlans(loading: subscriptionController.getAllPlans.isEmpty, context: context);
  showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 2.h,
          ),
          child: Material(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 3.h),
              height: 70.h,
              decoration: BoxDecoration(color: const Color(0xffF8F9FA), borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 3.h,
                    alignment: Alignment.center,
                    child: Text(
                      'Choose a Subscription plan',
                      style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.blackColor),
                    ),
                  ),
                  getVerticalSpace(1.h),
                  SizedBox(
                    child: Obx(() => subscriptionController.planLoading.value
                        ? ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return Shimmer.fromColors(
                                baseColor: AppColors.baseColor,
                                highlightColor: AppColors.highlightColor,
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 1.6.h, horizontal: 1.9.h),
                                  padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 1.h),
                                  decoration: BoxDecoration(
                                      color: AppColors.whiteColor,
                                      borderRadius: BorderRadius.circular(1.h),
                                      border: Border.all(color: isSelected.value == index ? AppColors.mainColor : Colors.transparent)),
                                  child: Column(
                                    children: [
                                      Text(
                                        "",
                                        style: TextStyle(
                                          color: AppColors.mainColor,
                                          fontSize: 14.px,
                                          fontFamily: 'bold',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      getVerticalSpace(.9.h),
                                      Text(
                                        "",
                                        style: TextStyle(
                                          color: const Color(0xff444545),
                                          fontSize: 16.px,
                                          fontFamily: 'bold',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      getVerticalSpace(.4.h),
                                      Text(
                                        "",
                                        style: TextStyle(
                                          color: const Color(0xff444545),
                                          fontSize: 10.px,
                                          fontFamily: 'regular',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        : subscriptionController.getAllPlans.isEmpty
                            ? Text(
                                'No Subscription Available',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'bold',
                                  fontSize: 14.px,
                                  color: AppColors.mainColor,
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemCount: subscriptionController.getAllPlans.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      if(index < currentPlan && expiry.isAfter(DateTime.now()))
                                        {
                                          customScaffoldMessenger("You cannot downgrade until the current plant expires");
                                        }
                                      else
                                        {
                                          subscriptionController.getAllPlans.refresh();
                                          isSelected.value = index;
                                        }
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 3.h, left: 1.9.h, right: 1.9.h),
                                      padding: EdgeInsets.symmetric(vertical: 2.h),
                                      decoration: BoxDecoration(
                                          color: AppColors.whiteColor,
                                          borderRadius: BorderRadius.circular(1.h),
                                          border: Border.all(color: isSelected.value == index ? AppColors.mainColor : Colors.transparent)),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            subscriptionController.getAllPlans[index]!.name,
                                            style: TextStyle(
                                              color: AppColors.mainColor,
                                              fontSize: 14.px,
                                              fontFamily: 'bold',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          getVerticalSpace(.9.h),
                                          Text(
                                            "${subscriptionController.getAllPlans[index]!.price.toString()} USD / 3 Months",
                                            style: TextStyle(
                                              color: const Color(0xff444545),
                                              fontSize: 16.px,
                                              fontFamily: 'bold',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          getVerticalSpace(.4.h),
                                          Text(
                                            "Add up to ${subscriptionController.getAllPlans[index]!.businessLimit} businesses.",
                                            style: TextStyle(
                                              color: const Color(0xff444545),
                                              fontSize: 10.px,
                                              fontFamily: 'regular',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )),
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: customElevatedButton(
                              onTap: () {
                                Get.back();
                              },
                              title: Text(
                                'Cancel',
                                style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.whiteColor,
                                fontSize: 12.px),
                              ),
                              bgColor: const Color(0xff7C7C7C),
                              verticalPadding: .6.h,
                              horizentalPadding: 1.6.h),
                        ),
                        getHorizentalSpace(1.2.h),
                        Expanded(
                          child: Obx(
                            () => customElevatedButton(
                                loading: subscriptionController.paymentLoading.value,
                                onTap: () async {
                                  isPressedCount.value = isPressedCount.value + 1;

                                  if (clientSecretKey.isNotEmpty) {
                                    if (isPressedCount.value == 1) {
                                      await StripePayments.name(subscriptionController.getAllPlans[isSelected.value]!.price.toDouble(),
                                          context: context,
                                          clientSecretKey: clientSecretKey,
                                          token: token,
                                          businessId: "",
                                          businessName: "",
                                          campaignDescription: "",
                                          campaignName: "",
                                          campaignPlatForms: "",
                                          endDate: "",
                                          endTime: "",
                                          plan: subscriptionController.getAllPlans.elementAt(isSelected.value)?.name.toLowerCase() ?? "",
                                          selectedPoster: File(""),
                                          startDate: "",
                                          startTime: "",
                                          cost: '')
                                          .startPayment().then((value) {
                                        isPressedCount.value = 2;
                                      },);
                                    }
                                  }
                                },
                                title:isPressedCount.value == 1
                                    ? spinkit: Text(
                                  planName.isNotEmpty?"update plan":
                                  'Pay now',
                                  style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.whiteColor,fontSize: 12.px),
                                ),
                                bgColor: AppColors.mainColor,
                                verticalPadding: .6.h,
                                horizentalPadding: 1.6.h),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

void logoutPopUp(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 2.h,
          ),
          child: Material(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 2.4.h, vertical: 2.h),
              height: 36.h,
              decoration: BoxDecoration(color: const Color(0xffF8F9FA), borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(child: SizedBox()),
                      Text(
                        'Manage Logout',
                        style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.blackColor, fontFamily: 'bold', fontSize: 16.px),
                      ),
                      const Expanded(child: SizedBox()),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: SizedBox(height: 3.h, width: 3.h, child: const Image(image: AssetImage('assets/pngs/crossicon.png'))),
                      ),
                    ],
                  ),
                  getVerticalSpace(1.2.h),
                  const Divider(
                    color: Colors.grey,
                  ),
                  getVerticalSpace(1.h),
                  SvgPicture.asset(
                    "assets/svgs/logout.svg",
                    color: AppColors.mainColor,
                  ),
                  getVerticalSpace(1.h),
                  Text(
                    'Are You Sure ! you want to Logout',
                    style: TextStyle(fontWeight: FontWeight.w500, color: AppColors.mainColor, fontSize: 16.px, fontFamily: 'bold'),
                  ),
                  getVerticalSpace(4.7.h),
                  Row(
                    children: [
                      Expanded(
                        child: customElevatedButton(
                            onTap: () {
                              Get.back();
                            },
                            title: Text(
                              'No',
                              style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.whiteColor, fontFamily: 'bold'),
                            ),
                            bgColor: const Color(0xffC3C3C2),
                            verticalPadding: .6.h,
                            horizentalPadding: 1.6.h),
                      ),
                      getHorizentalSpace(1.6.h),
                      Expanded(
                        child: customElevatedButton(
                            onTap: () {
                              MySharedPreferences.setBool(isLoggedInKey, false);
                              Get.offAll(() => const LoginScreen());
                            },
                            title: Text(
                              'Yes',
                              style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.whiteColor, fontFamily: 'bold'),
                            ),
                            bgColor: AppColors.mainColor,
                            verticalPadding: .6.h,
                            horizentalPadding: 1.6.h),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

void deleteAccountPopUp(BuildContext context, String token) {
  UserProfileController userProfileController = Get.put(UserProfileController(context: context));
  showDialog(
    context: context,
    builder: (context) {
      return Obx(() {
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 2.h,
              ),
              child: Material(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 2.4.h, vertical: 2.h),
                  height: 30.h,
                  decoration: BoxDecoration(color: const Color(0xffF8F9FA), borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(child: SizedBox()),
                          Text(
                            'Are you sure to delete ?',
                            style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.blackColor, fontFamily: 'bold', fontSize: 16.px),
                          ),
                          const Expanded(child: SizedBox()),
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: SizedBox(height: 3.h, width: 3.h, child: const Image(image: AssetImage('assets/pngs/crossicon.png'))),
                          ),
                        ],
                      ),
                      getVerticalSpace(1.2.h),
                      const Divider(
                        color: Colors.grey,
                      ),
                      const Spacer(),
                      Text(
                        "This action will permanently delete your account and cannot be undone.",
                        style: TextStyle(fontWeight: FontWeight.w500, color: AppColors.mainColor, fontSize: 14.px, fontFamily: 'bold'),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Expanded(
                            child: customElevatedButton(
                                onTap: () {
                                  Get.back();
                                },
                                title: Text(
                                  'Cancel',
                                  style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.whiteColor, fontFamily: 'bold'),
                                ),
                                bgColor: const Color(0xffC3C3C2),
                                verticalPadding: .6.h,
                                horizentalPadding: 1.6.h),
                          ),
                          getHorizentalSpace(1.6.h),
                          Expanded(
                            child: customElevatedButton(
                              loading: userProfileController.deleteLoading.value,
                                onTap: () {
                                  if (!userProfileController.deleteLoading.value) {
                                    userProfileController.deleteUserAccount(token: token).then((value) {
                                      MySharedPreferences.setBool(isLoggedInKey, false);
                                    });
                                  }
                                },
                                title: Text(
                                  'Confirm',
                                  style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.whiteColor, fontFamily: 'bold'),
                                ),
                                bgColor: AppColors.mainColor,
                                verticalPadding: .6.h,
                                horizentalPadding: 1.6.h),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      );
    },
  );
}
void openBottomSheet(
  BuildContext context,
) {
  final AddCardController addCardController = Get.put(AddCardController());

  Get.bottomSheet(
    SizedBox(
      height: 60.h,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.all(20.px),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                leading: const Image(image: AssetImage('assets/pngs/addpayment.png')),
                title: Text(
                  'Add card',
                  style: TextStyle(fontSize: 16.px, fontFamily: 'bold', color: const Color(0xff292D32), fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  'Streamline your checkout process by adding a new card for future transactions. Your card information is secured with advanced encryption technology.',
                  style: TextStyle(fontSize: 12.px, fontFamily: 'bold', color: const Color(0xffA9ACB4), fontWeight: FontWeight.w500),
                ),
              ),
              getVerticalSpace(1.h),
              const Divider(
                color: Color(0xffCBD0DC),
              ),
              getVerticalSpace(3.4.h),
              customTextFormField(
                  keyboardType: TextInputType.number,
                  title: '0000 0000 0000',
                  errorText: 'Card Number',
                  bgColor: Colors.transparent,
                  borderColor: const Color(0xffCBD0DC),
                  focusBorderColor: AppColors.mainColor,
                  prefix: '4966 |'),
              getVerticalSpace(3.2.h),
              Row(
                children: [
                  Obx(
                    () => Expanded(
                      child: customTextFormField(
                        onTap: () {
                          addCardController.datePicker(context);
                        },
                        readOnly: true,
                        keyboardType: TextInputType.number,
                        title: addCardController.selectedDate.value.format(pattern: 'yyyy-MM-dd'),
                        errorText: 'Expiry Date',
                        bgColor: Colors.transparent,
                        borderColor: const Color(0xffCBD0DC),
                        focusBorderColor: AppColors.mainColor,
                      ),
                    ),
                  ),
                  getHorizentalSpace(2.h),
                  Expanded(
                    child: customTextFormField(
                      keyboardType: TextInputType.number,
                      title: '•••',
                      errorText: 'CVV',
                      bgColor: Colors.transparent,
                      borderColor: const Color(0xffCBD0DC),
                      focusBorderColor: AppColors.mainColor,
                    ),
                  )
                ],
              ),
              getVerticalSpace(3.2.h),
              customTextFormField(
                keyboardType: TextInputType.number,
                title: 'Enter cardholder’s full name',
                errorText: 'Cardholder’s Name',
                bgColor: Colors.transparent,
                borderColor: const Color(0xffCBD0DC),
                focusBorderColor: AppColors.mainColor,
              ),
              getVerticalSpace(3.6.h),
              customElevatedButton(
                  title: Text(
                    'Buy',
                    style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.whiteColor),
                  ),
                  onTap: () {
                    // Get.to(() => CampaignName());
                  },
                  bgColor: AppColors.mainColor,
                  titleColor: AppColors.whiteColor,
                  verticalPadding: .9.h,
                  horizentalPadding: 5.h),
            ],
          ),
        ),
      ),
    ),
    backgroundColor: Colors.white,
    isScrollControlled: true,
  );
}

Future<bool> withdrawRequest(BuildContext context, double amount) async {
  // Flag to store API call success
  bool isRequestSuccessful = false;

  // Controllers for text fields
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController accountTitleController = TextEditingController();
  final TextEditingController ibanController = TextEditingController();

  // Get the WalletController instance
  final WalletController walletController = Get.put(WalletController(context: context));

  // Show the dialog
  await showDialog(
    context: context,
    builder: (context) {
      final screenHeight = MediaQuery.of(context).size.height;
      final screenWidth = MediaQuery.of(context).size.width;

      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Material(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.06,
                vertical: screenHeight * 0.05,
              ),
              height: screenHeight * 0.6,
              decoration: BoxDecoration(
                color: const Color(0xffF8F9FA),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(child: SizedBox()),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Withdraw Request',
                              style: CustomTextStyles.buttonTextStyle.copyWith(
                                color: AppColors.blackColor,
                                fontFamily: 'bold',
                                fontSize: screenHeight * 0.025,
                              ),
                            ),
                            getVerticalSpace(1.2.h),
                            Text(
                              '\$$amount',
                              style: CustomTextStyles.buttonTextStyle.copyWith(
                                color: AppColors.mainColor,
                                fontFamily: 'bold',
                                fontSize: screenHeight * 0.025,
                              ),
                            ),
                          ],
                        ),
                      ),
                      getVerticalSpace(1.2.h),
                      buildInputLabel("Bank Name", screenHeight),
                      buildInputField(bankNameController),
                      getVerticalSpace(1.6.h),
                      buildInputLabel("Account Title", screenHeight),
                      buildInputField(accountTitleController),
                      getVerticalSpace(1.6.h),
                      buildInputLabel("IBAN", screenHeight),
                      buildInputField(ibanController),
                      getVerticalSpace(4.h),
                      Row(
                        children: [
                          Expanded(
                            child: customElevatedButton(
                              onTap: () {
                                walletController.requestLoading.value = false;
                                Get.back();
                              },
                              title: buildButtonText('Cancel', AppColors.whiteColor),
                              bgColor: const Color(0xffC3C3C2),
                              verticalPadding: screenHeight * 0.01,
                              horizentalPadding: screenWidth * 0.04,
                            ),
                          ),
                          getHorizentalSpace(1.6.h),
                          Expanded(
                            child: customElevatedButton(
                              onTap: () async {
                                if (!walletController.requestLoading.value)
                                // Validate fields before proceeding
                                {
                                  if (bankNameController.text.isEmpty || accountTitleController.text.isEmpty || ibanController.text.isEmpty) {
                                    // Show validation error message (Snackbar or Alert)
                                    Get.snackbar(
                                      'Error',
                                      'Please fill in all fields.',
                                      backgroundColor: Colors.red,
                                      colorText: Colors.white,
                                    );
                                    return;
                                  }

                                  // Call the API after validation
                                  bool result = await walletController.addWalletRequest(
                                    context: context,
                                    loading: true,
                                    bankName: bankNameController.text,
                                    accountTitle: accountTitleController.text,
                                    iban: ibanController.text,
                                    amount: amount,
                                  );

                                  // Set the success status
                                  isRequestSuccessful = result;

                                  // Close the dialog
                                  Get.back();
                                  walletController.getWalletDetails(context: context, loading: true);
                                }
                              },
                              title: walletController.requestLoading.value ? spinkit : buildButtonText('Send', AppColors.whiteColor),
                              bgColor: AppColors.mainColor,
                              verticalPadding: screenHeight * 0.01,
                              horizentalPadding: screenWidth * 0.04,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
          ),
        ),
      );
    },
  );

  // Return the success status of the request
  return isRequestSuccessful;
}

// Helper methods to simplify UI creation

Widget buildInputLabel(String label, double screenHeight) {
  return Text(
    label,
    style: CustomTextStyles.buttonTextStyle.copyWith(
      color: const Color(0xff454544),
      fontFamily: 'bold',
      fontSize: screenHeight * 0.018,
    ),
  );
}

Widget buildInputField(TextEditingController controller) {
  return Container(
    decoration: BoxDecoration(
      color: AppColors.whiteColor,
      borderRadius: BorderRadius.circular(1.h),
      boxShadow: [
        BoxShadow(
          color: AppColors.blackColor.withOpacity(0.1),
          offset: const Offset(0, 2),
          blurRadius: 8,
          spreadRadius: 0,
        ),
      ],
    ),
    child: customTextFormField(
      bgColor: AppColors.whiteColor,
      controller: controller,
    ),
  );
}

Widget buildButtonText(String text, Color color) {
  return Text(
    text,
    style: CustomTextStyles.buttonTextStyle.copyWith(
      color: color,
      fontFamily: 'bold',
    ),
  );
}
