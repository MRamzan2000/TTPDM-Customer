
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ttpdm/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm/controller/custom_widgets/widgets.dart';
import 'package:ttpdm/controller/getx_controllers/add_campaign_controller.dart';
import 'package:ttpdm/controller/getx_controllers/business_profile_controller.dart';
import 'package:ttpdm/controller/utils/my_shared_prefrence.dart';
import 'package:ttpdm/view/screens/campaign_section/campaign_name.dart';
import 'package:ttpdm/view/screens/notification_section/notification_screen.dart';

class HomeScreen extends StatefulWidget {
   const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
final AddCampaignController addCampaignController=Get.put(AddCampaignController());
final BusinessProfileController businessProfileController=Get.find(tag: 'business');
String? token;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
_checkToken().then((value) {
  log("Previous Ads ${addCampaignController.previousCampaigns.value == null}");
  return  addCampaignController.fetchCampaignByStatus(context: context, status: "previous",  isLoad: addCampaignController.previousCampaigns.value == null);
},);
  }
Future<void> _checkToken() async {
  token = await PreferencesService().getAuthToken();
  if (token != null) {
    log("Token: $token");
  } else {
    log("No token available");
  }
}

@override
  Widget build(BuildContext context) {
    final RxInt selectedIndex = 0.obs;
    final RxList tabBarItems = [
      'Previous ads',
      '    Pending    ',
      'Upcoming ads',
    ].obs;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TTPDM',
          style: CustomTextStyles.onBoardingHeading.copyWith(fontSize: 20.px),
        ),
        centerTitle: true,
        backgroundColor: AppColors.whiteColor,
        automaticallyImplyLeading: false,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.4.h),
          child: Obx(
            () => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          radius: 2.8.h,
                          backgroundImage:
                              const AssetImage('assets/pngs/profile.png'),
                        ),
                        title: Text(
                          'Hello Mohsin',
                          style: TextStyle(
                              fontFamily: 'bold',
                              fontWeight: FontWeight.w400,
                              fontSize: 18.px,
                              color: const Color(0xff2F3542)),
                        ),
                        subtitle: Text('Welcome Back',
                            style: TextStyle(
                                fontFamily: 'light',
                                fontWeight: FontWeight.w400,
                                fontSize: 12.px,
                                color: const Color(0xff2F3542))),
                        trailing: GestureDetector(
                          onTap: () {
                            Get.to(() => const NotiFicationScreen());
                          },
                          child: svgImage('assets/svgs/notification.svg'),
                        ),
                      ),
                      getVerticalSpace(1.h),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.h),
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(0, 10),
                                  spreadRadius: 0,
                                  blurRadius: 20,
                                  color:
                                      const Color(0xff2F3542).withOpacity(0.1))
                            ]),
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.h),
                                  borderSide: BorderSide.none),
                              isCollapsed: true,
                              filled: true,
                              fillColor: const Color(0xffFFFFFF),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 1.6.h, vertical: 1.4.h),
                              hintText: 'Search for ads...',
                              hintStyle: TextStyle(
                                  fontSize: 12.px,
                                  color: const Color(0xff2F3542),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'bold'),
                              prefixIcon: Container(
                                height: 10,
                                width: 10,
                                alignment: Alignment.center,
                                child: svgImage(
                                  'assets/svgs/search.svg',
                                ),
                              )),
                        ),
                      ),
                      getVerticalSpace(1.6.h),
                      SizedBox(
                        height: 5.h,
                        child: ListView.builder(

                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: tabBarItems.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                selectedIndex.value = index;
                                if(selectedIndex.value ==0){
                                  addCampaignController.fetchCampaignByStatus(context: context,
                                      status: "previous", isLoad: addCampaignController.previousCampaigns.value == null);
                                }else if(selectedIndex.value ==1){
                                  addCampaignController.fetchCampaignByStatus(context: context,
                                      status: "pending", isLoad: addCampaignController.pendingCampaigns.value == null);
                                }else{
                                  addCampaignController.fetchCampaignByStatus(context: context,
                                      status: "upcoming", isLoad: addCampaignController.upcomingCampaigns.value == null);
                                }
                              },
                              child: Obx(
                                () => Container(
                                  alignment: Alignment.center,
                                  margin:
                                      EdgeInsets.symmetric(horizontal: .6.h),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 1.6.h, vertical: 1.h),
                                  decoration: BoxDecoration(
                                      color: selectedIndex.value == index
                                          ? AppColors.mainColor
                                          : AppColors.whiteColor,
                                      borderRadius: BorderRadius.circular(
                                        10.h,
                                      ),
                                      border: Border.all(
                                          color: selectedIndex.value == index
                                              ? AppColors.mainColor
                                              : AppColors.whiteColor)),
                                  child: Text(
                                    tabBarItems[index],
                                    style: TextStyle(
                                        color: selectedIndex.value == index
                                            ? AppColors.whiteColor
                                            : const Color(0xff454544),
                                        fontFamily: 'bold',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.px),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      getVerticalSpace(1.6.h),
                      selectedIndex.value == 0
                          ?
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Previous ads',
                            style: TextStyle(
                              fontSize: 20.px,
                              color: const Color(0xff2F3542),
                              fontWeight: FontWeight.w500,
                              fontFamily: 'bold',
                            ),
                          ),
                          getVerticalSpace(1.3.h),
                          Row(
                            children: [
                              Text(
                                'Business name',
                                style: TextStyle(
                                  fontSize: 12.px,
                                  color: const Color(0xff454544),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'regular',
                                ),
                              ),
                              getHorizentalSpace(1.h),
                              const Expanded(
                                child: Divider(
                                  color: Color(0xff454544),
                                ),
                              ),
                            ],
                          ),
                          getVerticalSpace(1.h),
                          Obx(() {
                            if (addCampaignController.isLoading.value) {
                              return ListView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemCount: 3, // Show a fixed number of shimmer placeholders
                                itemBuilder: (context, index) {
                                  return Shimmer.fromColors(
                                    baseColor: AppColors.baseColor,
                                    highlightColor: AppColors.highlightColor,
                                    child: Container(
                                      padding: EdgeInsets.all(1.6.h),
                                      width: MediaQuery.of(context).size.width,
                                      color: AppColors.whiteColor,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            color: Colors.grey,
                                            height: 15.h, // Adjust height for placeholder image
                                            width: double.infinity,
                                          ),
                                          getVerticalSpace(.8.h),
                                          Container(
                                            color: Colors.grey,
                                            height: 2.h, // Adjust height for placeholder text
                                            width: double.infinity,
                                          ),
                                          getVerticalSpace(.5.h),
                                          Container(
                                            color: Colors.grey,
                                            height: 2.h, // Adjust height for placeholder text
                                            width: double.infinity,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else if (addCampaignController.previousCampaigns.value!.campaigns.isEmpty) {
                              return Column(
                                children: [
                                  getVerticalSpace(20.h),
                                  Align(alignment: Alignment.center,
                                    child: Text(
                                      "No Previous ads",
                                      style: TextStyle(
                                        fontSize: 20.px,
                                        color: AppColors.mainColor,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'bold',
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Expanded(
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: addCampaignController.previousCampaigns.value!.campaigns.length,
                                  itemBuilder: (context, index) {
                                    final campaign = addCampaignController.previousCampaigns.value!.campaigns[index];
                                    return Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Get.to(() => CampaignName());
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(1.6.h),
                                            width: MediaQuery.of(context).size.width,
                                            color: AppColors.whiteColor,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Image.network(campaign.adBanner),
                                                getVerticalSpace(.8.h),
                                                Text(
                                                  campaign.adsName,
                                                  style: TextStyle(
                                                    fontSize: 14.px,
                                                    fontFamily: 'bold',
                                                    fontWeight: FontWeight.w500,
                                                    color: const Color(0xff191918),
                                                  ),
                                                ),
                                                getVerticalSpace(.5.h),
                                                Text(
                                                  campaign.campaignDesc,
                                                  style: TextStyle(
                                                    fontSize: 12.px,
                                                    fontFamily: 'bold',
                                                    fontWeight: FontWeight.w500,
                                                    color: const Color(0xff6E6E6D),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        getVerticalSpace(1.6.h),
                                        Container(
                                          padding: EdgeInsets.all(1.6.h),
                                          width: MediaQuery.of(context).size.width,
                                          color: AppColors.whiteColor,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              getVerticalSpace(.8.h),
                                              Text(
                                                campaign.adsName,
                                                style: TextStyle(
                                                  fontSize: 14.px,
                                                  fontFamily: 'bold',
                                                  fontWeight: FontWeight.w500,
                                                  color: const Color(0xff191918),
                                                ),
                                              ),
                                              getVerticalSpace(.5.h),
                                              Text(
                                                campaign.campaignDesc,
                                                style: TextStyle(
                                                  fontSize: 12.px,
                                                  fontFamily: 'bold',
                                                  fontWeight: FontWeight.w500,
                                                  color: const Color(0xff6E6E6D),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              );
                            }
                          }),
                        ],
                      )
                  : selectedIndex.value == 1?
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pending ads',
                            style: TextStyle(
                              fontSize: 20.px,
                              color: const Color(0xff2F3542),
                              fontWeight: FontWeight.w500,
                              fontFamily: 'bold',
                            ),
                          ),
                          getVerticalSpace(1.3.h),
                          Row(
                            children: [
                              Text(
                                'Business name',
                                style: TextStyle(
                                  fontSize: 12.px,
                                  color: const Color(0xff454544),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'regular',
                                ),
                              ),
                              getHorizentalSpace(1.h),
                              const Expanded(
                                child: Divider(
                                  color: Color(0xff454544),
                                ),
                              ),
                            ],
                          ),
                          getVerticalSpace(1.h),
                          Obx(() {
                            if (addCampaignController.isLoading.value) {
                              return ListView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemCount: 3, // Show a fixed number of shimmer placeholders
                                itemBuilder: (context, index) {
                                  return Shimmer.fromColors(
                                    baseColor: AppColors.baseColor,
                                    highlightColor: AppColors.highlightColor,
                                    child: Container(
                                      padding: EdgeInsets.all(1.6.h),
                                      width: MediaQuery.of(context).size.width,
                                      color: AppColors.whiteColor,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            color: Colors.grey,
                                            height: 15.h, // Adjust height for placeholder image
                                            width: double.infinity,
                                          ),
                                          getVerticalSpace(.8.h),
                                          Container(
                                            color: Colors.grey,
                                            height: 2.h, // Adjust height for placeholder text
                                            width: double.infinity,
                                          ),
                                          getVerticalSpace(.5.h),
                                          Container(
                                            color: Colors.grey,
                                            height: 2.h, // Adjust height for placeholder text
                                            width: double.infinity,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                            else if (addCampaignController.pendingCampaigns.value!.campaigns.isEmpty) {
                              return Column(
                                children: [
                                  getVerticalSpace(20.h),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "No Pending ads",
                                      style: TextStyle(
                                        fontSize: 20.px,
                                        color: AppColors.mainColor,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'bold',
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return ListView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemCount: addCampaignController.pendingCampaigns.value!.campaigns.length,
                                itemBuilder: (context, index) {
                                  final campaign = addCampaignController.pendingCampaigns.value!.campaigns[index];
                                  return Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(() => CampaignName());
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(1.6.h),
                                          width: MediaQuery.of(context).size.width,
                                          color: AppColors.whiteColor,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              // Check if adBanner is null and handle accordingly
                                              campaign.adBanner.isNotEmpty
                                                  ? Image.network(campaign.adBanner)
                                                  : Container(
                                                color: Colors.grey,
                                                height: 15.h,
                                                width: double.infinity,
                                              ),
                                              getVerticalSpace(.8.h),
                                              // Check if adsName is null and handle accordingly
                                              Text(
                                                campaign.adsName,
                                                style: TextStyle(
                                                  fontSize: 14.px,
                                                  fontFamily: 'bold',
                                                  fontWeight: FontWeight.w500,
                                                  color: const Color(0xff191918),
                                                ),
                                              ),
                                              getVerticalSpace(.5.h),
                                              // Check if campaignDesc is null and handle accordingly
                                              Text(
                                                campaign.campaignDesc,
                                                style: TextStyle(
                                                  fontSize: 12.px,
                                                  fontFamily: 'bold',
                                                  fontWeight: FontWeight.w500,
                                                  color: const Color(0xff6E6E6D),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      getVerticalSpace(1.6.h),
                                      Container(
                                        padding: EdgeInsets.all(1.6.h),
                                        width: MediaQuery.of(context).size.width,
                                        color: AppColors.whiteColor,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            getVerticalSpace(.8.h),
                                            Text(
                                              campaign.adsName,
                                              style: TextStyle(
                                                fontSize: 14.px,
                                                fontFamily: 'bold',
                                                fontWeight: FontWeight.w500,
                                                color: const Color(0xff191918),
                                              ),
                                            ),
                                            getVerticalSpace(.5.h),
                                            Text(
                                              campaign.campaignDesc,
                                              style: TextStyle(
                                                fontSize: 12.px,
                                                fontFamily: 'bold',
                                                fontWeight: FontWeight.w500,
                                                color: const Color(0xff6E6E6D),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          }),
                          getVerticalSpace(10.h),

                        ],
                      )

                          :Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Upcoming ads',
                            style: TextStyle(
                              fontSize: 20.px,
                              color: const Color(0xff2F3542),
                              fontWeight: FontWeight.w500,
                              fontFamily: 'bold',
                            ),
                          ),
                          getVerticalSpace(1.3.h),
                          Row(
                            children: [
                              Text(
                                'Business name',
                                style: TextStyle(
                                  fontSize: 12.px,
                                  color: const Color(0xff454544),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'regular',
                                ),
                              ),
                              getHorizentalSpace(1.h),
                              const Expanded(
                                child: Divider(
                                  color: Color(0xff454544),
                                ),
                              ),
                            ],
                          ),
                          getVerticalSpace(1.h),
                          Obx(() {
                            if (addCampaignController.isLoading.value) {
                              return ListView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemCount: 3, // Show a fixed number of shimmer placeholders
                                itemBuilder: (context, index) {
                                  return Shimmer.fromColors(
                                    baseColor: AppColors.baseColor,
                                    highlightColor: AppColors.highlightColor,
                                    child: Container(
                                      padding: EdgeInsets.all(1.6.h),
                                      width: MediaQuery.of(context).size.width,
                                      color: AppColors.whiteColor,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            color: Colors.grey,
                                            height: 15.h, // Adjust height for placeholder image
                                            width: double.infinity,
                                          ),
                                          getVerticalSpace(.8.h),
                                          Container(
                                            color: Colors.grey,
                                            height: 2.h, // Adjust height for placeholder text
                                            width: double.infinity,
                                          ),
                                          getVerticalSpace(.5.h),
                                          Container(
                                            color: Colors.grey,
                                            height: 2.h, // Adjust height for placeholder text
                                            width: double.infinity,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else if (addCampaignController.upcomingCampaigns.value!.campaigns.isEmpty) {
                              return Column(
                                children: [
                                  getVerticalSpace(20.h),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "No Upcoming ads",
                                      style: TextStyle(
                                        fontSize: 20.px,
                                        color: AppColors.mainColor,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'bold',
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Expanded(
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: addCampaignController.upcomingCampaigns.value!.campaigns.length,
                                  itemBuilder: (context, index) {
                                    final campaign = addCampaignController.upcomingCampaigns.value!.campaigns[index];
                                    return Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Get.to(() => CampaignName());
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(1.6.h),
                                            width: MediaQuery.of(context).size.width,
                                            color: AppColors.whiteColor,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                // Check if adBanner is null and handle accordingly
                                                campaign.adBanner.isNotEmpty
                                                    ? Image.network(campaign.adBanner)
                                                    : Container(
                                                  color: Colors.grey,
                                                  height: 15.h,
                                                  width: double.infinity,
                                                ),
                                                getVerticalSpace(.8.h),
                                                // Check if adsName is null and handle accordingly
                                                Text(
                                                  campaign.adsName ,
                                                  style: TextStyle(
                                                    fontSize: 14.px,
                                                    fontFamily: 'bold',
                                                    fontWeight: FontWeight.w500,
                                                    color: const Color(0xff191918),
                                                  ),
                                                ),
                                                getVerticalSpace(.5.h),
                                                // Check if campaignDesc is null and handle accordingly
                                                Text(
                                                  campaign.campaignDesc ,
                                                  style: TextStyle(
                                                    fontSize: 12.px,
                                                    fontFamily: 'bold',
                                                    fontWeight: FontWeight.w500,
                                                    color: const Color(0xff6E6E6D),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        getVerticalSpace(1.6.h),
                                        Container(
                                          padding: EdgeInsets.all(1.6.h),
                                          width: MediaQuery.of(context).size.width,
                                          color: AppColors.whiteColor,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              getVerticalSpace(.8.h),
                                              Text(
                                                campaign.adsName ,
                                                style: TextStyle(
                                                  fontSize: 14.px,
                                                  fontFamily: 'bold',
                                                  fontWeight: FontWeight.w500,
                                                  color: const Color(0xff191918),
                                                ),
                                              ),
                                              getVerticalSpace(.5.h),
                                              Text(
                                                campaign.campaignDesc ,
                                                style: TextStyle(
                                                  fontSize: 12.px,
                                                  fontFamily: 'bold',
                                                  fontWeight: FontWeight.w500,
                                                  color: const Color(0xff6E6E6D),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        getVerticalSpace(10.h),

                                      ],
                                    );
                                  },
                                ),
                              );
                            }
                          }),
                        ],
                      )

                    ],
                  ),
                  getVerticalSpace(12.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
