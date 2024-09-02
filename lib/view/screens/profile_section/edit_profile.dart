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

class EditProfile extends StatefulWidget {
  final String title;
  final String businessName;
  final String phoneNumber;
  final String location;
  final String targetArea;
  final String description;
  final String businessId;
  final RxList<String> imagesList;
  final String logo;
  final String token;
  final String webUrl;
  final String fb;
  final String insta;
  final String tiktok;
  final String linkdin;

  const EditProfile(
      {super.key,
      required this.title,
      required this.businessName,
      required this.phoneNumber,
      required this.location,
      required this.targetArea,
      required this.description,
      required this.businessId,
      required this.imagesList,
      required this.logo,
      required this.token,
      required this.webUrl,
      required this.fb,
      required this.insta,
      required this.tiktok,
      required this.linkdin});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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
  RxList<String> networkImagesList =
      <String>[].obs; // This should be populated with the URLs or IDs of network images.

  void submitForm() {
    businessProfileController.editBusinessProfile(
        name: bsNameController.text,
        phone: phoneNumberController.text,
        location: locationController.text,
        targetMapArea: targetController.text,
        description: descriptionController.text,
        gallery:networkImagesList,
        token: token!,
        websiteUrl: webUrlController.text,
        tiktokUrl: tikTokUrlController.text,
        linkedinUrl: linkdinUrlController.text,
        instagramUrl: instagramUrlController.text,
        facebookUrl: facebookUrlController.text,
        logo: addCampaignController.image.value?.path??widget.logo,
        context: context,
        businessId: widget.businessId);
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
                // Get.to(()=>const CustomBottomNavigationBar());

                submitForm();
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
        body: Obx(
          () => businessProfileController.isLoading1.value
              ? spinkit1
              : SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.4.h),
                    child: SingleChildScrollView(
                      child: Obx(
                        () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              getVerticalSpace(2.4.h),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          addCampaignController
                                              .pickImage(ImageSource.gallery);
                                        },
                                        child:
                                            addCampaignController.image.value !=
                                                    null
                                                ? ClipOval(
                                                    child: addCampaignController
                                                                .image.value !=
                                                            null
                                                        ? Image.file(
                                                            addCampaignController
                                                                .image.value!,
                                                            fit: BoxFit.cover,
                                                            width: 4.2.h *
                                                                2, // Adjust width to match CircleAvatar's diameter
                                                            height: 4.2.h *
                                                                2, // Adjust height to match CircleAvatar's diameter
                                                          )
                                                        : SvgPicture.asset(
                                                            "assets/svgs/myprofile.svg",
                                                            fit: BoxFit.cover,
                                                            width: 4.2.h *
                                                                2, // Adjust width to match CircleAvatar's diameter
                                                            height: 4.2.h *
                                                                2, // Adjust height to match CircleAvatar's diameter
                                                          ),
                                                  )
                                                : widget.logo.isEmpty
                                                    ? CircleAvatar(
                                                        radius: 4.2.h,
                                                        child: const Icon(
                                                            Icons.add_a_photo),
                                                      )
                                                    : ClipOval(
                                                        child: Image.network(
                                                          widget.logo,
                                                          fit: BoxFit.cover,
                                                          width: 4.2.h *
                                                              2, // Adjust width to match CircleAvatar's diameter
                                                          height: 4.2.h *
                                                              2, // Adjust height to match CircleAvatar's diameter
                                                        ),
                                                      )),
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
                                  title: widget.businessName,
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
                                  title: widget.phoneNumber,
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
                                  title: widget.location,
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
                                  title: widget.targetArea,
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
                                  title: widget.webUrl,
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
                                title: widget.fb,
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
                                  title: widget.insta),
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
                                  title: widget.tiktok),
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
                                  title: widget.description,
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
                              if (widget.imagesList.isEmpty)
                                const SizedBox.shrink()
                              else
                                SizedBox(
                                  height: 32.3.h,
                                  child: GridView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: widget.imagesList.length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            mainAxisSpacing: 2.1.h,
                                            crossAxisSpacing: 1.6.h),
                                    itemBuilder: (context, index) {
                                      return Container(
                                          alignment: Alignment.center,
                                          height: 11.3.h,
                                          width: 11.6.h,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(1.h),
                                              color: AppColors.whiteColor,
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  widget.imagesList[index],
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                              boxShadow: const [
                                                BoxShadow(
                                                    offset: Offset(0, 1),
                                                    spreadRadius: 0,
                                                    blurRadius: 8,
                                                    color: Color(0xffFFE4EA))
                                              ]),
                                          child: Align(
                                              alignment: Alignment.topRight,
                                              child: GestureDetector(
                                                onTap: () {
                                                  widget.imagesList
                                                      .removeAt(index);
                                                  widget.imagesList.refresh();
                                                  log("imagesLength :${widget.imagesList}");
                                                  networkImagesList.addAll(widget.imagesList);
                                                },
                                                child: SvgPicture.asset(
                                                    "assets/svgs/crossicon.svg"),
                                              )));
                                    },
                                  ),
                                ),
                              addCampaignController.pickedMediaList.isEmpty
                                  ? Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Text(
                                        'You can upload your business images and videos',
                                        style: TextStyle(
                                            fontSize: 12.px,
                                            color: const Color(0xff7C7C7C),
                                            fontFamily: 'regular',
                                            fontWeight: FontWeight.w400),
                                      ),
                                    )
                                  : SizedBox(
                                      height: 40.3.h,
                                      child: GridView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: addCampaignController
                                            .pickedMediaList.length,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount:
                                                    addCampaignController
                                                        .pickedMediaList.length,
                                                mainAxisSpacing: 2.1.h,
                                                crossAxisSpacing: 1.6.h),
                                        itemBuilder: (context, index) {
                                          return Stack(children: [
                                            Container(
                                              alignment: Alignment.center,
                                              height: 11.3.h,
                                              width: 11.6.h,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          1.h),
                                                  color: AppColors.whiteColor,
                                                  image: DecorationImage(
                                                    image: FileImage(File(
                                                        addCampaignController
                                                                .pickedMediaList[
                                                            index]['path']!)),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                        offset: Offset(0, 1),
                                                        spreadRadius: 0,
                                                        blurRadius: 8,
                                                        color:
                                                            Color(0xffFFE4EA))
                                                  ]),
                                            ),
                                          ]);
                                        },
                                      ),
                                    ),
                              getVerticalSpace(2.h),
                            ]),
                      ),
                    ),
                  )),
        ));
  }
}
