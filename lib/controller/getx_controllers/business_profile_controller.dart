import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttpdm/controller/apis_services/business_apis.dart';
import 'package:ttpdm/models/getbusiness_profile_model.dart';
import 'package:ttpdm/view/screens/bottom_navigationbar.dart';

import '../utils/my_shared_prefrence.dart';

class BusinessProfileController extends GetxController {
  final BuildContext context;
  BusinessProfileController({required this.context});
  final RxBool isLoading2 = false.obs;
  final RxBool isLoading1 = false.obs;
  //onInit Method
  @override
  Future<void> onInit() async {
    log("this is token ${PreferencesService.keyToken}");
    super.onInit();
    await PreferencesService().getAuthToken();
  }

//Business Profile Api Method
  Future<void> submitBusinessProfile(
      {required String name,
      required String phone,
      required String location,
      required String targetMapArea,
      required String description,
      required String websiteUrl,
      required String facebookUrl,
      required String instagramUrl,
      required String linkedinUrl,
      required String tiktokUrl,
      required File logo,
      required List<File> gallery,
      required String token, // Corrected list<File> to List<File>}
      required BuildContext context}) async {
    try {
      isLoading1.value = true;
      await BusinessApis()
          .addBusinessProfile(
        name: name,
        phone: phone,
        location: location,
        targetMapArea: targetMapArea,
        description: description,
        gallery: gallery,
        websiteUrl: websiteUrl,
        facebookUrl: facebookUrl,
        instagramUrl: instagramUrl,
        linkedinUrl: linkedinUrl,
        logo: logo,
        tiktokUrl: tiktokUrl,
        token: token,
        context: context,
      )
          .then(
        (value) {
          return isLoading1.value = false;
        },
      );
    } catch (e) {
      log("Unexpected error Occurred :${e.toString()}");
      isLoading1.value = false;

      // if (context.mounted) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //       SnackBar(content: Text('Something went wrong ${e.toString()}')));
      // }
    }
  }

  RxList <Business?> businessProfiles = <Business>[].obs;

//Business Profile get Method
  Future<void> fetchBusiness(
      {
        required String token, 
        required bool loading,
        required BuildContext context
      }) async {
    isLoading2.value = loading;
    final data =
        await BusinessApis().getBusinessProfile(context: context, token: token);
    if (data != null) {
      businessProfiles.value = data.businesses;
      isLoading2.value = false;
    }
  }

  //Delete Business profile
  Future<void> deleteBusiness(
      {required String token,
      required BuildContext context,
      required String businessId,
      }) async {
    try {
      isLoading1.value = true;
      await BusinessApis()
          .deleteBusinessProfile(businessId: businessId, context: context, token: token)
          .then(
            (value) => isLoading1.value = false,
          );
    } catch (e) {
      log("Unexpected error Occurred :${e.toString()}");
      isLoading1.value = true;
    }
  }

  //edit business Profile
  Future<void> editBusinessProfile(
      {
        required String businessId,
        required String name,
        required String phone,
        required String location,
        required String targetMapArea,
        required String description,
        required String websiteUrl,
        required String facebookUrl,
        required String instagramUrl,
        required String linkedinUrl,
        required String tiktokUrl,
        required String logo,
        required List<String> gallery,
        required String token, // Corrected list<File> to List<File>}
        required BuildContext context}) async {
    try {
      isLoading1.value = true;
      await BusinessApis()
          .editBusinessProfile(
        businessId: businessId,
        name: name,
        phone: phone,
        location: location,
        targetMapArea: targetMapArea,
        description: description,
        gallery: gallery,
        websiteUrl: websiteUrl,
        facebookUrl: facebookUrl,
        instagramUrl: instagramUrl,
        linkedinUrl: linkedinUrl,
        logo: logo,
        tiktokUrl: tiktokUrl,
        token: token,
        context: context, removeGallery: gallery,
      )
          .then(
            (value) {
          return isLoading1.value = false;
        },
      );
    } catch (e) {
      log("Unexpected error Occurred :${e.toString()}");
      isLoading1.value = false;
    }
  }
}
