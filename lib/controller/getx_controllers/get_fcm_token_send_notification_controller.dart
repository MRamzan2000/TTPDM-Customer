import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttpdm/models/get_fcm_token_model.dart';
import '../apis_services/get_fcm_send_notification_api.dart';

class GetFcmTokenSendNotificationController extends GetxController {
  final BuildContext context;

  GetFcmTokenSendNotificationController({required this.context});

  Rxn<GetFcmTokenModel?> fcmToken = Rxn<GetFcmTokenModel?>();
  final RxBool fcmLoading = false.obs;

  // Fetch FCM Token and send notification
  Future<void> fetchFcmToken({
    required bool loading,
    required String userId,
    required String token,
    required String title,
    required String message,
    required String info1,
    required String info2,
  }) async {
    try {
      fcmLoading.value = loading;
      final data = await GetFcmTokenApi(context: context)
          .getFcmTokenApiMethod(userId: userId);

      if (data != null) {
        fcmToken.value = data;
        log("fcm token :${fcmToken.value}");
        await sendNotification(
          token: token,
          title: title,
          message: message,
          info1: info1,
          info2: info2,
          fcmToken: data.fcmToken,
        );
      } else {
        fcmToken.value = null;
      }
    } catch (e) {
      log("Unexpected error occurred: ${e.toString()}");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Unexpected error occurred: ${e.toString()}")),
        );
      }
    } finally {
      fcmLoading.value = false;
    }
  }

  // Send Notification
  Future<void> sendNotification({
    required String token,
    required String title,
    required String message,
    required String info1,
    required String info2,
    required String fcmToken,
  }) async {
    try {
      await GetFcmTokenApi(context: context).sendNotificationApi(
        token: token,
        title: title,
        message: message,
        info1: info1,
        info2: info2,
        fcmToken: fcmToken,
      );
    } catch (e) {
      log("Unexpected error occurred while sending notification: ${e.toString()}");
    }
  }
}
