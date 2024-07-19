import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm/controller/custom_widgets/widgets.dart';
import 'package:ttpdm/view/screens/campaign_section/campaign_name.dart';
import 'package:ttpdm/view/screens/notification_section/notification_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RxInt selectedIndex = 0.obs;
    final RxList tabBarItems = [
      'Previous ads',
      'Pending',
          'Current ads',
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
                              },
                              child: Obx(
                                () => Container(
                                  alignment: Alignment.center,
                                  margin: index == 0 || index == 2
                                      ? EdgeInsets.zero
                                      : EdgeInsets.symmetric(horizontal: .6.h),
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
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Previous ads',
                                  style: TextStyle(
                                      fontSize: 20.px,
                                      color: const Color(0xff2F3542),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'bold'),
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
                                          fontFamily: 'regular'),
                                    ),
                                    getHorizentalSpace(1.h),
                                    const Expanded(
                                      child: Divider(
                                        color: Color(0xff454544),
                                      ),
                                    )
                                  ],
                                ),
                                getVerticalSpace(1.h),
                                GestureDetector(onTap: (){
                                  Get.to(()=> CampaignName());

                                },
                                  child: Container(
                                    padding: EdgeInsets.all(1.6.h),
                                    width: MediaQuery.of(context).size.width,
                                    color: AppColors.whiteColor,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Image.asset('assets/pngs/addsimage.png'),
                                        getVerticalSpace(.8.h),
                                        Text(
                                          'Ads Name',
                                          style: TextStyle(
                                              fontSize: 14.px,
                                              fontFamily: 'bold',
                                              fontWeight: FontWeight.w500,
                                              color: const Color(0xff191918)),
                                        ),
                                        getVerticalSpace(.5.h),
                                        Text(
                                          'Lorem ipsum dolor sit amet, consectetur adipiing elit...',
                                          style: TextStyle(
                                              fontSize: 12.px,
                                              fontFamily: 'bold',
                                              fontWeight: FontWeight.w500,
                                              color: const Color(0xff6E6E6D)),
                                        )
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      getVerticalSpace(.8.h),
                                      Text(
                                        'Ads Name',
                                        style: TextStyle(
                                            fontSize: 14.px,
                                            fontFamily: 'bold',
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xff191918)),
                                      ),
                                      getVerticalSpace(.5.h),
                                      Text(
                                        'Lorem ipsum dolor sit amet, consectetur adipiscg elit...',
                                        style: TextStyle(
                                            fontSize: 12.px,
                                            fontFamily: 'bold',
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xff6E6E6D)),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Current ads',
                                  style: TextStyle(
                                      fontSize: 20.px,
                                      color: const Color(0xff2F3542),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'bold'),
                                ),
                                getVerticalSpace(.8.h),
                                Container(
                                  padding: EdgeInsets.all(1.6.h),
                                  width: MediaQuery.of(context).size.width,
                                  color: AppColors.whiteColor,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset('assets/pngs/addsimage.png'),
                                      getVerticalSpace(.8.h),
                                      Text(
                                        'Ads Name',
                                        style: TextStyle(
                                            fontSize: 14.px,
                                            fontFamily: 'bold',
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xff191918)),
                                      ),
                                      getVerticalSpace(.5.h),
                                      Text(
                                        'Lorem ipsum dolor sit amet, consectetur adipiing elit...',
                                        style: TextStyle(
                                            fontSize: 12.px,
                                            fontFamily: 'bold',
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xff6E6E6D)),
                                      )
                                    ],
                                  ),
                                ),
                                getVerticalSpace(1.6.h),
                                Container(
                                  padding: EdgeInsets.all(1.6.h),
                                  width: MediaQuery.of(context).size.width,
                                  color: AppColors.whiteColor,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      getVerticalSpace(.8.h),
                                      Text(
                                        'Ads Name',
                                        style: TextStyle(
                                            fontSize: 14.px,
                                            fontFamily: 'bold',
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xff191918)),
                                      ),
                                      getVerticalSpace(.5.h),
                                      Text(
                                        'Lorem ipsum dolor sit amet, consectetur adipiscg elit...',
                                        style: TextStyle(
                                            fontSize: 12.px,
                                            fontFamily: 'bold',
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xff6E6E6D)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
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
