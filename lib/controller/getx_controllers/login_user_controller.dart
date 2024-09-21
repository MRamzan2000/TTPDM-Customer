import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttpdm/controller/apis_services/auth_apis.dart';

class LoginUserController extends GetxController {
  final BuildContext context;
  LoginUserController({required this.context});
  final RxBool isLoading = false.obs;
//Login Method
  Future<void> userLogin({
    required String email,
    required String password,
    required String fcmToken,
  }) async {
    try {
      isLoading.value = true;
      await AuthApis(context: context)
          .loginApis(
        email: email,
        password: password,
        fcmToken: fcmToken,
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
