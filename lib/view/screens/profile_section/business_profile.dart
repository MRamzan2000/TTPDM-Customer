import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm/controller/custom_widgets/widgets.dart';
import 'package:ttpdm/controller/utils/apis_constant.dart';
import 'package:ttpdm/controller/utils/my_shared_prefrence.dart';
import 'package:ttpdm/controller/utils/preference_key.dart';

import '../../../controller/custom_widgets/app_colors.dart';
import '../../../controller/custom_widgets/custom_text_styles.dart';
import '../../../controller/getx_controllers/add_campaign_controller.dart';
import '../../../controller/getx_controllers/business_profile_controller.dart';
import 'edit_profile.dart';

class BusinessProfile extends StatefulWidget {
  final String businessName;
  final String phoneNumber;
  final String location;
  final String targetArea;
  final String description;
  final String businessId;
  final String rejectionReason;
  final List<String> imagesList;
  final String logo;
  final String token;
  final String webUrl;
  final String fb;
  final String insta;
  final String tiktok;
  final String linkdin;
  final String status;

  const BusinessProfile(
      {super.key,
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
      required this.linkdin,
      required this.status, required this.rejectionReason});

  @override
  State<BusinessProfile> createState() => _BusinessProfileState();
}

class _BusinessProfileState extends State<BusinessProfile> {
  final AddCampaignController addCampaignController =
      Get.put(AddCampaignController());
  final BusinessProfileController businessProfileController =
      Get.find(tag: "business");
  RxString token = "".obs;
  @override
  void initState() {
    super.initState();
    token.value = MySharedPreferences.getString(authTokenKey);
  }
  @override
  Widget build(BuildContext context) {
    log("status :${widget.status}");
    final List<String> items = [
      'Edit',
      'Delete',
    ];
    final List<String> item2 = [
      'Delete',
      'View Campaign ',
    ];

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
            widget.businessName,
            style: CustomTextStyles.buttonTextStyle.copyWith(
                fontSize: 20.px,
                fontWeight: FontWeight.w600,
                color: AppColors.mainColor),
          ),
          actions: [
            widget.status == "rejected"
                ? const SizedBox.shrink()
                : Padding(
                    padding: EdgeInsets.only(right: 1.h),
                    child: PopupMenuButton<String>(
                      itemBuilder: (BuildContext context) {
                        return _buildPopupMenuItems(
                            widget.status == "approved" ? item2 : items);
                      },
                      icon: const Icon(Icons.more_vert),
                      onSelected: (value) {
                        if (value == 'Edit') {
                          Get.to(() => EditProfile(
                                title: 'edit',
                                token: widget.token,
                                businessId: widget.businessId,
                                businessName: widget.businessName,
                                description: widget.description,
                                imagesList: widget.imagesList.obs,
                                location: widget.location,
                                logo: widget.logo,
                                phoneNumber: widget.phoneNumber,
                                targetArea: widget.targetArea,
                                webUrl: widget.webUrl,
                                fb: widget.fb,
                                insta: widget.insta,
                                tiktok: widget.tiktok,
                                linkdin: widget.linkdin,
                              ));
                        } else if (value == "Delete") {
                          businessProfileController.deleteBusiness(
                              token: token.value,
                              context: context,
                              businessId: widget.businessId);
                        }
                      },
                    ),
                  ),
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
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            getVerticalSpace(2.4.h),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  widget.logo.isEmpty
                                      ? CircleAvatar(
                                          backgroundColor: AppColors.whiteColor,
                                          radius: 4.2.h,
                                          child: const Icon(Icons.add_a_photo),
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
                                        ),
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
                            Text(
                              widget.businessName,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'bold',
                                  color: AppColors.blackColor,
                                  fontSize: 12.px),
                            ),
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
                            Text(
                              widget.phoneNumber,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'bold',
                                  color: AppColors.blackColor,
                                  fontSize: 12.px),
                            ),
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
                            Text(
                              widget.location,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'bold',
                                  color: AppColors.blackColor,
                                  fontSize: 12.px),
                            ),
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
                            Text(
                              widget.targetArea,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'bold',
                                  color: AppColors.blackColor,
                                  fontSize: 12.px),
                            ),
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
                            Text(
                              widget.description,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'bold',
                                  color: AppColors.blackColor,
                                  fontSize: 12.px),
                            ),
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
                                // GestureDetector(
                                //   onTap: () {
                                //     // addCampaignController.pickMedia();
                                //   },
                                //   child: Text(
                                //     'Upload',
                                //     style: TextStyle(
                                //         fontWeight: FontWeight.w500,
                                //         fontFamily: 'bold',
                                //         fontSize: 14.px,
                                //         color: const Color(0xff007AFF)),
                                //   ),
                                // ),
                              ],
                            ),
                            getVerticalSpace(1.2.h),
                            widget.imagesList.isEmpty
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
                                : const SizedBox.shrink(),
                            widget.imagesList.isEmpty
                                ? const SizedBox.shrink()
                                : Container(
                              padding: EdgeInsets.only(left: 1.h,right: 1.h,top: 1.h),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(1.h),
                                  color: Colors.grey.withOpacity(0.2)),
                              height: 32.3.h,
                              child: GridView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: widget.imagesList.length,
                                gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 2.1.h,
                                    crossAxisSpacing: 1.6.h),
                                itemBuilder: (context, index) {
                                  return Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: .5.h, vertical: .5.h),
                                    height: 11.3.h,
                                    width: 11.6.h,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(1.h),
                                        color: AppColors.whiteColor,
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              widget.imagesList[index]),
                                          fit: BoxFit.cover,
                                        ),
                                        boxShadow: const [
                                          BoxShadow(
                                              offset: Offset(0, 1),
                                              spreadRadius: 0,
                                              blurRadius: 8,
                                              color: Color(0xffFFE4EA))
                                        ]),
                                  );
                                },
                              ),
                            ),
                            widget.status == "rejected"? getVerticalSpace(1.h):getVerticalSpace(0),

                            widget.status == "rejected"
                                ?Text(
                              'Rejection Reason',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'bold',
                                  fontSize: 14.px,
                                  color: const Color(0xff282827)),
                            ):const SizedBox.shrink(),

                            widget.status == "rejected"?  getVerticalSpace(1.h):getVerticalSpace(0),
                            widget.status == "rejected"
                                ? Container(alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 2.h),
                              decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1.5.h),
                              color: Colors.white
                            ),
                            child: Text(widget.rejectionReason, style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: 'bold',
                                fontSize: 12.px,
                                color: const Color(0xff282827)),),)
                                : const SizedBox.shrink(),
                            widget.status == "rejected"?  getVerticalSpace(2.h):getVerticalSpace(0),

                          ]),
                    ),
                  )),
        ));
  }

  List<PopupMenuEntry<String>> _buildPopupMenuItems(List<String> items) {
    List<PopupMenuEntry<String>> menuItems = [];
    for (int i = 0; i < items.length; i++) {
      menuItems.add(
        PopupMenuItem<String>(
          value: items[i],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(items[i]),
              if (i < items.length - 1) const Divider(thickness: 1),
            ],
          ),
        ),
      );
    }
    return menuItems;
  }
}
