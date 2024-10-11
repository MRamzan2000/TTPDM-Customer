import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:ttpdm/view/screens/auth_section/login_screen.dart';

import '../../models/get_user_profile_model.dart';
import '../utils/apis_constant.dart';

class UserProfileApi {
  final BuildContext context;
  UserProfileApi({required this.context});
  Future<GetUserProfileModel?> getUserProfile({required String id}) async {
    final headers = {'Content-Type': 'application/json'};
    final url = Uri.parse("$baseUrl/$getUserProfileEp/$id");
    try {
      final response = await http.get(url, headers: headers);
      log("Request URL: $url");
      log("Response status code: ${response.statusCode}");
      log("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        log("Decoded JSON: $jsonResponse");

        return getUserProfileModelFromJson(response.body);
      } else {
        log("Failed to load user profile");
        return null;
      }
    } catch (e) {
      log("Exception: $e");
      return null;
    }
  }

  Future<void> updateProfile({
    required String token,
    required File profileImage, // Expecting a File object for image
    required String fullname,
  }) async {
    final url = Uri.parse('$baseUrl/$updateUserProfileEp');
    var request = http.MultipartRequest('POST', url)
      ..headers.addAll({
        'Authorization': 'Bearer $token',
      });
    request.files.add(
      await http.MultipartFile.fromPath(
        'profilePic',
        profileImage.path,
        contentType:
            MediaType('image', 'jpeg'), // Adjust if using other image formats
      ),
    );
    request.fields['fullname'] = fullname;

    try {
      var response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(responseBody);
        log('Decoded JSON: $jsonResponse');

        // Show success message
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile updated successfully!')),
          );
        }
      } else {
        log('Failed to update profile. Status code: ${response.statusCode}');

        // Show failure message
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to update profile.')),
          );
        }
      }
    } catch (e) {
      log('Exception: $e');

      // Show error message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('An error occurred while updating profile.')),
        );
      }
    }
  }

  //Delete user APi
  Future<void> deleteUserAccountMethod({required String token}) async {
    final url = Uri.parse("$baseUrl/$deleteUserProfileEp");
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };
    http.Response response = await http.delete(
      url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      Get.offAll(() => const LoginScreen());
    } else {
      log("response statusCode :${response.statusCode}");
    }
  }
}
