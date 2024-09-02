import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:ttpdm/controller/utils/apis_constant.dart';
import 'package:ttpdm/models/getbusiness_profile_model.dart';

import 'package:dio/dio.dart';

import 'package:path_provider/path_provider.dart';

import '../../view/screens/bottom_navigationbar.dart';

class BusinessApis {
//Create Business Profile
  Future<void> addBusinessProfile({
    required String name,
    required String phone,
    required String location,
    required String targetMapArea,
    required String description,
    required String websiteUrl,
    required String facebookUrl,
    required String instagramUrl,
    required String linkedinUrl,
    required String tiktokUrl,
    required String token,
    required File logo,
    required BuildContext context,
    required List<File> gallery,
  }) async {
    final url = Uri.parse("$baseUrl/$setBusinessProfileEp");
    final request = http.MultipartRequest('POST', url);

    // Add fields
    request.fields['name'] = name;
    request.fields['phone'] = phone;
    request.fields['location'] = location;
    request.fields['targetMapArea'] = targetMapArea;
    request.fields['description'] = description;
    request.fields['websiteUrl'] = websiteUrl;
    request.fields['facebookUrl'] = facebookUrl;
    request.fields['instagramUrl'] = instagramUrl;
    request.fields['linkedinUrl'] = linkedinUrl;
    request.fields['tiktokUrl'] = tiktokUrl;

    // Add logo file with MIME type
    request.files.add(await http.MultipartFile.fromPath(
      'logo',
      logo.path,
      contentType: MediaType('image', 'jpeg'), // Adjust if needed
    ));

    // Add gallery images with MIME type
    for (var image in gallery) {
      request.files.add(await http.MultipartFile.fromPath(
        'gallery',
        image.path,
        contentType: MediaType('image', 'jpeg'), // Adjust if needed
      ));
    }

    // Set headers, including Authorization header
    request.headers['Authorization'] = 'Bearer $token';

    try {
      log("Sending request to: $url");
      final response = await request.send();
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);

      log("Response Status Code: ${response.statusCode}");
      log("Response Body: $responseString");

      if (context.mounted) {
        if (response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Business profile submitted successfully')),
          );



        } else if (response.statusCode == 400) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content:
                    Text('Business limit reached for your subscription plan')),
          );
        } else if (response.statusCode == 401) {
          Map<String, dynamic> responseBody = jsonDecode(responseString);
          String errorMessage = responseBody['errors'].isNotEmpty
              ? responseBody['errors'].first['msg']
              : 'An error occurred';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMessage)),
          );
        } else if (response.statusCode == 404) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Get a subscription first")),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Unexpected status code: $responseString')),
          );
        }
      }
    } catch (e) {
      log("Exception: $e");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  //GetBusiness Profile
  Future<GetBusinessProfileModel?> getBusinessProfile(
      {required BuildContext context, required token}) async {
    final url = Uri.parse("$baseUrl/$getBusinessProfileEp");
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        return GetBusinessProfileModel.fromJson(jsonDecode(response.body));
      } else {
        log('Error fetching business profiles: ${response.body}');
        return null;
      }
    } catch (e) {
      log('UnExpected Error fetching business profiles: ${e.toString()}');
      return null;
    }
  }

  //delete business profile
  Future<void> deleteBusinessProfile(
      {required String businessId, required BuildContext context,
        required token
      }) async {
    final url = Uri.parse("$baseUrl/$deleteBusinessProfileEp/$businessId");
    final headers = {
      "Content-Type": "application/json",
      "Authorization":"Bearer $token"
    };
    try {
      final response = await http.delete(url, headers: headers);
      log("response status code:${response.statusCode}");
      log("response body:${response.body}");

      if (response.statusCode == 200) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Business deleted successfully')));
          Get.to(
              ()=>const CustomBottomNavigationBar()
          );
          getBusinessProfile(context: context, token: token);
        }
      } else if (response.statusCode == 400) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Business not found')));
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Unexpected error occurred')));
      }
      log('Unexpected error occurred :${e.toString()}');
    }
  }
  //Edit Business Profile
  Future<void> editBusinessProfile({
    required String name,
    required String businessId,
    required String phone,
    required String location,
    required String targetMapArea,
    required String description,
    required String websiteUrl,
    required String facebookUrl,
    required String instagramUrl,
    required String linkedinUrl,
    required String tiktokUrl,
    required String token,
    required String logo,
    required BuildContext context,
    required List<String> gallery,
    required List<String> removeGallery, // Assuming removeGallery contains URLs or IDs of images to be removed
  }) async {
    const fileName = 'adBanner.png'; // or extract it from the URL if it has a different extension

    final downloadedFile = await downloadFile(logo, fileName);

    final url = Uri.parse("$baseUrl/$editBusinessProfileEp"); // Ensure this is the correct URL
    final request = http.MultipartRequest('PUT', url); // Change method to PUT

    // Add fields
    request.fields['businessId'] = businessId;
    request.fields['name'] = name;
    request.fields['phone'] = phone;
    request.fields['location'] = location;
    request.fields['targetMapArea'] = targetMapArea;
    request.fields['description'] = description;
    request.fields['websiteUrl'] = websiteUrl;
    request.fields['facebookUrl'] = facebookUrl;
    request.fields['instagramUrl'] = instagramUrl;
    request.fields['linkedinUrl'] = linkedinUrl;
    request.fields['tiktokUrl'] = tiktokUrl;

    // Add logo file with MIME type
    request.files.add(await http.MultipartFile.fromPath(
      'logo',
      downloadedFile.path,
      contentType: MediaType('image', 'jpeg'), // Adjust MIME type if necessary
    ));

    // Download and add gallery images
    for (var i = 0; i < gallery.length; i++) {
      final galleryUrl = gallery[i];
      final fileName = 'gallery_$i.png'; // Create unique file name
      final galleryFile = await downloadFile(galleryUrl, fileName);

      request.files.add(await http.MultipartFile.fromPath(
        'gallery',
        galleryFile.path,
        contentType: MediaType('image', 'png'), // Adjust MIME type if necessary
      ));
    }

    // Add removeGallery field with URLs or IDs to be removed
    request.fields['removeGallery'] = json.encode(removeGallery); // Adjust if the API requires different handling

    // Set headers, including Authorization header
    request.headers['Authorization'] = 'Bearer $token';

    try {
      log("Sending request to: $url");
      final response = await request.send();
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);

      log("Response Status Code: ${response.statusCode}");
      log("Response Body: $responseString");

      if (context.mounted) {
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Business profile updated successfully')),
          );
          // Assuming you need to refresh the profile or navigate back
          getBusinessProfile(context: context, token: token).then((_) => Navigator.of(context).pop());
        } else if (response.statusCode == 401) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Authentication token is required')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Unexpected status code: $responseString')),
          );
        }
      }
    } catch (e) {
      log("Exception: $e");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }
  //convert path
  Future<String> getLocalFilePath(String fileName) async {
    final directory = await getTemporaryDirectory(); // Use getApplicationDocumentsDirectory() if you need persistence
    return '${directory.path}/$fileName';
  }

  Future<File> downloadFile(String url, String fileName) async {
    final filePath = await getLocalFilePath(fileName);

    try {
      final dio = Dio();
      await dio.download(url, filePath);
      return File(filePath);
    } catch (e) {
      throw Exception('Failed to download file: $e');
    }
  }



}
