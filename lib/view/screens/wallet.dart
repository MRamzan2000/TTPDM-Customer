import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm/controller/custom_widgets/widgets.dart';
import 'package:ttpdm/controller/utils/alert_box.dart';

import '../../controller/custom_widgets/app_colors.dart';
import '../../controller/custom_widgets/custom_text_styles.dart';

class Subscription extends StatefulWidget {
  final String token;
  const Subscription({super.key, required this.token});

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {

  String convertCentsToDollars({required int priceInCents}) {
    double priceInDollars = priceInCents / 100;
    final currencyFormat = NumberFormat.currency(
      locale: 'en_US',
      symbol: '',
    );
    return currencyFormat.format(priceInDollars);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wallet',
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
            padding: EdgeInsets.symmetric(horizontal: 2.5.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getVerticalSpace(2.4.h),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(1.5.h)),
                  child: Column(
                    children: [
                      Text(
                        "Total Balance",
                        style: CustomTextStyles.onBoardingHeading.copyWith(
                            fontSize: 18.px,
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w500),
                      ),
                      getVerticalSpace(.6.h),
                      Text(
                        "\$23.0",
                        style: CustomTextStyles.onBoardingHeading.copyWith(
                            fontSize: 18.px,
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                getVerticalSpace(1.2.h),

                GestureDetector(
                  onTap: () {
                    withdrawRequest(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 2.7.h),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(1.5.h)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/svgs/withdraw.svg"),
                        getHorizentalSpace(.6.h),
                        Text(
                          "Withdraw Request",
                          style: CustomTextStyles.onBoardingHeading.copyWith(
                              fontSize: 16.px,
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                getVerticalSpace(2.h),
                Text(
                  "Withdraw",
                  style: CustomTextStyles.buttonTextStyle
                      .copyWith(color: AppColors.mainColor),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            "Withdraw Request",
                            style: CustomTextStyles.buttonTextStyle.copyWith(
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.px),
                          ),
                          subtitle: Text(
                            "10:00 am , 12 jul 2023",
                            style: CustomTextStyles.buttonTextStyle.copyWith(
                                color: AppColors.blackColor, fontSize: 12.px),
                          ),
                          trailing: Text(
                            "-\$23.0",
                            style: CustomTextStyles.buttonTextStyle.copyWith(
                                color: AppColors.mainColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.px),
                          ),
                        ),
                        Divider(
                          color: AppColors.textFieldGreyColor,
                        )
                      ],
                    );
                  },
                ),
                Text(
                  "History",
                  style: CustomTextStyles.buttonTextStyle
                      .copyWith(color: AppColors.mainColor),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            index==0?"Payment ":"Withdraw",
                            style: CustomTextStyles.buttonTextStyle.copyWith(
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.px),
                          ),
                          subtitle: Text(
                            "10:00 am , 12 jul 2023",
                            style: CustomTextStyles.buttonTextStyle.copyWith(
                                color: AppColors.blackColor, fontSize: 12.px),
                          ),
                          trailing: Text(
                            "-\$23.0",
                            style: CustomTextStyles.buttonTextStyle.copyWith(
                                color: AppColors.mainColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.px),
                          ),
                        ),
                        Divider(
                          color: AppColors.textFieldGreyColor,
                        )
                      ],
                    );
                  },
                )
              ],
            )),
      ),
    );
  }

}
