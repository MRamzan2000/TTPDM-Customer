import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttpdm/controller/apis_services/auth_apis.dart';

class ForgetEmailController extends GetxController {
  final BuildContext context;
  ForgetEmailController({required this.context});
  final RxBool isLoading = false.obs;

  //Forget Password
  Future<void> forgetPassword({
    required String email,
  }) async {
    try {
      isLoading.value = true;
      await AuthApis(context: context)
          .forgetPassword(
        email: email,
      )
          .then(
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
