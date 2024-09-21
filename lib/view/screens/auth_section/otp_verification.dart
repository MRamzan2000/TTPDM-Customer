import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm/controller/custom_widgets/widgets.dart';
import 'package:ttpdm/controller/getx_controllers/verifyotp_controller.dart';
import 'package:ttpdm/controller/utils/apis_constant.dart';

class OtpVerification extends StatelessWidget {
  final String title;
  final String email;
   OtpVerification({super.key, required this.title, required this.email});
final RxString otpCode=''.obs;
  @override
  Widget build(BuildContext context) {
    final VerifyOtpController verifyOtpController=Get.put(VerifyOtpController(context:context));
    return Scaffold(
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
                  'We have just sent you a 4-digit code on $email',
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.onBoardingLight.copyWith(
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.px,
                      fontFamily: 'bold'),
                ),
                getVerticalSpace(5.2.h),
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
                  fieldWidth: 6.h,
                  margin: EdgeInsets.symmetric(horizontal: 2.h),
                  borderColor: Colors.transparent,
                  filled: true,
                  fillColor: const Color(0xffF3F3F3),
                    onSubmit: (value) {
                      otpCode.value=value;
                    },
                ),
                getVerticalSpace(4.2.h),
                Obx(() =>
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        customElevatedButton(
                          title: verifyOtpController.isLoading.value == true
                              ? spinkit
                              : Text(
                            'Next ',
                            style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.whiteColor),
                          ),
                          onTap: () {
                            if (otpCode.value.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Please enter the otp')),
                              );
                            } else {
                              verifyOtpController.verifyOtp(
                                email: email, otp: otpCode.value, title: title,

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
                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child: GestureDetector(
                //     onTap: () {
                //       Get.to(() =>  RegisterScreen());
                //     },
                //     child: RichText(
                //         text: TextSpan(children: [
                //       TextSpan(
                //           text: "Didn't receive?",
                //           style: CustomTextStyles.buttonTextStyle.copyWith(
                //               color: const Color(0xff444545), fontSize: 14.px)),
                //       // TextSpan(
                //       //   text: '\n           59',
                //       //   style: CustomTextStyles.buttonTextStyle.copyWith(
                //       //     color: AppColors.mainColor,
                //       //     fontSize: 14.px,
                //       //   ),
                //       // ),
                //     ])),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
