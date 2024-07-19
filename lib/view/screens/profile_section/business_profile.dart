import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm/controller/custom_widgets/widgets.dart';

import '../../../controller/custom_widgets/app_colors.dart';
import '../../../controller/custom_widgets/custom_text_styles.dart';
import '../../../controller/getx_controllers/add_campaign_controller.dart';
import 'edit_profile.dart';

class BusinessProfile extends StatefulWidget {
  final String? businessName;
  final String? phoneNumber;
  final String? location;
  final String? targetArea;
  final String? description;
  final List? imagesList;
  final File? logo;

   const BusinessProfile(
      {super.key,
      this.businessName,
      this.phoneNumber,
      this.location,
      this.targetArea,
      this.description,
      this.imagesList,
      this.logo});

  @override
  State<BusinessProfile> createState() => _BusinessProfileState();
}

class _BusinessProfileState extends State<BusinessProfile> {
  final AddCampaignController addCampaignController =
      Get.put(AddCampaignController());

  @override
  Widget build(BuildContext context) {
    final List<String> items = [
      'Edit',
      'Delete',
      'View Campaign ',
    ];

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(onTap:(){
          Get.back();
        } ,
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
          'Business Profile One',
          style: CustomTextStyles.buttonTextStyle.copyWith(
              fontSize: 20.px,
              fontWeight: FontWeight.w600,
              color: AppColors.mainColor),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 1.h),
            child: PopupMenuButton<String>(
              itemBuilder: (BuildContext context) {
                return _buildPopupMenuItems(items);
              },
              icon: const Icon(Icons.more_vert),
              onSelected: (value) {
                if(value=='Edit'){
                  Get.to(()=>EditProfile(title: 'edit',));
                }
              },
            ),
          ),
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
                          widget.logo != null
                              ? ClipOval(
                                  child: Image.file(
                                    widget.logo!,
                                    fit: BoxFit.cover,
                                    width: 4.2.h *
                                        2, // Adjust width to match CircleAvatar's diameter
                                    height: 4.2.h *
                                        2, // Adjust height to match CircleAvatar's diameter
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 4.2.h,
                                  child: const Icon(Icons.add_a_photo),
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
                      widget.businessName ?? 'Business',
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
                      widget.phoneNumber ?? '03316027450',
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
                      widget.location ?? 'karachi',
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
                      widget.targetArea ?? 'joharTown',
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
                      widget.description ?? 'No Description',
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
                    widget.imagesList!=null
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
                    widget.imagesList!=null?         Obx(
                      () => SizedBox(
                        height: 50.3.h,
                        child: GridView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: widget.imagesList?.length,
                          physics: const NeverScrollableScrollPhysics(),
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
                                  borderRadius: BorderRadius.circular(1.h),
                                  color: AppColors.whiteColor,
                                  boxShadow: const [
                                    BoxShadow(
                                        offset: Offset(0, 1),
                                        spreadRadius: 0,
                                        blurRadius: 8,
                                        color: Color(0xffFFE4EA))
                                  ]),
                              child: widget.imagesList?[index]['isVideo'] ==
                                      "true"
                                  ? Image(
                                      image: FileImage(File(widget.imagesList![index]['path']!)))
                                  : Image(
                                      image: FileImage(File(widget.imagesList![index]['path']!))),
                            );
                          },
                        ),
                      ),
                    ):const SizedBox.shrink(),
                  ]),
            ),
          )),
    );
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
