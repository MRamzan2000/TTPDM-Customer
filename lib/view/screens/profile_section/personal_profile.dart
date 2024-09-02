import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm/controller/custom_widgets/widgets.dart';
import 'package:ttpdm/controller/getx_controllers/business_profile_controller.dart';
import 'package:ttpdm/controller/utils/my_shared_prefrence.dart';
import 'package:ttpdm/view/screens/profile_section/add_business.dart';
import 'package:ttpdm/view/screens/profile_section/business_profile.dart';

import '../../../controller/custom_widgets/app_colors.dart';
import '../../../controller/custom_widgets/custom_text_styles.dart';
import 'settng_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key,});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final BusinessProfileController businessProfileController =
      Get.find(tag: 'business');
  String? token;

  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  Future<void> _checkToken() async {
    token = await PreferencesService().getAuthToken();
    if (token != null) {
      // Use the token as needed
      businessProfileController.fetchBusiness(token: token!, context: context, loading: businessProfileController.businessProfiles.isEmpty);

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
        backgroundColor: AppColors.whiteColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Profile ',
          style: CustomTextStyles.buttonTextStyle.copyWith(
            fontSize: 20.px,
            fontWeight: FontWeight.w600,
            color: AppColors.mainColor,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 2.h),
            child: GestureDetector(
              onTap: () {
                Get.to(() => const LogOutScreen());
              },
              child: SizedBox(
                height: 3.h,
                width: 3.h,
                child: const Image(
                  image: AssetImage('assets/pngs/settingicon.png'),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getVerticalSpace(2.4.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.6.h),
                  child: Row(
                    children: [
                      Text(
                        'Approved',
                        style: TextStyle(
                          fontFamily: 'regular',
                          color: AppColors.mainColor,
                          fontSize: 12.px,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      getHorizentalSpace(2.h),
                      const Expanded(
                        child: Divider(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                if (businessProfileController.isLoading2.value)
                  ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: businessProfileController.businessProfiles
                        .length, // Number of shimmer items you want to display
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: AppColors.baseColor,
                        highlightColor: AppColors.highlightColor,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 2.4.h, vertical: 1.6.h),
                          padding: EdgeInsets.symmetric(
                              horizontal: 1.6.h, vertical: 2.0.h),
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(1.h),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 14.px,
                                height: 14.px,
                                color: Colors.white,
                              ),
                              Container(
                                width: 2.4.w.px,
                                height: 2.4.w.px,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                else if (businessProfileController.businessProfiles.isEmpty)
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        getVerticalSpace(2.h),
                        Text(
                          'No Business Profile Approved',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: 'bold',
                            fontSize: 14.px,
                            color: const Color(0xff282827),
                          ),
                        ),
                        getVerticalSpace(2.h)
                      ],
                    ),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount:
                        businessProfileController.businessProfiles.length,
                    itemBuilder: (context, index) {
                      final business =
                          businessProfileController.businessProfiles[index];
                      if (business!.status == 'Approved') {
                        return GestureDetector(
                          onTap: () {
                            log('logo detail ${businessProfileController.businessProfiles[index]!.logo}');
                            Get.to(() => BusinessProfile(
                              targetArea: businessProfileController
                                  .businessProfiles[index]!.targetMapArea,
                              logo: businessProfileController
                                  .businessProfiles[index]!.logo!,
                              location: businessProfileController
                                  .businessProfiles[index]!.location,
                              description: businessProfileController
                                  .businessProfiles[index]!.description,
                              businessName: businessProfileController
                                  .businessProfiles[index]!.name,
                              phoneNumber: businessProfileController
                                  .businessProfiles[index]!.phone,
                              businessId: businessProfileController
                                  .businessProfiles[index]!.id,
                              imagesList: businessProfileController
                                  .businessProfiles[index]!.gallery,
                              token:token! ,
                              fb:businessProfileController
                                  .businessProfiles[index]!.facebookUrl! ,
                              insta: businessProfileController
                                  .businessProfiles[index]!.instagramUrl!,
                              linkdin:businessProfileController
                                  .businessProfiles[index]!.linkedinUrl! ,
                              tiktok: businessProfileController
                                  .businessProfiles[index]!.tiktokUrl!,
                              webUrl:businessProfileController
                                  .businessProfiles[index]!.websiteUrl! ,


                            ));
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 2.4.h, vertical: 1.6.h),
                            padding: EdgeInsets.symmetric(
                                horizontal: 1.6.h, vertical: 2.0.h),
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(1.h),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  business.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'bold',
                                    fontSize: 14.px,
                                    color: const Color(0xff282827),
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  size: 2.4.h,
                                  color: const Color(0xff191918),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              getVerticalSpace(2.h),
                              Text(
                                'No Business Profile Approved',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'bold',
                                  fontSize: 14.px,
                                  color: const Color(0xff282827),
                                ),
                              ),
                              getVerticalSpace(2.h)
                            ],
                          ),
                        ); // Empty widget for non-approved profiles
                      }
                    },
                  ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.6.h),
                  child: Row(
                    children: [
                      Text(
                        'Pending Approval',
                        style: TextStyle(
                          fontFamily: 'regular',
                          color: const Color(0xff007AFF),
                          fontSize: 12.px,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      getHorizentalSpace(2.h),
                      const Expanded(
                        child: Divider(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                if (businessProfileController.isLoading2.value)
                  ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    // businessProfileController.businessProfiles
                    //     .length, // Number of shimmer items you want to display
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: AppColors.baseColor,
                        highlightColor: AppColors.highlightColor,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 2.4.h, vertical: 1.6.h),
                          padding: EdgeInsets.symmetric(
                              horizontal: 1.6.h, vertical: 2.0.h),
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(1.h),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 14.px,
                                height: 14.px,
                                color: Colors.white,
                              ),
                              Container(
                                width: 2.4.w.px,
                                height: 2.4.w.px,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                else if (businessProfileController.businessProfiles.isEmpty)
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        getVerticalSpace(2.h),
                        Text(
                          'No Business Profile Pending',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: 'bold',
                            fontSize: 14.px,
                            color: const Color(0xff282827),
                          ),
                        ),
                        getVerticalSpace(2.h)
                      ],
                    ),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount:
                        businessProfileController.businessProfiles.length,
                    itemBuilder: (context, index) {
                      final business =
                          businessProfileController.businessProfiles[index];
                      if (business!.status == 'pending') {
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => BusinessProfile(
                              targetArea: businessProfileController
                                  .businessProfiles[index]!.targetMapArea,
                              logo: businessProfileController
                                  .businessProfiles[index]!.logo!,
                              location: businessProfileController
                                  .businessProfiles[index]!.location,
                              description: businessProfileController
                                  .businessProfiles[index]!.description,
                              businessName: businessProfileController
                                  .businessProfiles[index]!.name,
                              phoneNumber: businessProfileController
                                  .businessProfiles[index]!.phone,
                              businessId: businessProfileController
                                  .businessProfiles[index]!.id,
                              imagesList: businessProfileController
                                  .businessProfiles[index]!.gallery,
                              token:token! ,
                              fb:businessProfileController
                                  .businessProfiles[index]!.facebookUrl! ,
                              insta: businessProfileController
                                  .businessProfiles[index]!.instagramUrl!,
                              linkdin:businessProfileController
                                  .businessProfiles[index]!.linkedinUrl! ,
                              tiktok: businessProfileController
                                  .businessProfiles[index]!.tiktokUrl!,
                              webUrl:businessProfileController
                                  .businessProfiles[index]!.websiteUrl! ,


                            ));
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 2.4.h, vertical: 1.6.h),
                            padding: EdgeInsets.symmetric(
                                horizontal: 1.6.h, vertical: 2.0.h),
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(1.h),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  business.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'bold',
                                    fontSize: 14.px,
                                    color: const Color(0xff282827),
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  size: 2.4.h,
                                  color: const Color(0xff191918),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              getVerticalSpace(2.h),
                              Text(
                                'No Business Profile Pending',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'bold',
                                  fontSize: 14.px,
                                  color: const Color(0xff282827),
                                ),
                              ),
                              getVerticalSpace(2.h)
                            ],
                          ),
                        ); // Empty widget for non-approved profiles
                      }
                    },
                  ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.6.h),
                  child: Row(
                    children: [
                      Text(
                        'Rejected ',
                        style: TextStyle(
                          fontFamily: 'regular',
                          color: const Color(0xffFF3B30),
                          fontSize: 12.px,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      getHorizentalSpace(2.h),
                      const Expanded(
                        child: Divider(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                if (businessProfileController.isLoading2.value)
                  ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: businessProfileController.businessProfiles
                        .length, // Number of shimmer items you want to display
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: AppColors.baseColor,
                        highlightColor: AppColors.highlightColor,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 2.4.h, vertical: 1.6.h),
                          padding: EdgeInsets.symmetric(
                              horizontal: 1.6.h, vertical: 2.0.h),
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(1.h),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 14.px,
                                height: 14.px,
                                color: Colors.white,
                              ),
                              Container(
                                width: 2.4.w.px,
                                height: 2.4.w.px,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                else if (businessProfileController.businessProfiles.isEmpty)
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        getVerticalSpace(2.h),
                        Text(
                          'No Business Profile Rejected',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: 'bold',
                            fontSize: 14.px,
                            color: const Color(0xff282827),
                          ),
                        ),
                        getVerticalSpace(2.h)
                      ],
                    ),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount:
                        businessProfileController.businessProfiles.length,
                    itemBuilder: (context, index) {
                      final business =
                          businessProfileController.businessProfiles[index];
                      if (business!.status == 'Rejected') {
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => BusinessProfile(
                                  targetArea: businessProfileController
                                      .businessProfiles[index]!.targetMapArea,
                                  logo: businessProfileController
                                      .businessProfiles[index]!.logo!,
                                  location: businessProfileController
                                      .businessProfiles[index]!.location,
                                  description: businessProfileController
                                      .businessProfiles[index]!.description,
                                  businessName: businessProfileController
                                      .businessProfiles[index]!.name,
                                  phoneNumber: businessProfileController
                                      .businessProfiles[index]!.phone,
                                  businessId: businessProfileController
                                      .businessProfiles[index]!.id,
                                  imagesList: businessProfileController
                                      .businessProfiles[index]!.gallery,
                              token:token! ,
                              fb:businessProfileController
                                  .businessProfiles[index]!.facebookUrl! ,
                              insta: businessProfileController
                                  .businessProfiles[index]!.instagramUrl!,
                              linkdin:businessProfileController
                                  .businessProfiles[index]!.linkedinUrl! ,
                              tiktok: businessProfileController
                                  .businessProfiles[index]!.tiktokUrl!,
                              webUrl:businessProfileController
                                  .businessProfiles[index]!.websiteUrl! ,


                                ));
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 2.4.h, vertical: 1.6.h),
                            padding: EdgeInsets.symmetric(
                                horizontal: 1.6.h, vertical: 2.0.h),
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(1.h),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  business.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'bold',
                                    fontSize: 14.px,
                                    color: const Color(0xff282827),
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  size: 2.4.h,
                                  color: const Color(0xff191918),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              getVerticalSpace(2.h),
                              Text(
                                'No Business Profile Rejected',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'bold',
                                  fontSize: 14.px,
                                  color: const Color(0xff282827),
                                ),
                              ),
                              getVerticalSpace(2.h)
                            ],
                          ),
                        ); // Empty widget for non-approved profiles
                      }
                    },
                  ),
                getVerticalSpace(1.6.h),
                GestureDetector(
                  onTap: () {
                    Get.to(() =>  const AddNewBusiness());
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: 2.4.h, vertical: 1.6.h),
                    padding: EdgeInsets.symmetric(
                        horizontal: 1.6.h, vertical: 2.0.h),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(1.h),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.add,
                          size: 3.h,
                          color: AppColors.mainColor,
                        ),
                        Text(
                          'Add New Business',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: 'bold',
                            fontSize: 14.px,
                            color: AppColors.mainColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                getVerticalSpace(10.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
