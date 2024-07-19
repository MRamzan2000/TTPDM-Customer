import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm/controller/custom_widgets/widgets.dart';

import 'fill_add_detail.dart';

class AddNewCampaign extends StatelessWidget {
  AddNewCampaign({super.key});
  final RxList<String> titles = <String>[
    'Business Profile One',
    'Business Profile Two',
    'Business Profile Three'
  ].obs;
  final RxInt selectedIndex = 0.obs;
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
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.4.h),
          child: Obx(
            () => Column(
              children: [
                getVerticalSpace(2.4.h),
                SizedBox(
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
                        width: MediaQuery.of(context).size.width / 5.2 -
                            2.4.h,
                        height: .4.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1.h),
                            color: index == 0
                                ? AppColors.mainColor
                                : const Color(0xffC3C3C2)),
                      );
                    },
                  ),
                ),
                getVerticalSpace(2.4.h),
                Text(
                  'Select business for campaign',
                  style: CustomTextStyles.buttonTextStyle.copyWith(
                      fontSize: 14.px,
                      fontWeight: FontWeight.w600,
                      color: AppColors.blackColor),
                ),
                getVerticalSpace(2.1.h),
                ListView.builder(
                  itemCount: titles.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        selectedIndex.value = index;
                      },
                      child: Obx(
                        () => Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 1.6.h, vertical: 2.h),
                          margin: EdgeInsets.symmetric(vertical: 1.6.h),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1.h),
                              color: AppColors.whiteColor),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Text(titles[index]),
                              Container(
                                padding: EdgeInsets.all(.3.h),
                                height: 2.4.h,
                                width: 2.4.h,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.transparent,
                                    border: Border.all(
                                        color:
                                            selectedIndex.value == index
                                                ? AppColors.mainColor
                                                : const Color(0xff7C7C7C),
                                        width: 2)),
                                child: CircleAvatar(
                                  backgroundColor:
                                      selectedIndex.value == index
                                          ? AppColors.mainColor
                                          : Colors.transparent,
                                  radius: 1.h,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const Spacer(),
                customElevatedButton(
                    onTap: () {
                      Get.to(() => const FillAddDetails());
                    },
                    title: 'Next',
                    horizentalPadding: 5.h,
                    verticalPadding: .8.h,
                    bgColor: AppColors.mainColor,
                    titleColor: AppColors.whiteColor),
                getVerticalSpace(6.4.h)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
