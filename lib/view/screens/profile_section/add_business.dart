import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm/controller/custom_widgets/widgets.dart';
import 'package:ttpdm/controller/getx_controllers/business_profile_controller.dart';
import 'package:ttpdm/controller/utils/apis_constant.dart';
import 'package:ttpdm/controller/utils/my_shared_prefrence.dart';
import 'package:ttpdm/view/screens/bottom_navigationbar.dart';

import '../../../controller/custom_widgets/app_colors.dart';
import '../../../controller/custom_widgets/custom_text_styles.dart';
import '../../../controller/getx_controllers/add_campaign_controller.dart';

class AddNewBusiness extends StatefulWidget {
  const AddNewBusiness({
    super.key,
  });

  @override
  State<AddNewBusiness> createState() => _AddNewBusinessState();
}

class _AddNewBusinessState extends State<AddNewBusiness> {
  final AddCampaignController addCampaignController =
      Get.put(AddCampaignController());

  final TextEditingController bsNameController = TextEditingController();

  final TextEditingController phoneNumberController = TextEditingController();

  final TextEditingController locationController = TextEditingController();

  final TextEditingController targetController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController webUrlController = TextEditingController();

  final TextEditingController facebookUrlController = TextEditingController();

  final TextEditingController instagramUrlController = TextEditingController();

  final TextEditingController linkdinUrlController = TextEditingController();

  final TextEditingController tikTokUrlController = TextEditingController();

