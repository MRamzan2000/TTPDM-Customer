import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/get_user_profile_model.dart';
import '../apis_services/user_profile_api.dart';

class UserProfileController extends GetxController {
  final BuildContext context;
  UserProfileController({required this.context});
  Rxn<GetUserProfileModel?> userProfile = Rxn<GetUserProfileModel>();
  final RxBool isLoading = true.obs;
  Future<void> fetchUserProfile({
    required bool loading,
    required String id,
  }) async {
    try {
      isLoading.value = loading;
      final data =
          await UserProfileApi(context: context).getUserProfile(id: id);

      if (data != null) {
        log("User profile data received: ${data.toJson()}");
        userProfile.value = data;
      } else {
        log("No data received");
        userProfile.value = null;
      }
      isLoading.value = false;
    } catch (e) {
      log("Exception during fetch: $e");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Unexpected error occurred: ${e.toString()}"),
        ));
      }
      userProfile.value = null;
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }
//update profile
  RxBool uploading = false.obs;
  Future<void> uploadProfileImage({
    required String token,
    required File profileImage, // Expecting a File object for image
    required String fullname,
  }) async {
    try {
      uploading.value = true;
      await UserProfileApi(context: context)
          .updateProfile(
        token: token,
        profileImage: profileImage,
        fullname: fullname,
      )
          .then(
        (value) {
          uploading.value = false;
        },
      );
    } catch (e) {
      log("Unexpected error occurred :${e.toString()}");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("unexpected error occurred :${e.toString()}")));
      }
      uploading.value = false;
    }
  }
  //Delete user Account
  RxBool deleteLoading = false.obs;
  Future<void> deleteUserAccount({required String token}) async {
    try {
      deleteLoading.value = true;
      await UserProfileApi(context: context)
          .deleteUserAccountMethod(token: token)
          .then(
        (value) {
          deleteLoading.value = false;
        },
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("unexpected error occurred :${e.toString()}")));
      }
      deleteLoading.value = false;
    }
  }
}
