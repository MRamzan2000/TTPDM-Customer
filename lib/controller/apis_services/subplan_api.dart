import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ttpdm/controller/utils/apis_constant.dart';
import 'package:ttpdm/controller/utils/my_shared_prefrence.dart';
import 'package:ttpdm/controller/utils/preference_key.dart';
import 'package:ttpdm/models/get_all_plans_model.dart';
import 'package:ttpdm/models/getall_coins_model.dart';

class SubscriptionApi {
  final BuildContext context;
  SubscriptionApi({required this.context});

  //subscription plan Api hit
  Future<void> subscriptionPlan(
      {required String token,
      required String planType,
      required String clientSecretKey,
      required double price,
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
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        // await StripePayments.name(
        //     price,
        //     clientSecretKey,context,
        //     token, planType,responseBody["sessionId"]
        // )
        //     .startPayment();

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

  //Get All Plans Api Methods
  Future<List<GetAllPlansModel>?> getAllPlans() async {
    final url = Uri.parse("$baseUrl/$getAllSubPlanEP");
    final headers = {
      'Content-Type': 'application/json',
    };
    try {
      final response = await http.get(headers: headers, url);
      if (response.statusCode == 200) {
        log("response :${response.body}");
        return getAllPlansModelFromJson(response.body);
      }
      log("response body :${response.body}");
      return null;
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("unexpected error occurred :${e.toString()}")));
      }
    }
    return null;
  }
  //confirm payment
  Future<void> confirmPaymentApiMethod({
    required String plan,
    required String token,
  }) async {
    final url = Uri.parse(
        "$baseUrl/$confirmSubscriptionPaymentEp$plan");
    final headers = {
      "Content-Type": "application/json",
      "Authorization":"Bearer $token"
    };

    log("$baseUrl/$confirmSubscriptionPaymentEp$plan");
    log("$token\n$plan");
    http.Response response = await http.get(url, headers: headers);
    log(response.body);
    log("${response.statusCode}");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("payment Confirmed Successfully")));
      MySharedPreferences.setString(subscription,data['subscription']["expiryDate"]);

      log("Payment confirmed: $data");
    } else {
      log("Error: ${response.statusCode} - ${response.body}");
    }
  }
}
