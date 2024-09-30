import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:ttpdm/controller/utils/apis_constant.dart';
import 'package:ttpdm/models/getbusiness_profile_model.dart';

import 'package:dio/dio.dart';

import 'package:path_provider/path_provider.dart';

import '../../view/screens/bottom_navigationbar.dart';
import '../getx_controllers/add_campaign_controller.dart';

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
    required String fullname,
    required File logo,
    required BuildContext context,
    required List<File> gallery,
  }) async {
    final url = Uri.parse("$baseUrl/$setBusinessProfileEp");
    final request = http.MultipartRequest('POST', url);

    // Add fields
    request.fields['name'] = name;
    request.fields['fullname'] = fullname;
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
      log("Before this is body :${response.body}");
      log("Before this is statusCode :${response.statusCode}");

      if (response.statusCode == 200) {
        Map<String ,dynamic>responseBody=jsonDecode(response.body);
        log("this is body :$responseBody");
        log("this is body :${response.body}");
        log("Businesses :${GetBusinessProfileModel.fromJson(jsonDecode(response.body))}");
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
    required List<String> removeGalleryItems,
    required bool newLogo,
  }) async {
    List<Map<String, dynamic>> pickedMediaList = Get.put(AddCampaignController()).pickedMediaList;
    log("newLogo: $newLogo, gallery count: ${gallery.length}, removeGallery count: ${removeGalleryItems.length}, pickedMedia count: ${pickedMediaList.length}");

    try {
      final url = Uri.parse("$baseUrl/$editBusinessProfileEp");
      final request = http.MultipartRequest('PUT', url); // Change method to PUT
      log("Created multipart request to URL: $url");

      // Add fields
      log("Adding fields to request");
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

      // Handle the logo (upload only if newLogo is true)
      if (newLogo) {
        log("Adding new logo file to request");
        request.files.add(await http.MultipartFile.fromPath(
          'logo',
          logo, // This should be the local file path from the new image
          contentType: MediaType('image', 'jpeg'), // Adjust MIME type as necessary
        ));
      } else {
        log("Using existing logo URL: $logo");
        request.fields['logo'] = logo; // Send the URL as a regular field if it's an existing logo
      }

      // Filter out gallery items that are listed in removeGalleryItems
      final filteredGallery = gallery.where((item) => !removeGalleryItems.contains(item)).toList();

      // Add filtered gallery images (URLs)
      log("Adding filtered gallery images to request");
      for (var i = 0; i < filteredGallery.length; i++) {
        final galleryUrl = filteredGallery[i];
        final fileName = 'gallery_$i.png'; // Create unique file name
        log("Downloading gallery image $i from $galleryUrl");
        final galleryFile = await downloadFile(galleryUrl, fileName);
        log("Gallery image $i downloaded: ${galleryFile.path}");

        request.files.add(await http.MultipartFile.fromPath(
          'gallery',
          galleryFile.path,
          contentType: MediaType('image', 'png'),
        ));
      }

      // Add newly picked media files from pickedMediaList
      log("Adding new media files to request");
      for (var i = 0; i < pickedMediaList.length; i++) {
        final media = pickedMediaList[i];
        final mediaFilePath = media['path'];
        log("Adding media file to request: $mediaFilePath");

        request.files.add(await http.MultipartFile.fromPath(
          'gallery',
          mediaFilePath,
          contentType: MediaType.parse(media['type']), // Use MIME type from the picked media
        ));
      }

      // Add removeGalleryItems field with URLs or IDs to be removed
      log("Adding removeGalleryItems data to request");
      request.fields['removeGalleryItems'] = json.encode(removeGalleryItems);

      // Set headers, including Authorization header
      log("Setting Authorization header");
      request.headers['Authorization'] = 'Bearer $token';

      // Send the request
      log("Sending request to: $url");
      final response = await request.send();
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);

      log("Response Status Code: ${response.statusCode}");
      log("Response Body: $responseString");

      // Handle response
      if (context.mounted) {
        if (response.statusCode == 200) {
          log("Business profile updated successfully");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Business profile updated successfully')),
          );
          log("Refreshing business profile");
          await getBusinessProfile(context: context, token: token);
          Navigator.of(context).pop();
        } else if (response.statusCode == 401) {
          log("Authentication token error");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Authentication token is required')),
          );
        } else {
          log("Unexpected status code: ${response.statusCode}");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Unexpected status code: $responseString')),
          );
        }
      }
    } catch (e) {
      log("Exception occurred: $e");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }
  //convert path
  Future<String> getLocalFilePath(String fileName) async {
    final directory = await getTemporaryDirectory();
    return '${directory.path}/$fileName';
  }

  Future<File> downloadFile(String localFilePath, String fileName) async {
    final filePath = await getLocalFilePath(fileName);

    try {
      final file = File(localFilePath);

      // Check if the source file exists
      if (await file.exists()) {
        // Copy the file to the new destination
        final newFile = await file.copy(filePath);
        return newFile;
      } else {
        throw Exception('Source file does not exist: $localFilePath');
      }
    } catch (e) {
      throw Exception('Failed to copy local file: $e');
    }
  }
}