  // final RxList<String> profilesList = <String>[
  //   'Business Profile One',
  //   'Business Profile Two',
  //   'Business Profile Three'
  // ].obs;
  void validateFields() {
    final List<String> errorMessages = [];

    if (phoneNumberController.text.isEmpty) {
      errorMessages.add('Phone number is required.');
    }
    if (bsNameController.text.isEmpty) {
      errorMessages.add('Business name is required.');
    }
    if (descriptionController.text.isEmpty) {
      errorMessages.add('Description is required.');
    }
    if (locationController.text.isEmpty) {
      errorMessages.add('Location is required.');
    }
    if (targetController.text.isEmpty) {
      errorMessages.add('Target is required.');
    }
    if (addCampaignController.pickedFilesList.isEmpty) {
      errorMessages.add('At least one file must be picked.');
    }
    if (webUrlController.text.isEmpty) {
      errorMessages.add('Web URL is required.');
    }
    if (facebookUrlController.text.isEmpty) {
      errorMessages.add('Facebook URL is required.');
    }
    if (linkdinUrlController.text.isEmpty) {
      errorMessages.add('LinkedIn URL is required.');
    }
    if (tikTokUrlController.text.isEmpty) {
      errorMessages.add('TikTok URL is required.');
    }
    if (instagramUrlController.text.isEmpty) {
      errorMessages.add('Instagram URL is required.');
    }

    if (errorMessages.isNotEmpty) {
      // Show all error messages as a single SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessages.join('\n')),
          duration: const Duration(seconds: 5),
        ),
      );
    } else {
      // All fields are valid, proceed with form submission
      submitForm().then((value) {
        Get.to(()=>const CustomBottomNavigationBar());
      },);
    }
  }

 Future<void>submitForm() async{
    businessProfileController.submitBusinessProfile(
        name: bsNameController.text,
        phone: phoneNumberController.text,
        location: locationController.text,
        targetMapArea: targetController.text,
        description: descriptionController.text,
        gallery: addCampaignController.pickedFilesList,
        token: token!,
        websiteUrl: webUrlController.text,
        tiktokUrl: tikTokUrlController.text,
        linkedinUrl: linkdinUrlController.text,
        instagramUrl: instagramUrlController.text,
        facebookUrl: facebookUrlController.text,
        logo: addCampaignController.image.value!, context: context);
  }

  final BusinessProfileController businessProfileController =
      Get.find(tag: 'business');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkToken();
  }

  String? token;

  Future<void> _checkToken() async {
    token = await PreferencesService().getAuthToken();
    if (token != null) {
      // Use the token as needed
      log("Token: $token");
    } else {
      // Handle the case where the token is not available
      log("No token available");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              addCampaignController.image.value = null;
              addCampaignController.pickedMediaList.length = 0;
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
              validateFields();
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
        body:Obx(() =>
       businessProfileController.isLoading1.value?spinkit1:
          SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.4.h),
                      child: SingleChildScrollView(
                        child:
                        Column(
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
                                      }, child:
                                        // Check if image is not null
                                ClipOval(
                                  child: addCampaignController.image.value !=null?
                                  Image.file(
                                    addCampaignController.image.value!,
                                    fit: BoxFit.cover,
                                    width: 4.2.h *
                                        2, // Adjust width to match CircleAvatar's diameter
                                    height: 4.2.h *
                                        2, // Adjust height to match CircleAvatar's diameter
                                  ): SvgPicture.asset(
                                  "assets/svgs/myprofile.svg",
                                    fit: BoxFit.cover,
                                    width: 4.2.h *
                                        2, // Adjust width to match CircleAvatar's diameter
                                    height: 4.2.h *
                                        2, // Adjust height to match CircleAvatar's diameter
                                  ),
                                ),),

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
                                  style: CustomTextStyles.onBoardingHeading
                                      .copyWith(
                                          color: const Color(0xff191918),
                                          fontSize: 14.px,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'bold'),
                                ),
                                getVerticalSpace(.8.h),
                                Text(
                                  "This could be a web page or social media page",
                                  style: CustomTextStyles.onBoardingHeading
                                      .copyWith(
                                          color: const Color(0xff6E6E6D),
                                          fontSize: 12.px,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'regular'),
                                ),
                                getVerticalSpace(.8.h),
                                customTextFormField(
                                    controller: webUrlController,
                                    bgColor: AppColors.whiteColor),
                                getVerticalSpace(1.6.h),
                                Text(
                                  "Facebook",
                                  style: CustomTextStyles.onBoardingHeading
                                      .copyWith(
                                          color: const Color(0xff191918),
                                          fontSize: 14.px,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'bold'),
                                ),
                                getVerticalSpace(.8.h),
                                customTextFormField(
                                  controller: facebookUrlController,
                                  bgColor: AppColors.whiteColor,
                                  title: 'Enter your Facebook Account',
                                ),
                                getVerticalSpace(1.6.h),
                                Text(
                                  "Instagram",
                                  style: CustomTextStyles.onBoardingHeading
                                      .copyWith(
                                          color: const Color(0xff191918),
                                          fontSize: 14.px,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'bold'),
                                ),
                                getVerticalSpace(.8.h),
                                customTextFormField(
                                    controller: instagramUrlController,
                                    bgColor: AppColors.whiteColor,
                                    title: "Enter your Instagram Account"),
                                getVerticalSpace(1.6.h),
                                Text(
                                  "Tiktok",
                                  style: CustomTextStyles.onBoardingHeading
                                      .copyWith(
                                          color: const Color(0xff191918),
                                          fontSize: 14.px,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'bold'),
                                ),
                                getVerticalSpace(.8.h),
                                customTextFormField(
                                    controller: tikTokUrlController,
                                    bgColor: AppColors.whiteColor,
                                    title: "Enter your Tiktok Account"),
                                getVerticalSpace(1.6.h),
                                Text(
                                  "Linkedin",
                                  style: CustomTextStyles.onBoardingHeading
                                      .copyWith(
                                          color: const Color(0xff191918),
                                          fontSize: 14.px,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'bold'),
                                ),
                                getVerticalSpace(.8.h),
                                customTextFormField(
                                    controller: linkdinUrlController,
                                    bgColor: AppColors.whiteColor,
                                    title: "Enter your linkedin Account"),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                Align(
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
                                SizedBox(
                                  height: 50.3.h,
                                  child: GridView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: addCampaignController
                                        .pickedMediaList.length,
                                    physics:
                                    const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        mainAxisSpacing: 2.1.h,
                                        crossAxisSpacing: 1.6.h),
                                    itemBuilder: (context, index) {
                                      return Stack(children: [
                                        Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: .5.h,
                                              vertical: .5.h),
                                          height: 11.3.h,
                                          width: 11.6.h,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  1.h),
                                              color: AppColors.whiteColor,
                                              boxShadow: const [
                                                BoxShadow(
                                                    offset: Offset(0, 1),
                                                    spreadRadius: 0,
                                                    blurRadius: 8,
                                                    color:
                                                    Color(0xffFFE4EA))
                                              ]),
                                          child: addCampaignController
                                              .pickedMediaList[
                                          index]['isVideo'] ==
                                              "true"
                                              ? Image(
                                            image: FileImage(File(
                                                addCampaignController
                                                    .pickedMediaList[
                                                index]['path']!)),
                                            fit: BoxFit.cover,
                                          )
                                              : Image(
                                            image: FileImage(File(
                                                addCampaignController
                                                    .pickedMediaList[
                                                index]['path']!)),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ]);
                                    },
                                  ),
                                ),
                                getVerticalSpace(2.h),
                              ]),
                        ),
                      ),
                    ),
        ),
        );
  }
}
