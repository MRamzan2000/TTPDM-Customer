import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttpdm/controller/utils/apis_constant.dart';
import 'package:ttpdm/models/get_all_mid_admin_fcm_model.dart';
import 'package:ttpdm/models/getdesigns_model.dart';
import 'package:http/http.dart' as http;

import '../custom_widgets/widgets.dart';

class PosterApis {
  final BuildContext context;
  PosterApis({required this.context});
  //Get All design
  Future<GetAllDesignsModel?> getAllDesigns(
      {required String businessId}) async {
    final url = Uri.parse("$baseUrl/$getAllDesignsEP$businessId");
    final headers = {
      'Content-Type': 'application/json',
    };
    try {
      final response = await http.get(url, headers: headers);

      // Debug prints
      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');
      if (response.statusCode == 200) {
        return GetAllDesignsModel.fromJson(jsonDecode(response.body));
      } else {
        log('Error fetching business profiles: ${response.body}');
        return null;
      }
    } catch (e) {
      log('UnExpected Error fetching business profiles: ${e.toString()}');
      return null;
    }
  }

  //like poster
  Future<void> likeDesignApi({
    required String designId,
    required String token,
  }) async {
    final url = Uri.parse("$baseUrl/$likeDesignEp/$designId/like");
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    try {
      final response = await http.post(url, headers: headers);
      if (response.statusCode == 200) {
        log("Design liked successfully");
      } else if (response.statusCode == 401) {
        log("Unauthorized. Please check your token.");
      } else if (response.statusCode == 400) {
        log("Bad request. Please check the request parameters.");
      } else if (response.statusCode == 404) {
        log("Design not found.");
      } else {
        log("Failed to like design. Status code: ${response.statusCode}");
      }
    } catch (e) {
      log("An error occurred: $e");
    }
  }

//dislike poster
  Future<void> dislikeDesignApi({
    required String designId,
    required String token,
  }) async {
    final url = Uri.parse("$baseUrl/$likeDesignEp/$designId/dislike");
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    try {
      final response = await http.post(url, headers: headers);

      if (response.statusCode == 200) {
        log("Design Disliked successfully");
      } else if (response.statusCode == 401) {
        log("Unauthorized. Please check your token.");
      } else if (response.statusCode == 400) {
        log("Bad request. Please check the request parameters.");
      } else if (response.statusCode == 404) {
        log("Design not found.");
      } else {
        log("Failed to like design. Status code: ${response.statusCode}");
      }
    } catch (e) {
      log("An error occurred: $e");
    }
  }

  //edit poster
  Future<void> editPosterRequestApi({
    required String designId,
    required String businessId,
    required String comment,
  }) async {
    final url = Uri.parse("$baseUrl/$editDesignEp");
    final headers = {
      "Content-Type": "application/json",
    };
    final body = jsonEncode(
        {"businessId": businessId, "designId": designId, "comment": comment});

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      customScaffoldMessenger("Edit Design Request successfully");
      log("Edit Design Request successfully");
      Get.back();
    } else {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      log("${responseBody["message"]}");
    }
  }

  //Get All Mid Admin Fcm
  Future<GetAllMidAdminFcmModel?> getAllMidAdminFcmApiMethod() async {
    final url = Uri.parse("$baseUrl/$getAllMidAdminFcmEp");
    final headers = {
      'Content-Type': 'application/json',
    };
    try {
      final response = await http.get(url, headers: headers);
      // Debug prints
      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');
      if (response.statusCode == 200) {
        return getAllMidAdminFcmModelFromJson(response.body);
      } else {
        log('Error fetching business profiles: ${response.body}');
        return null;
      }
    } catch (e) {
      log('UnExpected Error fetching business profiles: ${e.toString()}');
      return null;
    }
  }
}
