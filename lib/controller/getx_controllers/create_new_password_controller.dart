import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ttpdm/controller/apis_services/auth_apis.dart';

class CreateNewPasswordController extends GetxController {
  final BuildContext context;
  CreateNewPasswordController(this.context);
  //create New Password
  final RxBool isLoading = false.obs;
  Future<void> createNewPassword(
      {required String newPassword,
        required String confirmPassword,
        required String userEmail,
        required String userId}) async {
    try {
      isLoading.value = true;
      AuthApis(context: context)
          .resetPassword(
          newPassword: newPassword,
          confirmPassword: confirmPassword,
          userId: userId, userEmail: userEmail)
          .then(
            (value) => isLoading.value = false,
      );
    } catch (e) {
      isLoading.value = false;
      log("unexpected error occurred :${e.toString()}");
    }
  }
}
