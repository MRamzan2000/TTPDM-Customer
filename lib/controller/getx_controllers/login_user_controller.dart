import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttpdm/controller/apis_services/auth_apis.dart';
import 'package:ttpdm/controller/utils/my_shared_prefrence.dart';

import '../custom_widgets/widgets.dart';

class LoginUserController extends GetxController {
  final BuildContext context;
  LoginUserController({required this.context});
  final RxBool isLoading = false.obs;
//Login Method
  Future<void> userLogin({
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      await MySharedPreferences.clearAll();
      await AuthApis(context: context)
          .loginApis(
        email: email,
        password: password,
      )
          .then(
        (value) {
          return isLoading.value = false;
        },
      );
    } catch (e) {
      if (context.mounted) {
        customScaffoldMessenger('Something went wrong ${e.toString()}');
      }
    }
  }
}
