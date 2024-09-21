import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ttpdm/controller/custom_widgets/widgets.dart';
import 'package:ttpdm/controller/getx_controllers/add_campaign_controller.dart';
import 'package:ttpdm/controller/getx_controllers/get_fcm_token_send_notification_controller.dart';
import 'package:ttpdm/controller/getx_controllers/poster_controller.dart';
import 'package:ttpdm/controller/utils/my_shared_prefrence.dart';
import 'package:ttpdm/controller/utils/preference_key.dart';
import 'package:ttpdm/view/screens/campaign_section/add_campaign_duration.dart';

import '../../../controller/custom_widgets/app_colors.dart';
import '../../../controller/custom_widgets/custom_text_styles.dart';
import '../../../controller/utils/alert_box.dart';
import 'request_more_design.dart';

class PosterScreen extends StatefulWidget {
  final String businessId;
  final String businessName;
  final String campaignName;
  final String campaignDescription;
  final String token;

  const PosterScreen({
    super.key,
    required this.businessId,
    required this.campaignName,
    required this.campaignDescription,
    required this.businessName,
    required this.token,
  });

  @override
  State<PosterScreen> createState() => _PosterScreenState();
}

class _PosterScreenState extends State<PosterScreen> {
  RxBool isLike = false.obs;
  RxBool disLike = false.obs;

  void handleLikePoster({
    required String designId,
    required String token,
  }) async {
    await posterController.likeCampaignPoster(designId: designId, token: token);
    posterController.fetchPosters(
        context: context, loading: false);
  }
  void handleDisLikePoster({
    required String designId,
    required String token,
  }) async {
    await posterController.dislikeCampaignPoster(designId: designId, token: token);
    posterController.fetchPosters(
        context: context, loading: false);
  }
  final RxString id = "".obs;
  final RxString name = "".obs;
  final AddCampaignController addCampaignController = Get.put(AddCampaignController());
  late PosterController posterController;
  final PageController _pageController = PageController();
  late GetFcmTokenSendNotificationController getFcmTokenSendNotificationController;
  final RxList<String> imagesList = [
    'assets/pngs/mainposter.png',
    'assets/pngs/mainposter.png',
    'assets/pngs/mainposter.png'
  ].obs;
  @override
  void initState() {
    super.initState();
    posterController = Get.put(PosterController(context: context));
    getFcmTokenSendNotificationController = Get.put(GetFcmTokenSendNotificationController(context: context));
    id.value = MySharedPreferences.getString(userId);
    name.value = MySharedPreferences.getString(userName);
    posterController.fetchPosters(
        context: context, loading: posterController.allPosters.value == null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Add Campaign',
          style: CustomTextStyles.buttonTextStyle.copyWith(
              fontSize: 20.px,
              fontWeight: FontWeight.w600,
              color: AppColors.mainColor),
        ),
      ),
      body: Obx(() {
        final posters = posterController.allPosters.value;
        final isLoading = posterController.isLoading.value;

        final itemCount = (posters?.designs.length ?? 0) + 1;

        return Stack(
          children: [
            isLoading
                ? Shimmer.fromColors(
              highlightColor: AppColors.highlightColor,
              baseColor: AppColors.baseColor,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: AppColors.baseColor,
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 1.h, bottom: 2.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: List.generate(
                          5, (i) => SizedBox(height: 6.h, width: 5.h)),
                    ),
                  ),
                ),
              ),
            )
                : PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              itemCount: itemCount,
              itemBuilder: (context, index) {
                if (index < (posters?.designs.length ?? 0))
                {
                  final poster = posters!.designs[index];
                  final image = poster.fileUrl.isNotEmpty
                      ? NetworkImage(poster.fileUrl)
                      : AssetImage(imagesList[index % imagesList.length]) as ImageProvider;

                  // Check if the current user has liked or disliked the poster
                  final hasLiked = poster.likes
                      .any((user) => user.id == id.value);
                  final hasDisliked = poster.likes
                      .any((user) => user.id == id.value);
                  isLike.value = hasLiked;
                  disLike.value = !hasDisliked;
                  log("Like.value  ${isLike.value}");
                  log("disLike.value  ${  disLike.value}");
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 1.h, bottom: 2.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.to(() => AddCampaignDuration(
                                  businessId: widget.businessId,
                                  campaignDescription: widget.campaignDescription,
                                  campaignName: widget.campaignName,
                                  selectedPoster: File(poster.fileUrl),
                                  businessName: widget.businessName,
                                  token: widget.token,
                                ));
                              },
                              child: SizedBox(
                                height: 6.h,
                                width: 5.h,
                                child: const Image(image: AssetImage('assets/pngs/select.png')),
                              ),
                            ),
                            getVerticalSpace(.8.h),
                            GestureDetector(
                              onTap: () {

                                  isLike.value = !isLike.value;
                                  disLike.value = false;
                                  handleLikePoster(designId: poster.id, token: widget.token);
                                posterController.allPosters.refresh();
                              },
                              child: SizedBox(
                                height: 6.h,
                                width: 5.h,
                                child: Image(
                                  image: const AssetImage('assets/pngs/like.png'),
                                  color: isLike.value ? AppColors.mainColor : Colors.white,
                                ),
                              ),
                            ),
                            getVerticalSpace(.8.h),
                            GestureDetector(
                              onTap: () {

                                  disLike.value = !disLike.value;
                                  isLike.value = false;
                                  handleDisLikePoster(designId: poster.id, token: widget.token);
                               posterController.allPosters.refresh();
                              },
                              child: SizedBox(
                                height: 6.h,
                                width: 5.h,
                                child: Image(
                                  image: const AssetImage('assets/pngs/dislike.png'),
                                  color: disLike.value ? AppColors.mainColor : Colors.white,
                                ),
                              ),
                            ),
                            getVerticalSpace(.8.h),
                            GestureDetector(
                              onTap: () {
                                openCampaignPoster(
                                  context,
                                  token: widget.token,
                                  businessId: widget.businessId,
                                  posterId: poster.uploadedBy.id,
                                  currentUserId: id.value,
                                  currentUserName: name.value,
                                );
                              },
                              child:SizedBox(
                                height: 6.h,
                                width: 5.h,
                                child: Image(
                                  image: const AssetImage("assets/pngs/edit.png"),
                                  color: disLike.value ? AppColors.mainColor : Colors.white,
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return  RequestMoreDesign(
                    businessId: widget.businessId, posterId: posterController.allPosters.value!.designs[0].uploadedBy.id,

                  );
                }
              },
            ),
            Positioned(
              top: 2.h,
              right: 1,
              left: 1.5.h,
              child: SizedBox(
                height: .6.h,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 1.h),
                      width: MediaQuery.of(context).size.width / 5.2 - 2.4.h,
                      height: .4.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1.h),
                        color: index == 0 || index == 1 || index == 2
                            ? AppColors.mainColor
                            : const Color(0xffC3C3C2),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
