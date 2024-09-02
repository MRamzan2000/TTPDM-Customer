import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttpdm/controller/apis_services/get_coins_apis.dart';
import 'package:ttpdm/models/get_allcoinsplan_model.dart';

class CoinsController extends GetxController {
  // Observables for holding the data and loading state
  RxList <GetAllCoinsPlan?> purchaseCoinsPlane = <GetAllCoinsPlan>[].obs;
  RxBool isLoading = true.obs;

  // Method to fetch coin plans
  Future<void> fetchCoinsPlan({
    required String token,
    required bool loading,
    required BuildContext context,

  }) async {
    isLoading.value = loading; // Start loading

    try {
      final data = await GetCoinsApis()
          .getAllCoinsMethod(context: context, token: token);

      if (data != null) {
        purchaseCoinsPlane.value = data;
      } else {
        purchaseCoinsPlane.clear();
      }
    } catch (e) {
      purchaseCoinsPlane.clear();
    } finally {
      isLoading.value = false; // Stop loading regardless of success or failure
    }
  }

  //purchase coins plan
  RxBool loading = false.obs;

  Future<void> buyCoinsPlan(
      {required coinAmount,
      required token,
      required BuildContext context}) async {
    try {
      loading.value = true;
      GetCoinsApis()
          .purchaseCoins(coinAmount: coinAmount, token: token, context: context)
          .then(
        (value) {
           loading.value = false;
        },
      );
    } catch (e) {
      log("unexpected error occurred :${e.toString()}");
      loading.value = false;
    }
  }
}
