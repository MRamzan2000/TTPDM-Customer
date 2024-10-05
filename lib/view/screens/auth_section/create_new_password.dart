import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm/controller/custom_widgets/widgets.dart';
import 'package:ttpdm/controller/getx_controllers/create_new_password_controller.dart';
import 'package:ttpdm/controller/utils/apis_constant.dart';
import 'package:ttpdm/controller/utils/my_shared_prefrence.dart';
import 'package:ttpdm/controller/utils/preference_key.dart';

class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({
    super.key,
  });

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  late CreateNewPasswordController createNewPasswordController;


  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  RxString token="".obs;
  @override
  void initState() {
    super.initState();
    createNewPasswordController = Get.put(CreateNewPasswordController(context));
   token.value=MySharedPreferences.getString(authTokenKey);
  }

  @override
  Widget build(BuildContext context) {
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
                  'Create a new password',
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.onBoardingHeading
                      .copyWith(fontSize: 24.px),
                ),
                getVerticalSpace(1.2.h),
                Text(
                  "Your new password must be different from previous used passwords.",
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.onBoardingLight.copyWith(
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.px,
                      fontFamily: 'bold'),
                ),
                getVerticalSpace(4.h),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Enter Password',
                    style: CustomTextStyles.hintTextStyle
                        .copyWith(color: const Color(0xff000000)),
                  ),
                ),
                getVerticalSpace(.4.h),
                customTextFormField(controller: passwordController),
                getVerticalSpace(1.6.h),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Confirm Password',
                    style: CustomTextStyles.hintTextStyle
                        .copyWith(color: const Color(0xff000000)),
                  ),
                ),
                getVerticalSpace(.4.h),
                customTextFormField(controller: confirmPasswordController),
                getVerticalSpace(2.4.h),
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        customElevatedButton(
                          title: createNewPasswordController.isLoading.value ==
                                  true
                              ? spinkit
                              : Text(
                                  'Next ',
                                  style: CustomTextStyles.buttonTextStyle
                                      .copyWith(color: AppColors.whiteColor),
                                ),
                          onTap: () {
                            if (passwordController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Please enter the password')),
                              );
                            } else if (confirmPasswordController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Please enter the confirmPassword')),
                              );
                            }else if (confirmPasswordController.text!=passwordController.text) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('password and confirmPassword should be same')),
                              );
                            } else if (token.value.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('AuthToken is empty')),
                              );
                            }  else {
                              log("token ${token.value}");
                            createNewPasswordController.createNewPassword(
                                newPassword: passwordController.text,
                                confirmPassword: confirmPasswordController.text,
                                userId:token.value );
                            }
                          },
                          bgColor: AppColors.mainColor,
                          verticalPadding: 1.2.h,
                          horizentalPadding: 4.8.h,
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
