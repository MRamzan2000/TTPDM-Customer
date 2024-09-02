import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttpdm/controller/apis_services/subplan_api.dart';

class SubscriptionController extends GetxController {
  RxBool isLoading = false.obs;
//Choose Subscription plan
  Future<void> chooseSubscriptionPlan(
      {required String token,
      required String planType,
      required context}) async {
    try {
      isLoading.value = true;
      await SubscriptionApi(context: context)
          .subscriptionPlan(token: token, planType: planType, context: context)
          .then(
            (value) => isLoading.value = false,
          );
    } catch (e) {
      log('Unexpected error occurred:${e.toString()}');
      isLoading.value = false;
    }
  }

  //fetchAllCoins
  var allCoins = 0.obs;
  //Business Profile get Method
  Future<void> fetchAllCoins(
      {required String token, required BuildContext context}) async {
    final data = await SubscriptionApi(context: context)
        .getAllCoins(context: context, token: token);
    if (data != null) {
      allCoins.value = data.coinBalance;
    }
  }
}
