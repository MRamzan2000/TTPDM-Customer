import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ttpdm/controller/utils/apis_constant.dart';
import 'package:ttpdm/controller/utils/my_shared_prefrence.dart';
import 'package:ttpdm/models/getall_coins_model.dart';

class SubscriptionApi {
  final BuildContext context;
  SubscriptionApi({required this.context});
  final PreferencesService preferencesService = PreferencesService();

  //subscription plan Api hit
  Future<void> subscriptionPlan(
      {required String token,
      required String planType,
      required BuildContext context}) async {
    final url = Uri.parse("$baseUrl/$subscriptionEp");
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = jsonEncode({"plan": planType});
    final response = await http.post(url, body: body, headers: headers);
    try {
      if (response.statusCode == 200) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('please pay your payment')));
          Get.back();
        }
      } else if (response.statusCode == 400) {
        if (context.mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Plan is required')));
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('unexpected error occurred')));
        }
      }
    } catch (e) {
      log('Unexpected error occurred:${e.toString()}');
    }
  }

  //get All Coins
  Future<GetAllCoins?> getAllCoins(
      {required BuildContext context, required token}) async {
    final url = Uri.parse("$baseUrl/$getAllCoinsEP");
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        log("coins get Successfully");
        return GetAllCoins.fromJson(jsonDecode(response.body));
      } else {
        log('Error fetching Coins: ${response.body}');
        return null;
      }
    } catch (e) {
      log('UnExpected Error fetching business profiles: ${e.toString()}');
      return null;
    }
  }
}
