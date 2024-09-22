import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttpdm/controller/apis_services/subplan_api.dart';
import 'package:ttpdm/models/get_all_plans_model.dart';

class SubscriptionController extends GetxController {
  RxBool isLoading = false.obs;
//Choose Subscription plan
  Future<void> chooseSubscriptionPlan(
      {required String token,
      required String planType,
      required double price,
      required String clientSecretKey,
      required context}) async {
    try {
      isLoading.value = true;
      await SubscriptionApi(context: context)
          .subscriptionPlan(
          token: token,
          planType: planType,
          context: context,
        clientSecretKey: clientSecretKey,price: price
      )
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

  RxBool planLoading = false.obs;

  RxList<GetAllPlansModel?> getAllPlans = <GetAllPlansModel>[].obs;

  // Method to fetch coin plans
  Future<void> fetchAllPlans({
    required bool loading,
    required BuildContext context,
  }) async {
    planLoading.value = loading; // Start loading

    try {
      final data = await SubscriptionApi(context: context).getAllPlans();

      if (data != null) {
        getAllPlans.value = data;
        log("when data is not null :$getAllPlans");
        planLoading.value = false;
      } else {
        log("when data clear :$getAllPlans");
        planLoading.value = false;
      }
    } catch (e) {
      log("Unexpected error occurred :${e.toString()}");
      planLoading.value = false;
      log("when data clear :$getAllPlans");
    }
  }

// Confirm Payment
  RxBool paymentLoading = false.obs;
  Future<void> confirmPayment({
    required BuildContext context,
    required String plan,
    required String token,
  }) async {
    try {
      paymentLoading.value = true;
      await SubscriptionApi(context: context)
          .confirmPaymentApiMethod( plan: plan,token:token)
          .then(
        (value) {
          paymentLoading.value = false;
        },
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("unexpected error occurred :${e.toString()}")));
      }
    }
  }
}
