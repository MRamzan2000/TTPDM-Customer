/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttpdm/controller/getx_controllers/get_fcm_token_send_notification_controller.dart';

import '../getx_controllers/poster_controller.dart';

void sendNotificationToMultipleUsers({
  required BuildContext context,
  required String token,
  required String title,
  required String message,
  required String info1,
  required String info2,
}) {
  GetFcmTokenSendNotificationController getFcmTokenSendNotificationController =
      Get.put();
  PosterController posterController =
      Get.put(PosterController(context: context));
  posterController
      .fetchPosters(
          context: context, loading: posterController.allPosters.value == null)
      .then(
    (value) {
      posterController.getAllMidAdminFcm().then(
        (value) {

        },
      );
    },
  );
}
*/
