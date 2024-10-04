import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:ttpdm/controller/apis_services/poster_apis.dart';
import 'package:ttpdm/controller/utils/apis_constant.dart';
import 'package:ttpdm/models/get_fcm_token_model.dart';

import '../getx_controllers/get_fcm_token_send_notification_controller.dart';

class GetFcmTokenApi {
  final BuildContext context;
  GetFcmTokenApi({required this.context});

  //Get Fcm Api Method
  Future<GetFcmTokenModel?> getFcmTokenApiMethod(
      {required String userId}) async {
    final url = Uri.parse("$baseUrl/user/$userId/fcm-token");
    final headers = {"Content-Type": "application/json"};
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      log("response body:${response.body}");
      log("response status code:${response.statusCode}");
      return getFcmTokenModelFromJson(response.body);
    } else {
      log("response body:${response.body}");
      log("response status code:${response.statusCode}");
      return null;
    }
  }

  //Send Notification Api Method
  Future<void> sendNotificationApi({
    required String token,
    required String title,
    required String message,
    required String info1,
    required String info2,
    required String fcmToken,
  }) async {
    final url = Uri.parse("$baseUrl/$sendNotificationEp");
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };
    final body = jsonEncode({
      "title": title,
      "body": {
        "message": message,
        "details": {"info1": info1, "info2": info2}
      },
      "fcmToken": fcmToken
    });
    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      log(responseBody["message"]);
    }else{
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      log(responseBody["message"]);

    }
  }

  Future<void> sendNotificationToAllMidAdmins({required String token,required String title,required String message,required String info1,required String info2})
  async {
    List<String> fcmTokens = await PosterApis(context: context)
        .getAllMidAdminFcmApiMethod()
        .then(
          (getAllMidAdminFcmModel) {
        return getAllMidAdminFcmModel?.tokens ?? [];
      },
    );
    for (int i = 0; i < fcmTokens.length; i++) {
      GetFcmTokenSendNotificationController(context: context)
          .sendNotification(
          token: token,
          title: title,
          message: message,
          info1: info1,
          info2: info2,
          fcmToken: fcmTokens[i]);
    }
  }
}
