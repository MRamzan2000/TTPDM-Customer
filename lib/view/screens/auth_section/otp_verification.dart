import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm/controller/custom_widgets/widgets.dart';
import 'package:ttpdm/controller/getx_controllers/verifyotp_controller.dart';
import 'package:ttpdm/controller/utils/apis_constant.dart';

class OtpVerification extends StatefulWidget {
  final String title;
  final String email;

  const OtpVerification({super.key, required this.title, required this.email});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  final RxString otpCode = ''.obs;
  @override
  Widget build(BuildContext context) {
    final VerifyOtpController verifyOtpController =
        Get.put(VerifyOtpController(context: context));

    return Scaffold(
      backgroundColor: const Color(0xfff8f9fa),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.4.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                getVerticalSpace(12.h),
                Text(
                  'Enter the verification code',
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.onBoardingHeading
                      .copyWith(fontSize: 24.px),
                ),
                getVerticalSpace(1.2.h),
                Text(
                  'We have just sent you a 4-digit code on ${widget.email}',
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.onBoardingLight.copyWith(
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.px,
                    fontFamily: 'bold',
                  ),
                ),
                getVerticalSpace(5.2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OtpTextField(
                      textStyle: TextStyle(
                          fontSize: 24.px,
                          color: const Color(0xff4D4F53),
                          fontWeight: FontWeight.w700,
                          fontFamily: 'bold'),
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      enabledBorderColor: Colors.transparent,
                      focusedBorderColor: AppColors.mainColor,
                      fieldHeight: 6.h,
                      margin: EdgeInsets.symmetric(horizontal: 2.h),
                      borderColor: Colors.transparent,
                      filled: true,
                      fillColor: const Color(0xffF3F3F3),
                      onSubmit: (value) {
                        log("submit value is :$value}");
                        otpCode.value = value;
                        log("value after submitted :${otpCode.value}");
                      },
                    ),
                  ],
                ),
                getVerticalSpace(4.2.h),
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        customElevatedButton(
                          title: verifyOtpController.isLoading.value
                              ? spinkit
                              : Text(
                                  'Next ',
                                  style: CustomTextStyles.buttonTextStyle
                                      .copyWith(color: AppColors.whiteColor),
                                ),
                          onTap: () {
                            log("value after submitted :${otpCode.value}");

                            if (otpCode.value.isEmpty ||
                                otpCode.value.length != 4) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Please enter a valid 4-digit OTP')),
                              );
                            } else {
                              verifyOtpController.verifyOtp(
                                email: widget.email,
                                otp: otpCode.value,
                                title: widget.title,
                              );
                            }
                          },
                          bgColor: AppColors.mainColor,
                          verticalPadding: 1.2.h,
                          horizentalPadding: 4.8.h,
                        ),
                      ],
                    )),
                getVerticalSpace(1.2.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
