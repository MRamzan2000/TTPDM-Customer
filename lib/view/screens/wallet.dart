import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ttpdm/controller/custom_widgets/widgets.dart';
import 'package:ttpdm/controller/getx_controllers/wallet_controller.dart';
import 'package:ttpdm/controller/utils/alert_box.dart';
import 'package:ttpdm/models/wallet_details_model.dart';

import '../../controller/custom_widgets/app_colors.dart';
import '../../controller/custom_widgets/custom_text_styles.dart';
import '../../controller/extensions.dart';
import '../../controller/getx_controllers/user_profile_controller.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  late WalletController walletController;

  @override
  void initState() {
    walletController = Get.put(WalletController(context: context));
    walletController.getWalletDetails(context: context, loading: walletController.walletDetails.value == null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: const Color(0xfff8f9fa),
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
                  walletController.isLoading.value
                      ? Shimmer.fromColors(
                          baseColor: AppColors.baseColor,
                          highlightColor: AppColors.highlightColor,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 5.h),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(color: AppColors.mainColor, borderRadius: BorderRadius.circular(1.5.h)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  color: Colors.grey,
                                  height: 65.px,
                                  width: double.infinity,
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.symmetric(vertical: 5.h),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(color: AppColors.mainColor, borderRadius: BorderRadius.circular(1.5.h)),
                          child: Column(
                            children: [
                              Text(
                                "Total Balance",
                                style: CustomTextStyles.onBoardingHeading
                                    .copyWith(fontSize: 18.px, color: AppColors.whiteColor, fontWeight: FontWeight.w500),
                              ),
                              getVerticalSpace(.6.h),
                              Text(
                                "\$${walletController.walletDetails.value!.balance.toString()}",
                                style: CustomTextStyles.onBoardingHeading
                                    .copyWith(fontSize: 24.px, color: AppColors.whiteColor, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                  getVerticalSpace(1.2.h),
                  walletController.isLoading.value
                      ? Shimmer.fromColors(
                          baseColor: AppColors.baseColor,
                          highlightColor: AppColors.highlightColor,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 2.7.h),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(color: AppColors.mainColor, borderRadius: BorderRadius.circular(1.5.h)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  color: Colors.grey,
                                  height: 30.px,
                                  width: double.infinity,
                                ),
                              ],
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () async {
                            await withdrawRequest(context, walletController.walletDetails.value!.balance).then((value) {
                              if(value)
                                {
                                  walletController.getWalletDetails(context: context, loading: true);
                                }
                            },);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 2.7.h),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(color: AppColors.mainColor, borderRadius: BorderRadius.circular(1.5.h)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset("assets/svgs/withdraw.svg"),
                                getHorizentalSpace(.6.h),
                                Text(
                                  "Withdraw Request",
                                  style: CustomTextStyles.onBoardingHeading
                                      .copyWith(fontSize: 16.px, color: AppColors.whiteColor, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                  getVerticalSpace(2.h),
                  walletController.isLoading.value
                      ? Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Shimmer.fromColors(
                                    baseColor: AppColors.baseColor,
                                    highlightColor: AppColors.highlightColor,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 5.h),
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(color: AppColors.mainColor, borderRadius: BorderRadius.circular(1.5.h)),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            color: Colors.grey,
                                            height: 20.px,
                                            width: double.infinity,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: AppColors.textFieldGreyColor,
                                  )
                                ],
                              );
                            },
                          ),
                        )
                      : Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Withdraw Pending",
                                  style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.mainColor),
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: walletController.walletDetails.value?.withdrawals.pending.length,
                                  itemBuilder: (context, index) {
                                    Withdraw currentWithdrawItem = walletController.walletDetails.value!.withdrawals.pending[index];
                                    return Column(
                                      children: [
                                        ListTile(
                                          contentPadding: EdgeInsets.zero,
                                          title: Text(
                                            "Withdraw Request",
                                            style: CustomTextStyles.buttonTextStyle
                                                .copyWith(color: AppColors.blackColor, fontWeight: FontWeight.bold, fontSize: 16.px),
                                          ),
                                          subtitle: Text(
                                            formatDate(currentWithdrawItem.createdAt.toString()),
                                            style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.blackColor, fontSize: 12.px),
                                          ),
                                          trailing: Text(
                                            "-\$${currentWithdrawItem.amount.toString()}",
                                            style: CustomTextStyles.buttonTextStyle
                                                .copyWith(color: AppColors.mainColor, fontWeight: FontWeight.bold, fontSize: 18.px),
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
                                  style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.mainColor),
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: walletController.walletDetails.value?.withdrawals.approved.length,
                                  itemBuilder: (context, index) {
                                    Withdraw currentWithdrawItem = walletController.walletDetails.value!.withdrawals.approved[index];
                                    return Column(
                                      children: [
                                        ListTile(
                                          contentPadding: EdgeInsets.zero,
                                          title: Text(
                                            "Withdraw",
                                            style: CustomTextStyles.buttonTextStyle
                                                .copyWith(color: AppColors.blackColor, fontWeight: FontWeight.bold, fontSize: 16.px),
                                          ),
                                          subtitle: Text(
                                            formatDate(currentWithdrawItem.createdAt.toString()),
                                            style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.blackColor, fontSize: 12.px),
                                          ),
                                          trailing: Text(
                                            "-\$${currentWithdrawItem.amount.toString()}",
                                            style: CustomTextStyles.buttonTextStyle
                                                .copyWith(color: AppColors.mainColor, fontWeight: FontWeight.bold, fontSize: 18.px),
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
                            ),
                          ),
                        ),
                ],
              )),
        ),
      );
    });
  }
}
