import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttpdm/controller/apis_services/wallet_apis.dart';
import 'package:ttpdm/models/getdesigns_model.dart';
import 'package:ttpdm/models/wallet_details_model.dart';

import '../apis_services/poster_apis.dart';

class WalletController extends GetxController {
  final BuildContext context;

  WalletController({required this.context});

  Rxn<WalletDetailsModel?> walletDetails = Rxn<WalletDetailsModel>();
  RxBool isLoading = false.obs;
  RxBool requestLoading = false.obs;

  Future<void> getWalletDetails({
    required BuildContext context,
    required bool loading,
  }) async {
      isLoading.value = loading;
      await WalletApis(context: context).getWalletDetailsApi().then((value) {
            walletDetails.value = value;
      },);
      isLoading.value = false;
    }

    Future<bool> addWalletRequest({
    required BuildContext context,
    required bool loading,
      required String bankName,
      required String accountTitle,
      required String iban,
      required double amount,
  }) async {
      requestLoading.value = loading;
      await WalletApis(context: context).addWalletRequestApi(bankName: bankName, accountTitle: accountTitle, iban: iban, amount: amount).then((value) {
        requestLoading.value = false;
        return value;
      },);
      requestLoading.value = false;
      return false;
    }
}
