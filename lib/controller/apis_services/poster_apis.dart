import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:ttpdm/controller/utils/apis_constant.dart';
import 'package:ttpdm/models/getdesigns_model.dart';
import 'package:http/http.dart' as http;

class PosterApis {
  final BuildContext context;
  PosterApis({required this.context});
  //Get All design
  Future<GetAllDesignsModel?> getAllDesigns() async {
    final url = Uri.parse("$baseUrl/$getAllDesignsEP");
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

}
