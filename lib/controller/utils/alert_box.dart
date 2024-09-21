
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm/controller/custom_widgets/widgets.dart';
import 'package:ttpdm/controller/getx_controllers/add_campaign_controller.dart';
import 'package:ttpdm/controller/getx_controllers/get_fcm_token_send_notification_controller.dart';
import 'package:ttpdm/controller/getx_controllers/image_picker_controller.dart';
import 'package:ttpdm/controller/getx_controllers/subcription_controller.dart';
import 'package:ttpdm/controller/utils/apis_constant.dart';
import 'package:ttpdm/controller/utils/preference_key.dart';
import 'package:ttpdm/view/screens/auth_section/login_screen.dart';
import 'package:ttpdm/view/screens/bottom_navigationbar.dart';

import '../getx_controllers/user_profile_controller.dart';
import 'my_shared_prefrence.dart';

RxList<String> selectionLst = <String>[].obs;
final AddCampaignController addCampaignController =
    Get.put(AddCampaignController());
void openChooseEditProfile(
    BuildContext context, {
      required String name,
      required String token,
      required String profileImage,
    }) {
  final TextEditingController nameController = TextEditingController();
  final ImagePickerController imagePickerController =
  Get.put(ImagePickerController());
  final UserProfileController userProfileController =
  Get.put(UserProfileController(context: context));

  log(profileImage);

  // Define a function to reset the image picker when the dialog is closed
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
              decoration: BoxDecoration(
                  color: const Color(0xffF8F9FA),
                  borderRadius: BorderRadius.circular(10)),
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
                        style: CustomTextStyles.buttonTextStyle.copyWith(
                            color: AppColors.blackColor,
                            fontFamily: 'regular',
                            fontSize: 20.px),
                      ),
                      const Expanded(child: SizedBox()),
                      getHorizentalSpace(5.h),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop(); // Close dialog
                          resetImagePicker(); // Reset image picker
                        },
                        child: SizedBox(
                            height: 3.h,
                            width: 3.h,
                            child: const Image(
                                image: AssetImage('assets/pngs/crossicon.png'))),
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
                        backgroundImage: FileImage(File(
                            imagePickerController.image.value!.path)),
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
                        style: TextStyle(
                            fontSize: 14.px,
                            fontFamily: 'regular',
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff454544)),
                      ),
                    ),
                  ),
                  getVerticalSpace(.8.h),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.h),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0xff000000).withOpacity(0.25),
                              blurRadius: 8,
                              spreadRadius: 0,
                              offset: const Offset(0, 1))
                        ],
                        color: AppColors.whiteColor),
                    child: customTextFormField1(
                      controller: nameController, // Set the controller
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
                                  profileImage: imagePickerController
                                      .image.value?.path.isEmpty ?? true
                                      ? File("")
                                      : File(imagePickerController
                                      .image.value!.path),
                                  fullname: nameController.text.isEmpty?name:nameController.text)
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
                              style: CustomTextStyles.buttonTextStyle
                                  .copyWith(
                                  color: AppColors.whiteColor,
                                  fontFamily: 'bold'),
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
              decoration: BoxDecoration(
                  color: const Color(0xffF8F9FA),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(child: SizedBox()),
                      Text(
                        'Campaign poster design',
                        style: CustomTextStyles.buttonTextStyle
                            .copyWith(color: AppColors.blackColor),
                      ),
                      const Expanded(child: SizedBox()),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const SizedBox(
                            height: 30,
                            child: Image(
                                image:
                                    AssetImage('assets/pngs/crossicon.png'))),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1.h),
                    child: Container(
                      height: 28.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1.h),
                          image: const DecorationImage(
                              image: AssetImage('assets/pngs/poster.png'),
                              fit: BoxFit.contain)),
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
                                fontFamily: 'bold',
                                color: const Color(0xff454544).withOpacity(0.6),
                                fontSize: 14.px,
                                fontWeight: FontWeight.w400))
                      ])),
                    ),
                  ),
                  getVerticalSpace(.6.h),
                  Padding(
                    padding: EdgeInsets.only(left: 1.6.h),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: customTextFormField(
                          maxLine: 4, bgColor: AppColors.whiteColor),
                    ),
                  ),
                  getVerticalSpace(.6.h),
                  Row(
                    children: [
                      Expanded(
                          child: customElevatedButton(
                              title: Text(
                                'Edit',
                                style: CustomTextStyles.buttonTextStyle
                                    .copyWith(color: AppColors.whiteColor),
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
                                style: CustomTextStyles.buttonTextStyle
                                    .copyWith(color: AppColors.whiteColor),
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
              decoration: BoxDecoration(
                  color: const Color(0xffF8F9FA),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(child: SizedBox()),
                      Text(
                        'Campaign Cancel',
                        style: CustomTextStyles.buttonTextStyle
                            .copyWith(color: AppColors.blackColor),
                      ),
                      const Expanded(child: SizedBox()),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const SizedBox(
                            height: 30,
                            child: Image(
                                image:
                                    AssetImage('assets/pngs/crossicon.png'))),
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
                    style: CustomTextStyles.buttonTextStyle
                        .copyWith(color: AppColors.mainColor),
                  ),
                  getVerticalSpace(.9.h),
                  Text(
                    'Admin fee will be apply on cancellation ',
                    style: CustomTextStyles.buttonTextStyle
                        .copyWith(color: const Color(0xff7C7C7C)),
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
                                style: CustomTextStyles.buttonTextStyle
                                    .copyWith(color: AppColors.whiteColor),
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
                                style: CustomTextStyles.buttonTextStyle
                                    .copyWith(color: AppColors.whiteColor),
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

void openCampaignPoster(BuildContext context,
{
 required String token,
  required String businessId ,
  required String posterId ,
  required String currentUserId ,
  required String currentUserName ,
}
    ) {
  final TextEditingController descriptionController = TextEditingController();
 final GetFcmTokenSendNotificationController getFcmTokenSendNotificationController = Get.put(GetFcmTokenSendNotificationController(context: context));


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
              decoration: BoxDecoration(
                  color: const Color(0xffF8F9FA),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Campaign poster design',
                      style: CustomTextStyles.buttonTextStyle
                          .copyWith(color: AppColors.blackColor),
                    ),
                  ),
                  getVerticalSpace(4.h),
                  Text(
                    'Edit Descriptions',
                    style: CustomTextStyles.buttonTextStyle
                        .copyWith(color: AppColors.blackColor),
                  ),
                  getVerticalSpace(.8.h),
                  customTextFormField(
                      controller: descriptionController,
                      bgColor: const Color(0xffFAFAFA),
                      maxLine: 3),
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
                                style: CustomTextStyles.buttonTextStyle
                                    .copyWith(color: AppColors.whiteColor),
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
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Please enter the description Text')));
                              } else {
                                addCampaignController.requestForMoreDesign(
                                  context: context,
                                  token: token,
                                  description:
                                      descriptionController.text.toString(), businessId:businessId,
                                ).then((value) {
                                  getFcmTokenSendNotificationController.fetchFcmToken(
                                      loading: getFcmTokenSendNotificationController.fcmToken.value==null,
                                      userId: posterId,
                                      token: token,
                                      title: "Request",
                                      message: "$currentUserName for more design",
                                      info1: currentUserId,
                                      info2: "");
                                },);
                              }
                            },
                            title: addCampaignController.isLoading.value
                                ? spinkit
                                : Text(
                                    'Send',
                                    style: CustomTextStyles.buttonTextStyle
                                        .copyWith(color: AppColors.whiteColor),
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

void openCampaignFeeAdd(BuildContext context, int coins,
    Callback onTap) {
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
              decoration: BoxDecoration(
                  color: const Color(0xffF8F9FA),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(child: SizedBox()),
                      Text(
                        'Campaign Fee Payment',
                        style: CustomTextStyles.buttonTextStyle
                            .copyWith(color: AppColors.blackColor),
                      ),
                      const Expanded(child: SizedBox()),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const SizedBox(
                            height: 30,
                            child: Image(
                                image:
                                    AssetImage('assets/pngs/crossicon.png'))),
                      )
                    ],
                  ),
                  getVerticalSpace(2.4.h),
                  Row(
                    children: [
                      Text(
                        'Your balance ',
                        style: TextStyle(
                            fontSize: 14.px,
                            fontFamily: 'regular',
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff191918)),
                      ),
                      const Expanded(child: SizedBox()),
                      SizedBox(
                          height: 2.h,
                          width: 2.h,
                          child: const Image(
                              image: AssetImage('assets/pngs/coins.png'))),
                      Text(
                        ' $coins',
                        style: TextStyle(
                            fontSize: 14.px,
                            fontFamily: 'bold',
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff191918)),
                      ),
                    ],
                  ),
                  getVerticalSpace(.8.h),
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
                      SizedBox(
                          height: 2.h,
                          width: 2.h,
                          child: const Image(
                              image: AssetImage('assets/pngs/coins.png'))),
                      Text(
                        '1200',
                        style: TextStyle(
                            fontSize: 14.px,
                            fontFamily: 'bold',
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff191918)),
                      ),
                    ],
                  ),
                  getVerticalSpace(2.4.h),
                  customElevatedButton(
                      onTap: onTap,
                      title: Text(
                        'Recharge ',
                        style: CustomTextStyles.buttonTextStyle
                            .copyWith(color: AppColors.whiteColor),
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

void openCampaignSubmit(BuildContext context, Callback onTap,int coins) {
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
              height: 30.h,
              decoration: BoxDecoration(
                  color: const Color(0xffF8F9FA),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(child: SizedBox()),
                      Text(
                        'Campaign Fee Payment',
                        style: CustomTextStyles.buttonTextStyle
                            .copyWith(color: AppColors.blackColor),
                      ),
                      const Expanded(child: SizedBox()),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const SizedBox(
                            height: 33,
                            child: Image(
                                image:
                                    AssetImage('assets/pngs/crossicon.png'))),
                      )
                    ],
                  ),
                  getVerticalSpace(2.4.h),
                  Row(
                    children: [
                      Text(
                        'Your balance ',
                        style: TextStyle(
                            fontSize: 14.px,
                            fontFamily: 'regular',
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff191918)),
                      ),
                      const Expanded(child: SizedBox()),
                      SizedBox(
                          height: 2.h,
                          width: 2.h,
                          child: const Image(
                              image: AssetImage('assets/pngs/coins.png'))),
                      Text(
                        coins.toString(),
                        style: TextStyle(
                            fontSize: 14.px,
                            fontFamily: 'bold',
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff191918)),
                      ),
                    ],
                  ),
                  getVerticalSpace(.5.h),
                  const Divider(
                    color: Colors.grey,
                  ),
                  getVerticalSpace(.8.h),
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
                      SizedBox(
                          height: 2.h,
                          width: 2.h,
                          child: const Image(
                              image: AssetImage('assets/pngs/coins.png'))),
                      Text(
                        '1200',
                        style: TextStyle(
                            fontSize: 14.px,
                            fontFamily: 'bold',
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff191918)),
                      ),
                    ],
                  ),
                  getVerticalSpace(2.4.h),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        customElevatedButton(
                          title: addCampaignController.isLoading.value == true
                              ? spinkit
                              : Text(
                                  'Pay Now',
                                  style: CustomTextStyles.buttonTextStyle
                                      .copyWith(color: AppColors.whiteColor),
                                ),
                          onTap: onTap,
                          bgColor: const Color(0xff34C759),
                          verticalPadding: 1.2.h,
                          horizentalPadding: 4.8.h,
                        ),
                      ],
                    ),
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
              decoration: BoxDecoration(
                  color: const Color(0xffF8F9FA),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(child: SizedBox()),
                      Text(
                        'Campaign Cancel',
                        style: CustomTextStyles.buttonTextStyle
                            .copyWith(color: AppColors.blackColor),
                      ),
                      const Expanded(child: SizedBox()),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const SizedBox(
                            height: 30,
                            child: Image(
                                image:
                                    AssetImage('assets/pngs/crossicon.png'))),
                      )
                    ],
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  getVerticalSpace(2.h),
                  Text(
                    'Do you really want to cancel the campaign',
                    style: TextStyle(
                        fontSize: 16.px,
                        fontFamily: 'bold',
                        fontWeight: FontWeight.w600,
                        color: AppColors.mainColor),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'If you cancel the campaign admin fee will be apply on it.',
                    style: TextStyle(
                        fontSize: 14.px,
                        fontFamily: 'regular',
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff535352)),
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
                              style: CustomTextStyles.buttonTextStyle
                                  .copyWith(color: AppColors.whiteColor),
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
                              style: CustomTextStyles.buttonTextStyle
                                  .copyWith(color: AppColors.whiteColor),
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

