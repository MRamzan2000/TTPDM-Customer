import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm/view/screens/auth_section/login_screen.dart';

import '../../../controller/custom_widgets/widgets.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RxInt firstPage = 0.obs;

    return Scaffold(
      backgroundColor: const Color(0xfff8f9fa),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Obx(
            () => Column(
              children: [
                getVerticalSpace(5.h),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 20.h,
                    width: 40.h,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: svgImage(firstPage.value == 0
                          ? 'assets/svgs/welcomescreenicon.svg'
                          : firstPage.value == 1
                              ? 'assets/svgs/onboard2.svg'
                              : 'assets/svgs/onboard3.svg'),
                    ),
                  ),
                ),
                getVerticalSpace(8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 0.4.h),
                      height: 1.3.h,
                      width: 1.3.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: firstPage.value == index
                            ? AppColors.mainColor
                            : Colors.transparent,
                        border: Border.all(
                          color: firstPage.value == index
                              ? Colors.transparent
                              : Colors.black,
                        ),
                      ),
                    );
                  }),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      getVerticalSpace(2.9.h),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6.h),
                            child: Text(
                              firstPage.value == 0
                                  ? 'Let’s help you market your work '
                                  : firstPage.value == 1
                                      ? "With our ads schedule feature"
                                      : "Customized ads management",
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.onBoardingHeading,
                            ),
                          ),
                          getVerticalSpace(2.1.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.h),
                            child: Text(
                              firstPage.value == 0
                                  ? "Remember to keep track of your professional accomplishments."
                                  : firstPage.value == 0
                                      ? "But understanding the contributions our colleagues make to our teams and companies"
                                      : 'Take control of notifications, collaborate live or on your own time',
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.onBoardingLight,
                            ),
                          ),
                        ],
                      ),
                      const Expanded(child: SizedBox()),
                      Padding(
                        padding: EdgeInsets.only(left: 8.3.h,right: 6.h),
                        child: firstPage.value == 2
                            ? customElevatedButton(
                                title: Text(
                                  'Start',
                                  style: CustomTextStyles.buttonTextStyle
                                      .copyWith(color: AppColors.whiteColor),
                                ),
                                onTap: () {
                                  Get.to(() => const LoginScreen());
                                },
                                bgColor: AppColors.mainColor,
                                verticalPadding: 1.5.h,
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(() => const LoginScreen());
                                    },
                                    child: Text(
                                      'SKIP',
                                      style: CustomTextStyles.buttonTextStyle
                                          .copyWith(
                                              color: AppColors.blackColor,
                                              fontFamily: 'bold'),
                                    ),
                                  ),
                                  customElevatedButton(
                                    title: Text(
                                      'NEXT',
                                      style: CustomTextStyles.buttonTextStyle
                                          .copyWith(
                                              color: AppColors.whiteColor),
                                    ),
                                    onTap: () {
                                      if (firstPage.value < 2) {
                                        firstPage.value++;
                                      } else {
                                        firstPage.value--;
                                      }
                                    },
                                    bgColor: AppColors.mainColor,
                                    verticalPadding: 2.h,
                                    horizentalPadding: 0.h,
                                  ),
                                ],
                              ),
                      )
                    ],
                  ),
                ),
                getVerticalSpace(3.h)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
