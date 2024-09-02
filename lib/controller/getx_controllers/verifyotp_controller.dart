import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttpdm/controller/apis_services/auth_apis.dart';

class VerifyOtpController extends GetxController {
  final BuildContext context;
  VerifyOtpController({required this.context});
  final RxBool isLoading = false.obs;

  //Verify Otp
  Future<void> verifyOtp({
    required email,
    required otp,
  }) async {
    try {
      isLoading.value = true;
      await AuthApis(context: context).verifyOtp(email: email, otp: otp).then(
        (value) {
          return isLoading.value = false;
        },
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Something went wrong ${e.toString()}')));
      }
    }
  }
}
