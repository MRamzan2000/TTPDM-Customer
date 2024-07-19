import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm/controller/custom_widgets/widgets.dart';

class CurrentAdds extends StatelessWidget {
  const CurrentAdds({super.key});

  @override
  Widget build(BuildContext context) {
    RxList<Animation<Color?>> colorsList = <Animation<Color?>>[
      const AlwaysStoppedAnimation(Color(0xffB558F6)),
      const AlwaysStoppedAnimation(Color(0xff29CB97)),
      const AlwaysStoppedAnimation(Color(0xffFEC400)),
      const AlwaysStoppedAnimation(Color(0xff4072EE))
    ].obs;
    RxList<double> valuesList = <double>[63, 47, 52, 81].obs;

    final RxList tabBarItems =
        ['Previous ads', 'Current ads', 'Upcoming ads', 'Creative'].obs;
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Current ads',
                style: TextStyle(
                    fontSize: 20.px,
                    color: const Color(0xff2F3542),
                    fontWeight: FontWeight.w500,
                    fontFamily: 'bold'),
              ),
              Text(
                'View All',
                style: TextStyle(
                    fontSize: 14.px,
                    color: const Color(0xffFF7A2C),
                    fontWeight: FontWeight.w400,
                    fontFamily: 'bold'),
              )
            ],
          ),
          getVerticalSpace(1.2.h),
          SizedBox(
            height: 34.h,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: tabBarItems.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: .6.h),
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.h, vertical: 0.h),
                        decoration: const BoxDecoration(
                          color: Color(0xff00A3BF),
                        ),
                        child: Image.asset('assets/pngs/magic.png'),
                      ),
                    ),
                    getVerticalSpace(1.9.h),
                    Text(
                      'Experience your new JIRA',
                      style: CustomTextStyles.onBoardingHeading
                          .copyWith(fontSize: 16.px),
                    ),
                    getVerticalSpace(1.h),
                    Text(
                      'Experience your new JIRA',
                      style: CustomTextStyles.onBoardingHeading.copyWith(
                          fontSize: 14.px, color: const Color(0xff172B4D)),
                    ),
                    getVerticalSpace(1.7.h),
                  ],
                );
              },
            ),
          ),
          getVerticalSpace(2.h),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Current ads state',
                style: TextStyle(
                    fontSize: 14.px,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'bold',
                    color: const Color(0xff2F3542))),
          ),
          getVerticalSpace(1.1.h),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 2.h),
                          height: .90.h,
                          width: valuesList[index].h,
                          child: LinearProgressIndicator(
                            borderRadius: BorderRadius.circular(2.h),
                            color: const Color(0xff29CB97),
                            value: valuesList[index] / 100,
                            minHeight:
                            20, // Set a fixed height or use .h for responsive height
                            valueColor: colorsList[index],
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "${valuesList[index]}",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.px,
                              color: const Color(0xff31394D),
                              fontFamily: 'medium',
                            ),
                          ),
                          Text(
                            "%",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.px,
                              color: const Color(0xff31394D),
                              fontFamily: 'medium',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
