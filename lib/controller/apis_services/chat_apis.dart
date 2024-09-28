import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:ttpdm/controller/utils/my_shared_prefrence.dart';
import 'package:ttpdm/controller/utils/preference_key.dart';

import '../../models/chat_details_model.dart';
import '../utils/apis_constant.dart';

class ChatApis {
  final BuildContext context;
  ChatApis({required this.context});

  //get chat Details Api
  Future<List<ChatDetailsModel>> getChatDetailsApi() async {
    final headers = {
      'Content-Type': 'application/json',
    };
    final url = Uri.parse("$baseUrl/$getChatDetailEp${MySharedPreferences.getString(userIdKey)}");
    final response = await http.get(url, headers: headers);
    log("response :${response.body}");
    log("statusCode :${response.statusCode}");
    if (response.statusCode == 200) {
      print('response 200===========');
      return chatDetailsModelFromJson(response.body);
    }
    print('response else===========');

    log("response :${response.body}");
    log("statusCode :${response.statusCode}");
    return [];
  }

//Post Send Message Api Method
  Future<void> postSendMessage({
    required String message,
  }) async {
    final url = Uri.parse("$baseUrl$sendMessageEp");
    final headers = {
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({"userId": MySharedPreferences.getString(userIdKey), "text": message});
    final response = await http.post(url, headers: headers, body: body);
    log("response :${response.body}");
    log("statusCode :${response.statusCode}");
    if (response.statusCode == 200) {
      log("success send message");
    } else {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      log("error occurred :${responseBody["message"]}");
    }
  }
}
