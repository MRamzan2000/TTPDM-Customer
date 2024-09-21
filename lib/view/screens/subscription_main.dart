import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm/controller/custom_widgets/widgets.dart';
import 'package:ttpdm/controller/extensions.dart';
import 'package:ttpdm/controller/getx_controllers/add_card_controller.dart';

import '../../controller/custom_widgets/app_colors.dart';
import '../../controller/custom_widgets/custom_text_styles.dart';

class Subscription extends StatefulWidget {
  final String token;
  const Subscription({super.key, required this.token});

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  final AddCardController addCardController = Get.put(AddCardController());

  String convertCentsToDollars({required int priceInCents}) {
    // Convert cents to dollars
    double priceInDollars = priceInCents / 100;

    // Format the dollar amount
    final currencyFormat = NumberFormat.currency(
      locale: 'en_US', // Adjust locale if needed
      symbol: '', // Currency symbol
    );

    return currencyFormat.format(priceInDollars);
  }

  @override
  Widget build(BuildContext context) {
    RxInt selectedIndex = 0.obs;

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

                Container(
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

  void openBottomSheet(
    BuildContext context,
  ) {
    Get.bottomSheet(
      SizedBox(
        height: 60.h,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.all(20.px),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  leading: const Image(
                      image: AssetImage('assets/pngs/addpayment.png')),
                  title: Text(
                    'Add card',
                    style: TextStyle(
                        fontSize: 16.px,
                        fontFamily: 'bold',
                        color: const Color(0xff292D32),
                        fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    'Streamline your checkout process by adding a new card for future transactions. Your card information is secured with advanced encryption technology.',
                    style: TextStyle(
                        fontSize: 12.px,
                        fontFamily: 'bold',
                        color: const Color(0xffA9ACB4),
                        fontWeight: FontWeight.w500),
                  ),
                ),
                getVerticalSpace(1.h),
                const Divider(
                  color: Color(0xffCBD0DC),
                ),
                getVerticalSpace(3.4.h),
                customTextFormField(
                    keyboardType: TextInputType.number,
                    title: '0000 0000 0000',
                    errorText: 'Card Number',
                    bgColor: Colors.transparent,
                    borderColor: const Color(0xffCBD0DC),
                    focusBorderColor: AppColors.mainColor,
                    prefix: '4966 |'),
                getVerticalSpace(3.2.h),
                Row(
                  children: [
                    Obx(
                      () => Expanded(
                        child: customTextFormField(
                          onTap: () {
                            addCardController.datePicker(context);
                          },
                          readOnly: true,
                          keyboardType: TextInputType.number,
                          title: addCardController.selectedDate.value
                              .format(pattern: 'yyyy-MM-dd'),
                          errorText: 'Expiry Date',
                          bgColor: Colors.transparent,
                          borderColor: const Color(0xffCBD0DC),
                          focusBorderColor: AppColors.mainColor,
                        ),
                      ),
                    ),
                    getHorizentalSpace(2.h),
                    Expanded(
                      child: customTextFormField(
                        keyboardType: TextInputType.number,
                        title: '•••',
                        errorText: 'CVV',
                        bgColor: Colors.transparent,
                        borderColor: const Color(0xffCBD0DC),
                        focusBorderColor: AppColors.mainColor,
                      ),
                    )
                  ],
                ),
                getVerticalSpace(3.2.h),
                customTextFormField(
                  keyboardType: TextInputType.number,
                  title: 'Enter cardholder’s full name',
                  errorText: 'Cardholder’s Name',
                  bgColor: Colors.transparent,
                  borderColor: const Color(0xffCBD0DC),
                  focusBorderColor: AppColors.mainColor,
                ),
                getVerticalSpace(3.6.h),
                customElevatedButton(
                    title: Text(
                      'Buy',
                      style: CustomTextStyles.buttonTextStyle
                          .copyWith(color: AppColors.whiteColor),
                    ),
                    onTap: () {
                      // Get.to(() => CampaignName());
                    },
                    bgColor: AppColors.mainColor,
                    titleColor: AppColors.whiteColor,
                    verticalPadding: .9.h,
                    horizentalPadding: 5.h),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
    );
  }
}
