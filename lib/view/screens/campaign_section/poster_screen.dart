import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ttpdm/controller/custom_widgets/widgets.dart';
import 'package:ttpdm/controller/getx_controllers/poster_controller.dart';
import 'package:ttpdm/controller/utils/alert_box.dart';
import 'package:ttpdm/controller/utils/my_shared_prefrence.dart';
import 'package:ttpdm/controller/utils/preference_key.dart';
import 'package:ttpdm/view/screens/campaign_section/add_campaign_duration.dart';
import '../../../controller/custom_widgets/app_colors.dart';
import '../../../controller/custom_widgets/custom_text_styles.dart';
import 'fill_add_detail.dart';
import 'request_more_design.dart';

class PosterScreen extends StatefulWidget {
  final String businessId;
  final String businessName;
  final String token;

  const PosterScreen({
    super.key,
    required this.businessId,
    required this.businessName,
    required this.token,
  });

  @override
  State<PosterScreen> createState() => _PosterScreenState();
}

class _PosterScreenState extends State<PosterScreen> {
  final RxString id = "".obs;
  final RxString name = "".obs;
  late PosterController posterController;
  final PageController _pageController = PageController();

  final RxMap<String, bool> likedPosters = <String, bool>{}.obs;
  final RxMap<String, bool> dislikedPosters = <String, bool>{}.obs;

  @override
  void initState() {
    super.initState();
    posterController = Get.put(PosterController(context: context));
    id.value = MySharedPreferences.getString(userIdKey);
    name.value = MySharedPreferences.getString(userNameKey);
    posterController.fetchPosters(
      context: context,
      loading: posterController.allPosters.value == null,
      businessId: widget.businessId,
    );
  }

  void handleLikePoster(String designId) async {
    await posterController.likeCampaignPoster(designId: designId, token: widget.token);
    likedPosters[designId] = true;
    dislikedPosters[designId] = false;
    posterController.fetchPosters(context: context, loading: false, businessId: widget.businessId);
  }

  void handleDisLikePoster(String designId) async {
    await posterController.dislikeCampaignPoster(designId: designId, token: widget.token);
    dislikedPosters[designId] = true;
    likedPosters[designId] = false;
    posterController.fetchPosters(context: context, loading: false, businessId: widget.businessId);
  }

  @override
  Widget build(BuildContext context) {
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
          'Add Campaign',
          style: CustomTextStyles.buttonTextStyle.copyWith(
            fontSize: 20.px,
            fontWeight: FontWeight.w600,
            color: AppColors.mainColor,
          ),
        ),
      ),
      body: Obx(() {
        final posters = posterController.allPosters.value;
        final isLoading = posterController.isLoading.value;
        final filteredPosters = posters?.designs ?? [];
        final itemCount = filteredPosters.length;

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
                            children: List.generate(5, (i) => SizedBox(height: 6.h, width: 5.h)),
                          ),
                        ),
                      ),
                    ),
                  )
                : PageView.builder(
                    controller: _pageController,
                    scrollDirection: Axis.vertical,
                    itemCount: itemCount + 1, // Plus one for "Request More" screen
                    itemBuilder: (context, index) {
                      if (index < itemCount) {
                        final poster = filteredPosters[index];
                        final image = poster.fileUrl.isNotEmpty
                            ? NetworkImage(poster.fileUrl)
                            : const AssetImage('assets/pngs/mainposter.png') as ImageProvider;

                        final hasLiked = poster.likes.any((like) => like['_id'] == id.value);
                        final hasDisliked = poster.dislikes.any((like) => like['_id'] == id.value);

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
                                      Get.to(() => FillAddDetails(
                                            businessId: widget.businessId,
                                            businessName: widget.businessName,
                                            selectedPoster: File(poster.fileUrl),
                                            token: widget.token,
                                          ));
                                    },
                                    child: SizedBox(
                                      height: 7.h,
                                      width: 6.h,
                                      child: const Image(image: AssetImage('assets/pngs/select.png')),
                                    ),
                                  ),
                                  getVerticalSpace(.8.h),
                                  GestureDetector(
                                    onTap: () {
                                      likedPosters[poster.id] = true;
                                      dislikedPosters[poster.id] = false;
                                      handleLikePoster(poster.id);
                                    },
                                    child: SizedBox(
                                      height: 7.h,
                                      width: 6.h,
                                      child: Image(
                                        image: const AssetImage('assets/pngs/like.png'),
                                        color: hasLiked ? AppColors.mainColor : null,
                                      ),
                                    ),
                                  ),
                                  getVerticalSpace(.8.h),
                                  GestureDetector(
                                    onTap: () {
                                      dislikedPosters[poster.id] = true;
                                      likedPosters[poster.id] = false;
                                      handleDisLikePoster(poster.id);
                                    },
                                    child: SizedBox(
                                      height: 7.h,
                                      width: 6.h,
                                      child: Image(
                                        image: const AssetImage('assets/pngs/dislike.png'),
                                        color: hasDisliked ? AppColors.mainColor : null,
                                      ),
                                    ),
                                  ),
                                  getVerticalSpace(.8.h),
                                  GestureDetector(
                                    onTap: () {
                                      openCampaignPosterEdit(
                                        context,
                                        token: widget.token,
                                        businessId: widget.businessId,
                                        posterId: poster.id,
                                        currentUserId: id.value,
                                        currentUserName: name.value,
                                        ownerId: poster.uploadedBy.id,
                                      );
                                    },
                                    child: SizedBox(
                                      height: 7.h,
                                      width: 6.h,
                                      child: const Image(image: AssetImage("assets/pngs/edit.png")),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      } else {
                        // Last item to show "Request More Design"
                        return RequestMoreDesign(
                          businessId: widget.businessId,
                          postId: "", // You can customize this as needed
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
                        color: index == 0 || index == 1 ? AppColors.mainColor : const Color(0xffC3C3C2),
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
