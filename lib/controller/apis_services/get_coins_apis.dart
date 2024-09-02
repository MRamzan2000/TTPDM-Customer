import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:ttpdm/models/get_allcoinsplan_model.dart';
import 'package:ttpdm/controller/utils/apis_constant.dart';


class GetCoinsApis {
  // Get coin plans
  Future<List<GetAllCoinsPlan>?> getAllCoinsMethod({
    required BuildContext context,
    required String token,
  }) async {
    final url = Uri.parse("$baseUrl/$getAllCoinsPlanEP");
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        log('Response: ${response.body}');
        List<dynamic> jsonResponse = jsonDecode(response.body);
        return jsonResponse
            .map((data) => GetAllCoinsPlan.fromJson(data))
            .toList();
      } else {
        log('Error fetching coin plans: ${response.body}');
        return null;
      }
    } catch (e) {
      log('Unexpected error fetching coin plans: ${e.toString()}');
      return null;
    }
  }

  //purchase Coins
  Future<void> purchaseCoins({required coinAmount, required token,
    required BuildContext context}) async {
    final url = Uri.parse("$baseUrl/$purchaseCoinsEP");
    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    final body = jsonEncode({
      "coinAmount": coinAmount,
    });
    final response = await post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      log('responseBody $responseBody');
    } else {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (context.mounted) {
        String errorMessage = responseBody['message'].isNotEmpty
            ? responseBody['message']
            : 'An error occurred';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
      else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Unexpected status code: ${response.body}')),
          );
        }
      }
    }
  }
}