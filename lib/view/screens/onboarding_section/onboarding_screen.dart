import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm/view/screens/auth_section/register_screen.dart';

import '../../../controller/custom_widgets/widgets.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RxInt firstPage = 0.obs;
    final pageController = PageController(
      initialPage: firstPage.value,
      keepPage: true,
    );
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Obx(
          () => Stack(
            children: [
              Positioned(
                bottom: 40.h,
                left: 22.h,
                right: 19.9.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 1.3.h,
                      width: 1.3.h,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: firstPage.value == 0
                              ? AppColors.mainColor
                              : Colors.transparent,
                          border: Border.all(
                              color: firstPage.value == 0
                                  ? Colors.transparent
                                  : Colors.black)),
                    ),
                    getHorizentalSpace(.6.h),
                    Container(
                      height: 1.3.h,
                      width: 1.3.h,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: firstPage.value == 1
                              ? AppColors.mainColor
                              : Colors.transparent,
                          border: Border.all(
                              color: firstPage.value == 1
                                  ? Colors.transparent
                                  : Colors.black)),
                    ),
                    getHorizentalSpace(.6.h),
                    Container(
                      height: 1.3.h,
                      width: 1.3.h,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: firstPage.value == 2
                              ? AppColors.mainColor
                              : Colors.transparent,
                          border: Border.all(
                              color: firstPage.value == 2
                                  ? Colors.transparent
                                  : Colors.black)),
                    )
                  ],
                ),
              ),
              PageView(
                controller: pageController,
                onPageChanged: (value) {
                  firstPage.value = value;
                },
                scrollDirection: Axis.horizontal,
                reverse: false,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.0.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        getVerticalSpace(8.5.h),
                        svgImage('assets/svgs/welcomescreenicon.svg'),
                        getVerticalSpace(10.9.h),
                        Text(
                          'Let’s help you market your work ',
                          textAlign: TextAlign.center,
                          style: CustomTextStyles.onBoardingHeading,
                        ),
                        getVerticalSpace(2.1.h),
                        Text(
                          'Remember to keep track of your professional accomplishments.',
                          textAlign: TextAlign.center,
                          style: CustomTextStyles.onBoardingLight,
                        ),
                        const Expanded(child: SizedBox()),
                        getVerticalSpace(5.2.h)
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.0.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        getVerticalSpace(8.5.h),
                        svgImage('assets/svgs/onboard2.svg'),
                        getVerticalSpace(12.9.h),
                        Text(
                          'With our ads schedule feature',
                          textAlign: TextAlign.center,
                          style: CustomTextStyles.onBoardingHeading,
                        ),
                        getVerticalSpace(2.1.h),
                        Text(
                          'But understanding the contributions our colleagues make to our teams and companies',
                          textAlign: TextAlign.center,
                          style: CustomTextStyles.onBoardingLight,
                        ),
                        const Expanded(child: SizedBox()),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.0.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        getVerticalSpace(8.5.h),
                        svgImage('assets/svgs/onboard3.svg'),
                        getVerticalSpace(10.9.h),
                        Text(
                          'Customized ads management',
                          textAlign: TextAlign.center,
                          style: CustomTextStyles.onBoardingHeading,
                        ),
                        getVerticalSpace(2.1.h),
                        Text(
                          'Take control of notifications, collaborate live or on your own time',
                          textAlign: TextAlign.center,
                          style: CustomTextStyles.onBoardingLight,
                        ),
                        const Expanded(child: SizedBox()),
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                bottom: 5.2.h,
                left: 8.1.h,
                right: 6.h,
                child: firstPage.value == 2
                    ? customElevatedButton(
                        title:Text(
                          'Start',
                          style: CustomTextStyles.buttonTextStyle.copyWith(color:AppColors.whiteColor ),
                        ),
                        onTap: () {
                          Get.to(()=> RegisterScreen());

                        },
                        bgColor: AppColors.mainColor,
                        verticalPadding: 1.5.h,
                        horizentalPadding: 0.h)
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(onTap: (){
                            Get.to(()=> RegisterScreen());
                          },
                            child: Text(
                              'SKIP',
                              style: CustomTextStyles.buttonTextStyle.copyWith(
                                  color: AppColors.blackColor,
                                  fontFamily: 'bold'),
                            ),
                          ),
                          customElevatedButton(
                              title: Text(
                                'NEXT',
                                style: CustomTextStyles.buttonTextStyle.copyWith(color:AppColors.whiteColor ),
                              ),
                              onTap: () {
                                if (firstPage.value < 2) {
                                  pageController.animateToPage(
                                      firstPage.value + 1,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut);
                                }
                              },
                              bgColor: AppColors.mainColor,
                              verticalPadding: 2.h,
                              horizentalPadding: 0.h),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
