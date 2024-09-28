import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ttpdm/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm/controller/custom_widgets/widgets.dart';
import 'package:ttpdm/controller/getx_controllers/user_profile_controller.dart';
import 'package:ttpdm/controller/utils/alert_box.dart';
import 'package:ttpdm/controller/utils/my_shared_prefrence.dart';
import 'package:ttpdm/controller/utils/preference_key.dart';
import 'package:ttpdm/controller/utils/push_notification.dart';
import 'package:ttpdm/models/get_campaigns_by_status_model.dart';
import 'package:ttpdm/view/screens/campaign_section/campaign_name.dart';
import 'package:ttpdm/view/screens/notification_section/notification_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RxString token = "".obs;
  final TextEditingController _searchController = TextEditingController();
  final RxString _searchQuery = ''.obs;
  final RxInt selectedIndex = 0.obs;
  late UserProfileController userProfileController;

  @override
  void initState() {
    super.initState();
    userProfileController = Get.put(UserProfileController(context: context));
    token.value = MySharedPreferences.getString(authToken);
    String id = MySharedPreferences.getString(userIdKey);

    log("Auth Token :${token.value}");
    log("id :$id");
    _fetchCampaignsForCurrentTab();

    _searchController.addListener(() {
      _searchQuery.value = _searchController.text;
    });

    userProfileController.fetchUserProfile(loading: userProfileController.userProfile.value == null, id: id);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _fetchCampaignsForCurrentTab() {
    String status;
    switch (selectedIndex.value) {
      case 1:
        status = "approved";
        break;
      case 2:
        status = "rejected";
        break;
      case 0:
      default:
        status = "pending";
        break;
    }
    addCampaignController.fetchCampaignByStatus(
      context: context,
      status: status,
      isLoad: status == "pending"
          ? addCampaignController.pendingCampaigns.value == null
          : status == "approved"
              ? addCampaignController.approvedCampaigns.value == null
              : addCampaignController.rejectedCampaigns.value == null,
    );
  }

  final RxList<String> tabBarItems = [
    'Pending Ads',
    'Approved Ads',
    'Rejected Ads',
  ].obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f9fa),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'ADVYRO',
          style: CustomTextStyles.onBoardingHeading.copyWith(fontSize: 20.px),
        ),
        centerTitle: true,
        backgroundColor: AppColors.whiteColor,
        automaticallyImplyLeading: false,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Obx(
          () => SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                userProfileController.isLoading.value
                    ? Shimmer.fromColors(
                        highlightColor: AppColors.highlightColor,
                        baseColor: AppColors.baseColor,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: CircleAvatar(
                              radius: 2.8.h,
                            ),
                            title: const Text(
                              '',
                            ),
                            subtitle: const Text(
                              '',
                            ),
                            trailing: SizedBox(
                              height: 4.8.h,
                              width: 4.8.h,
                            ),
                          ),
                        ),
                      )
                    : userProfileController.userProfile.value == null
                        ? Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: CircleAvatar(
                                radius: 2.8.h,
                                backgroundImage: const AssetImage('assets/pngs/profile.png'),
                              ),
                              title: Text(
                                'Hello Mid Admin',
                                style: TextStyle(fontFamily: 'bold', fontWeight: FontWeight.w400, fontSize: 18.px, color: const Color(0xff2F3542)),
                              ),
                              subtitle: Text('Welcome Back',
                                  style:
                                      TextStyle(fontFamily: 'light', fontWeight: FontWeight.w400, fontSize: 12.px, color: const Color(0xff2F3542))),
                              trailing: GestureDetector(
                                onTap: () {
                                  Get.to(() => const NotiFicationScreen());
                                },
                                // child: SizedBox(
                                //     height: 4.8.h,
                                //     width: 4.8.h,
                                //     child: const Image(image: AssetImage("assets/pngs/notificationicon.png"))),
                              ),
                            ),
                          )
                        : Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: GestureDetector(
                                onTap: () {
                                  openChooseEditProfile(
                                    token: token.value,
                                    context,
                                    name: userProfileController.userProfile.value!.fullname,
                                    profileImage: "${userProfileController.userProfile.value!.profilePic}",
                                  );
                                },
                                child: userProfileController.userProfile.value!.profilePic != null
                                    ? CircleAvatar(radius: 2.8.h, backgroundImage: NetworkImage(userProfileController.userProfile.value!.profilePic))
                                    : CircleAvatar(
                                        radius: 2.8.h,
                                        backgroundImage: const AssetImage('assets/pngs/profile.png'),
                                      ),
                              ),
                              title: Text(
                                userProfileController.userProfile.value!.fullname,
                                style: TextStyle(fontFamily: 'bold', fontWeight: FontWeight.w400, fontSize: 18.px, color: const Color(0xff2F3542)),
                              ),
                              subtitle: Text('Welcome Back',
                                  style:
                                      TextStyle(fontFamily: 'light', fontWeight: FontWeight.w400, fontSize: 12.px, color: const Color(0xff2F3542))),
                              trailing: GestureDetector(
                                  onTap: () {
                                    Get.to(() => const NotiFicationScreen());
                                  },
                                  child: Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      SizedBox(
                                          height: 3.h,
                                          width: 3.h,
                                          child: Icon(
                                            Icons.notifications_none_sharp,
                                            color: AppColors.textFieldTextColor,
                                          )),
                                      isNotificationReceived.value
                                          ? Container(
                                              height: 1.h,
                                              width: 1.h,
                                              decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                                            )
                                          : const SizedBox.shrink()
                                    ],
                                  )),
                            ),
                          ),
                getVerticalSpace(1.h),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.h),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 10),
                        spreadRadius: 0,
                        blurRadius: 20,
                        color: const Color(0xff2F3542).withOpacity(0.1),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.h),
                        borderSide: BorderSide.none,
                      ),
                      isCollapsed: true,
                      filled: true,
                      fillColor: const Color(0xffFFFFFF),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 1.6.h,
                        vertical: 1.4.h,
                      ),
                      hintText: 'Search for ads...',
                      hintStyle: TextStyle(
                        fontSize: 12.px,
                        color: const Color(0xff2F3542),
                        fontWeight: FontWeight.w400,
                        fontFamily: 'bold',
                      ),
                      prefixIcon: Container(
                        height: 10,
                        width: 10,
                        alignment: Alignment.center,
                        child: svgImage(
                          'assets/svgs/search.svg',
                        ),
                      ),
                    ),
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
                          _fetchCampaignsForCurrentTab();
                        },
                        child: Obx(
                          () => Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(horizontal: 1.2.h),
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 1.h,
                            ),
                            decoration: BoxDecoration(
                              color: selectedIndex.value == index ? AppColors.mainColor : AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(10.h),
                              border: Border.all(
                                color: selectedIndex.value == index ? AppColors.mainColor : AppColors.whiteColor,
                              ),
                            ),
                            child: Text(
                              tabBarItems[index],
                              style: TextStyle(
                                color: selectedIndex.value == index ? AppColors.whiteColor : const Color(0xff454544),
                                fontFamily: 'bold',
                                fontWeight: FontWeight.w500,
                                fontSize: 12.px,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                getVerticalSpace(1.6.h),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${selectedIndex.value == 2 ? "Rejected" : selectedIndex.value == 0 ? "Pending" : "Approved"} Ads',
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
                            List<Campaign> filteredCampaigns = _filterCampaigns();

                            if (addCampaignController.isLoading.value) {
                              return ListView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemCount: 3,
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
                                            height: 15.h,
                                            width: double.infinity,
                                          ),
                                          getVerticalSpace(.8.h),
                                          Container(
                                            color: Colors.grey,
                                            height: 2.h,
                                            width: double.infinity,
                                          ),
                                          getVerticalSpace(.5.h),
                                          Container(
                                            color: Colors.grey,
                                            height: 2.h,
                                            width: double.infinity,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else if (filteredCampaigns.isEmpty) {
                              return Column(
                                children: [
                                  getVerticalSpace(20.h),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "No ${selectedIndex.value == 2 ? "Rejected" : selectedIndex.value == 0 ? "Pending" : "Approved"} Ads",
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
                              return SizedBox(
                                height: MediaQuery.of(context).size.height,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: filteredCampaigns.length,
                                        itemBuilder: (context, index) {
                                          final campaign = filteredCampaigns[index];
                                          return Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  if (selectedIndex.value == 1) {
                                                    Get.to(() => CampaignName(
                                                        businessId: campaign.business.id,
                                                        businessName: campaign.business.name,
                                                        campaignName: campaign.adsName,
                                                        campaignDescription: campaign.campaignDesc,
                                                        selectedPoster: campaign.adBanner,
                                                        campaignPlatForms: campaign.campaignPlatforms,
                                                        startDate: campaign.dateSchedule.startDate,
                                                        endDate: campaign.dateSchedule.endDate,
                                                        startTime: campaign.startTime,
                                                        endTime: campaign.endTime,
                                                        status: campaign.status,
                                                        analysis: campaign.analytics));
                                                  } else {
                                                    Get.to(() => CampaignName(
                                                          businessId: campaign.business.id,
                                                          businessName: campaign.business.name,
                                                          campaignName: campaign.adsName,
                                                          campaignDescription: campaign.campaignDesc,
                                                          selectedPoster: campaign.adBanner,
                                                          campaignPlatForms: campaign.campaignPlatforms,
                                                          startDate: campaign.dateSchedule.startDate,
                                                          endDate: campaign.dateSchedule.endDate,
                                                          startTime: campaign.startTime,
                                                          endTime: campaign.endTime,
                                                          status: campaign.status,
                                                          analysis: const [],
                                                        ));
                                                  }
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(bottom: 2.h),
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
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                    getVerticalSpace(53.h),
                                  ],
                                ),
                              );
                            }
                          }),
                        ],
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
  }

  List<Campaign> _filterCampaigns() {
    List<Campaign> campaigns;
    switch (selectedIndex.value) {
      case 1:
        campaigns = addCampaignController.approvedCampaigns.value?.campaigns ?? [];
        break;
      case 2:
        campaigns = addCampaignController.rejectedCampaigns.value?.campaigns ?? [];
        break;
      case 0:
      default:
        campaigns = addCampaignController.pendingCampaigns.value?.campaigns ?? [];
        break;
    }

    if (_searchQuery.isEmpty) {
      return campaigns;
    } else {
      return campaigns.where((campaign) => campaign.adsName.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
    }
  }
}
