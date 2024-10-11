import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttpdm/controller/apis_services/business_apis.dart';
import 'package:ttpdm/models/getbusiness_profile_model.dart';

class BusinessProfileController extends GetxController {
  final BuildContext context;
  BusinessProfileController({required this.context});
  final RxBool isLoading2 = false.obs;
  final RxBool isLoading1 = false.obs;

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
      required String token,
      required String fullname,
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
        fullname: fullname,
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

  RxList<Business?> allBusinessProfiles = <Business>[].obs;
  RxList<Business?> approvedProfiles = <Business>[].obs;
  RxList<Business?> rejectedProfiles = <Business>[].obs;
  RxList<Business?> pendingProfiles = <Business>[].obs;

  Future<void> fetchBusiness({
    required String token,
    required bool loading,
    required BuildContext context,
  }) async {
    isLoading2.value = loading;
    final data =
        await BusinessApis().getBusinessProfile(context: context, token: token);
    if (data != null) {
      allBusinessProfiles.value = data.businesses;
      categorizeProfiles();
      isLoading2.value = false;
    } else {
      isLoading2.value = false;
    }
  }
  void categorizeProfiles() {
    approvedProfiles.value = allBusinessProfiles
        .where((profile) => profile?.status == 'accepted')
        .toList();
    rejectedProfiles.value = allBusinessProfiles
        .where((profile) => profile?.status == 'rejected')
        .toList();
    pendingProfiles.value = allBusinessProfiles
        .where((profile) => profile?.status == 'pending')
        .toList();
  }

  //Delete Business profile
  Future<void> deleteBusiness({
    required String token,
    required BuildContext context,
    required String businessId,
  }) async {
    try {
      isLoading1.value = true;
      await BusinessApis()
          .deleteBusinessProfile(
              businessId: businessId, context: context, token: token)
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
      {required String businessId,
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
      required List<String> removeGalleryItems,
      required String token,
      required bool newLogo,
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
        context: context,
        removeGalleryItems: removeGalleryItems,
        newLogo: newLogo,
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