void openChooseSubscription(BuildContext context,
     String token) {
  final SubscriptionController subscriptionController=Get.put(SubscriptionController());
  final RxInt isSelected = 0.obs;
  RxList<String> titles = <String>["basic", "standard", "pro"].obs;
  RxList<String> description = <String>[
    'Add Business only',
    'Add up to Business only',
    'Add up to Business only'
  ].obs;
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
              padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 2.h),
              height: 63.h,
              decoration: BoxDecoration(
                  color: const Color(0xffF8F9FA),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Text(
                    'Choose a Subscription plan',
                    style: CustomTextStyles.buttonTextStyle
                        .copyWith(color: AppColors.blackColor),
                  ),
                  getVerticalSpace(1.6.h),
                  Obx(() =>subscriptionController.planLoading.value?
                  ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: titles.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 1.6.h, horizontal: 1.9.h),
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.h, vertical: 1.h),
                            decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(1.h),
                                border: Border.all(
                                    color: isSelected.value == index
                                        ? AppColors.mainColor
                                        : Colors.transparent)),
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
                          );
                        },
                      ):
                  subscriptionController.getAllPlans.isEmpty?
                  Text(
                    'No Subscription Available',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: 'bold',
                      fontSize: 14.px,
                      color: AppColors.mainColor,
                    ),
                  ):
                  ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: subscriptionController.getAllPlans.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          subscriptionController.getAllPlans.refresh();
                          titles.refresh();
                          isSelected.value = index;

                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 1.6.h, horizontal: 1.9.h),
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.h, vertical: 1.h),
                          decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(1.h),
                              border: Border.all(
                                  color: isSelected.value == index
                                      ? AppColors.mainColor
                                      : Colors.transparent)),
                          child: Column(
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
                                subscriptionController.getAllPlans[index]!.price.toString(),
                                style: TextStyle(
                                  color: const Color(0xff444545),
                                  fontSize: 16.px,
                                  fontFamily: 'bold',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              getVerticalSpace(.4.h),
                              Text(
                                "${description[index]}${subscriptionController.getAllPlans[index]!.businessLimit}",
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
                  ),
                  getVerticalSpace(2.4.h),
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
                                'Deny',
                                style: CustomTextStyles.buttonTextStyle
                                    .copyWith(color: AppColors.whiteColor),
                              ),
                              bgColor: const Color(0xff7C7C7C),
                              verticalPadding: .6.h,
                              horizentalPadding: 1.6.h),
                        ),
                        getHorizentalSpace(1.2.h),
                        Expanded(
                          child: Obx(() =>
                        customElevatedButton(
                                onTap: () {
                                  subscriptionController.chooseSubscriptionPlan(
                                      token: token,
                                      planType:subscriptionController.getAllPlans[isSelected.value]!.name
                                      , context: context);

                                },
                                title:subscriptionController.isLoading.value?spinkit: Text(
                                  'Pay now',
                                  style: CustomTextStyles.buttonTextStyle
                                      .copyWith(color: AppColors.whiteColor),
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
              decoration: BoxDecoration(
                  color: const Color(0xffF8F9FA),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(child: SizedBox()),
                      Text(
                        'Manage Logout',
                        style: CustomTextStyles.buttonTextStyle.copyWith(
                            color: AppColors.blackColor,
                            fontFamily: 'bold',
                            fontSize: 16.px),
                      ),
                      const Expanded(child: SizedBox()),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: SizedBox(
                            height: 3.h,
                            width: 3.h,
                            child: const Image(
                                image:
                                AssetImage('assets/pngs/crossicon.png'))),
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
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.mainColor,
                        fontSize: 16.px,
                        fontFamily: 'bold'),
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
                              style: CustomTextStyles.buttonTextStyle.copyWith(
                                  color: AppColors.whiteColor,
                                  fontFamily: 'bold'),
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

                              Get.off(() => const LoginScreen());
                            },
                            title: Text(
                              'Yes',
                              style: CustomTextStyles.buttonTextStyle.copyWith(
                                  color: AppColors.whiteColor,
                                  fontFamily: 'bold'),
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