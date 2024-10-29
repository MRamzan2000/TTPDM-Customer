import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttpdm/controller/apis_services/auth_apis.dart';

import '../custom_widgets/widgets.dart';

class SignUpController extends GetxController {
  final BuildContext context;
  SignUpController({required this.context});
  final RxBool isLoading = false.obs;
//sighUp Method
  Future<void> userSignUp({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
    required String role,
  }) async {
    try {
      isLoading.value = true;
      await AuthApis(context: context)
          .signUPApis(
              fullName: fullName,
              email: email,
              phoneNumber: phoneNumber,
              password: password,
              confirmPassword: confirmPassword,
              role: role)
          .then(
        (value) {
          return isLoading.value = false;
        },
      );
    } catch (e) {
      if (context.mounted) {
        customScaffoldMessenger('Something went wrong ${e.toString()}');
        isLoading.value = false;
      }
    }
  }
  //Canadian Phone Number Validation
  bool isValidCanadianPhoneNumber(String phoneNumber) {
    RegExp regex = RegExp(r'^(?:\+1\s?)?(\d{3})[-\s]?(\d{3})[-\s]?(\d{4})$');
    return regex.hasMatch(phoneNumber);
  }

}
