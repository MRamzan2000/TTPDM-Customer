import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:ttpdm/models/get_campaign_rules_model.dart';
import 'package:http/http.dart' as http;
import '../utils/apis_constant.dart';

class CampaignRulesApi {
  final BuildContext context;
  CampaignRulesApi({required this.context});
  //Get Campaign Rules Api Method
  Future<GetCampaignRulesModel?> getCampaignRulesApi() async {
    final headers = {
      'Content-Type': 'application/json',
    };
    final url = Uri.parse("$baseUrl$getCampaignRulesEp");
    log("url :$url");
    final response = await http.get(url, headers: headers);
    log("response :${response.body}");
    log("statusCode :${response.statusCode}");
    if (response.statusCode == 200) {
      log('response 200===========');
      return getCampaignRulesModelFromJson(response.body);
    } else {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(responseBody["message"])));
      }
    }
    log('response else===========');

    log("response :${response.body}");
    log("statusCode :${response.statusCode}");
    return null;
  }
}
