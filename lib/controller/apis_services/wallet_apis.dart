import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ttpdm/controller/utils/apis_constant.dart';
import 'package:ttpdm/controller/utils/preference_key.dart';
import 'package:ttpdm/models/getdesigns_model.dart';
import 'package:http/http.dart' as http;
import 'package:ttpdm/models/wallet_details_model.dart';

import '../utils/my_shared_prefrence.dart';

class WalletApis {
  final BuildContext context;

  WalletApis({required this.context});

  Future<WalletDetailsModel?> getWalletDetailsApi() async {
    final url = Uri.parse("$baseUrl/$walletDetailsEP/${MySharedPreferences.getString(userId)}");
    final headers = {
      "Content-Type": "application/json",
    };

    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      log("Get Wallet Details");
      return walletDetailsModelFromJson(response.body);
    } else {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      log("${responseBody["message"]}");
    }
    return null;
  }

  Future<bool> addWalletRequestApi({required String bankName, required String accountTitle, required String iban, required double amount}) async {
    final url = Uri.parse("$baseUrl/$walletWithdrawRequestEP");
    final headers = {
      "Content-Type": "application/json",
    };

    final body = {
        "userId": MySharedPreferences.getString(userId),
        "bank_name": bankName,
        "account_title": accountTitle,
        "IBAN": iban,
        "amount": amount
    };

    final response = await http.post(url, headers: headers, body: jsonEncode(body));
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Withdraw Request added')),
      );
      return true;
    } else {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(responseBody["message"].toString())),
      );
      log("${responseBody["message"]}");
    }
    return false;
  }
}
