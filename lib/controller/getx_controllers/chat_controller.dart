import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../models/chat_details_model.dart';
import '../apis_services/chat_apis.dart';

class ChatController extends GetxController {
  final BuildContext context;

  ChatController({required this.context});

//get chat List Method
  final RxBool chatDetailLoading = true.obs;

  RxList<ChatDetailsModel?> fetchChatDetail = <ChatDetailsModel?>[].obs;

  Future<void> fetchChatDetails({
    required bool loading,
  }) async {
    chatDetailLoading.value = loading;
    fetchChatDetail.value = await ChatApis(context: context).getChatDetailsApi();
    chatDetailLoading.value = false;
  }

  //send message Method
  Future<void> sendMessage({
    required String message,
  }) async {
    try {
      await ChatApis(context: context).postSendMessage(message: message);
    } catch (e) {
      log("unexpected error occurred :${e.toString()}");
    }
  }
}
