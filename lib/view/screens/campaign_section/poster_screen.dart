import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ttpdm/controller/custom_widgets/widgets.dart';
import 'package:ttpdm/controller/getx_controllers/add_campaign_controller.dart';
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
  final RxList<String> imagesList = [
    'assets/pngs/mainposter.png',
    'assets/pngs/mainposter.png',
    'assets/pngs/mainposter.png'
  ].obs;
  final AddCampaignController addCampaignController = Get.put(AddCampaignController());
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    addCampaignController.fetchPosters(context: context,
    loading: addCampaignController.allPosters.isEmpty);
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
        final posters = addCampaignController.allPosters;
        final isLoading = addCampaignController.isLoading.value;

        // Determine the item count
        final itemCount = posters.isNotEmpty ? posters.length + 1 : 1;

        return Stack(
          children: [
            isLoading
                ? Shimmer.fromColors(
              highlightColor: AppColors.highlightColor,
              baseColor: AppColors.baseColor,
              child: PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.vertical,
                itemCount: imagesList.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(imagesList[index]),
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
                          children: List.generate(5, (i) => SizedBox(height: 6.h, width: 5.h)),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
                : PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              itemCount: itemCount,
              itemBuilder: (context, index) {
                if (index < posters.length) {
                  // Display the posters
                  final poster = posters[index];
                  final image = poster!.fileUrl.isNotEmpty
                      ? NetworkImage(poster.fileUrl)
                      : AssetImage(imagesList[index % imagesList.length]) as ImageProvider;

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
                                  selectedPoster:File(addCampaignController.allPosters[index]!.fileUrl),
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
                            SizedBox(
                              height: 6.h,
                              width: 5.h,
                              child: const Image(image: AssetImage('assets/pngs/like.png')),
                            ),
                            getVerticalSpace(.8.h),
                            SizedBox(
                              height: 6.h,
                              width: 5.h,
                              child: const Image(image: AssetImage('assets/pngs/dislike.png')),
                            ),
                            getVerticalSpace(.8.h),
                            GestureDetector(
                              onTap: () {
                                openCampaignPoster(context, widget.token);
                              },
                              child: SizedBox(
                                height: 6.h,
                                width: 5.h,
                                child: const Image(image: AssetImage('assets/pngs/edit.png')),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  // Display RequestMoreDesign
                  return const RequestMoreDesign();
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
