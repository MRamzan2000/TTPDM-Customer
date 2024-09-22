import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:ttpdm/controller/utils/apis_constant.dart';
import 'package:ttpdm/models/get_stripe_key_model.dart';
import 'package:http/http.dart'as http;

class StripeApis{
  final BuildContext context;
  StripeApis({required this.context});

  //get New Admin Code
  Future<GetStripeKeyModel?> getStripeKeyMethod(
     ) async {
    final headers = {
      'Content-Type': 'application/json',
    };
    final url = Uri.parse("$baseUrl/$getStripeKeyEp");
    final response = await http.get(url, headers: headers);
    log("response :${response.body}");
    log("statusCode :${response.statusCode}");
    if (response.statusCode == 200) {
      log("data :${getStripeKeyModelFromJson(response.body)}");
      return getStripeKeyModelFromJson(response.body);
    }
    log("response :${response.body}");
    log("statusCode :${response.statusCode}");
    return null;
  }

}