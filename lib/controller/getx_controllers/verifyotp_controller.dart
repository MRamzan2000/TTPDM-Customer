import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttpdm/controller/apis_services/auth_apis.dart';

import '../custom_widgets/widgets.dart';

class VerifyOtpController extends GetxController {
  final BuildContext context;
  VerifyOtpController({required this.context});
  final RxBool isLoading = false.obs;

  //Verify Otp
  Future<void> verifyOtp({
    required email,
    required otp,
    required title,
  }) async {
    try {
      isLoading.value = true;
      await AuthApis(context: context)
          .verifyOtp(email: email, otp: otp, title: title)
          .then(
        (value) {
          return isLoading.value = false;
        },
      );
    } catch (e) {
      if (context.mounted) {
        customScaffoldMessenger('Something went wrong ${e.toString()}');
      }
      isLoading.value = false;
    }
  }
}
