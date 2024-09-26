import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm/controller/custom_widgets/widgets.dart';
import 'package:ttpdm/controller/getx_controllers/business_profile_controller.dart';
import 'package:ttpdm/controller/utils/my_shared_prefrence.dart';
import 'package:ttpdm/controller/utils/preference_key.dart';
import 'package:ttpdm/view/screens/profile_section/add_business.dart';
import 'package:ttpdm/view/screens/profile_section/business_profile.dart';
import '../../../controller/custom_widgets/app_colors.dart';
import '../../../controller/custom_widgets/custom_text_styles.dart';
import 'settng_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final BusinessProfileController businessProfileController =
      Get.find(tag: 'business');
  RxString token = "".obs;
  @override
  void initState() {
    super.initState();
    token.value = MySharedPreferences.getString(authToken);
    businessProfileController.fetchBusiness(
        token: token.value,
        context: context,
        loading: businessProfileController.allBusinessProfiles.isEmpty);
  }

  RxBool hasDisplayedNoProfileMessage = false.obs;
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
                    itemCount: 1,
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
                else if (businessProfileController.approvedProfiles.isEmpty)
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
                        businessProfileController.approvedProfiles.length,
                    itemBuilder: (context, index) {
                      {
                        return GestureDetector(
                          onTap: () {
                            log('logo detail ${businessProfileController.approvedProfiles[index]!.logo}');
                            Get.to(() => BusinessProfile(
                                  targetArea: businessProfileController
                                      .approvedProfiles[index]!.targetMapArea,
                                  logo: businessProfileController
                                      .approvedProfiles[index]!.logo!,
                                  location: businessProfileController
                                      .approvedProfiles[index]!.location,
                                  description: businessProfileController
                                      .approvedProfiles[index]!.description,
                                  businessName: businessProfileController
                                      .approvedProfiles[index]!.name,
                                  phoneNumber: businessProfileController
                                      .approvedProfiles[index]!.phone,
                                  businessId: businessProfileController
                                      .approvedProfiles[index]!.id,
                                  imagesList: businessProfileController
                                      .approvedProfiles[index]!.gallery,
                                  token: token.value,
                                  fb: businessProfileController
                                      .approvedProfiles[index]!.facebookUrl!,
                                  insta: businessProfileController
                                      .approvedProfiles[index]!.instagramUrl!,
                                  linkdin: businessProfileController
                                      .approvedProfiles[index]!.linkedinUrl!,
                                  tiktok: businessProfileController
                                      .approvedProfiles[index]!.tiktokUrl!,
                                  webUrl: businessProfileController
                                      .approvedProfiles[index]!.websiteUrl!,
                                  status: businessProfileController
                                      .approvedProfiles[index]!.status,
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
                                  businessProfileController
                                      .approvedProfiles[index]!.name,
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
                      }
                    },
                  ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.6.h),
                  child: Row(
                    children: [
                      Text(
                        'Pending',
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
                    itemCount: 1,
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
                else if (businessProfileController.pendingProfiles.isEmpty)
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
                    itemCount: businessProfileController.pendingProfiles.length,
                    itemBuilder: (context, index) {
                      final business =
                          businessProfileController.pendingProfiles[index];
                      {
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => BusinessProfile(
                                  targetArea: businessProfileController
                                      .pendingProfiles[index]!.targetMapArea,
                                  logo: businessProfileController
                                      .pendingProfiles[index]!.logo!,
                                  location: businessProfileController
                                      .pendingProfiles[index]!.location,
                                  description: businessProfileController
                                      .pendingProfiles[index]!.description,
                                  businessName: businessProfileController
                                      .pendingProfiles[index]!.name,
                                  phoneNumber: businessProfileController
                                      .pendingProfiles[index]!.phone,
                                  businessId: businessProfileController
                                      .pendingProfiles[index]!.id,
                                  imagesList: businessProfileController
                                      .pendingProfiles[index]!.gallery,
                                  token: token.value,
                                  fb: businessProfileController
                                      .pendingProfiles[index]!.facebookUrl!,
                                  insta: businessProfileController
                                      .pendingProfiles[index]!.instagramUrl!,
                                  linkdin: businessProfileController
                                      .pendingProfiles[index]!.linkedinUrl!,
                                  tiktok: businessProfileController
                                      .pendingProfiles[index]!.tiktokUrl!,
                                  webUrl: businessProfileController
                                      .pendingProfiles[index]!.websiteUrl!,
                                  status: businessProfileController
                                      .pendingProfiles[index]!.status,
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
                                  business!.name,
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
                    itemCount: 1, // Number of shimmer items you want to display
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
                else if (businessProfileController.rejectedProfiles.isEmpty)
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
                        businessProfileController.rejectedProfiles.length,
                    itemBuilder: (context, index) {
                      final business =
                          businessProfileController.rejectedProfiles[index];
                      {
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => BusinessProfile(
                                  targetArea: businessProfileController
                                      .rejectedProfiles[index]!.targetMapArea,
                                  logo: businessProfileController
                                      .rejectedProfiles[index]!.logo!,
                                  location: businessProfileController
                                      .rejectedProfiles[index]!.location,
                                  description: businessProfileController
                                      .rejectedProfiles[index]!.description,
                                  businessName: businessProfileController
                                      .rejectedProfiles[index]!.name,
                                  phoneNumber: businessProfileController
                                      .rejectedProfiles[index]!.phone,
                                  businessId: businessProfileController
                                      .rejectedProfiles[index]!.id,
                                  imagesList: businessProfileController
                                      .rejectedProfiles[index]!.gallery,
                                  token: token.value,
                                  fb: businessProfileController
                                      .rejectedProfiles[index]!.facebookUrl!,
                                  insta: businessProfileController
                                      .rejectedProfiles[index]!.instagramUrl!,
                                  linkdin: businessProfileController
                                      .rejectedProfiles[index]!.linkedinUrl!,
                                  tiktok: businessProfileController
                                      .rejectedProfiles[index]!.tiktokUrl!,
                                  webUrl: businessProfileController
                                      .rejectedProfiles[index]!.websiteUrl!,
                                  status: businessProfileController
                                      .rejectedProfiles[index]!.status,
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
                                  business!.name,
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
                      }
                    },
                  ),
                getVerticalSpace(1.6.h),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const AddNewBusiness());
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
