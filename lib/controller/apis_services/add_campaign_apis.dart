import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ttpdm/controller/utils/apis_constant.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:ttpdm/controller/utils/my_shared_prefrence.dart';
import 'package:ttpdm/controller/utils/preference_key.dart';

import '../../models/get_campaigns_by_status_model.dart';

class AddCampaignApis {
  Future<void> addCampaignApi({
    required String businessId,
    required String adsName,
    required String campaignDesc,
    required String campaignPlatforms,
    required String startDate,
    required String endDate,
    required String startTime,
    required String endTime,
    required String adBannerUrl,
    required String token,
    required String cost,
    required BuildContext context,
  }) async {
    try {
      const fileName =
          'adBanner.png';
      final downloadedFile = await downloadFile(adBannerUrl, fileName);

      final url = Uri.parse("$baseUrl/$addCampaignEp");
      final request = http.MultipartRequest('POST', url);
      request.fields["businessId"] = businessId;
      request.fields["adsName"] = adsName;
      request.fields["campaignDesc"] = campaignDesc;
      request.fields["campaignPlatforms"] = campaignPlatforms;
      request.fields["startDate"] = startDate;
      request.fields["endDate"] = endDate;
      request.fields["startTime"] = startTime;
      request.fields["endTime"] = endTime;
      request.fields["cost"] = cost;
      request.files.add(await http.MultipartFile.fromPath(
        'adBanner',
        downloadedFile.path,
        contentType: MediaType('image', 'png'), // Adjust if needed
      ));
      request.headers['Authorization'] = 'Bearer $token';

      final response = await request.send();
      final responseData = await response.stream.toBytes();
      final resPonDingString = String.fromCharCodes(responseData);

      if (response.statusCode == 201) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Add BusinessCampaign successfully')),
          );
          log('Add BusinessCampaign successfully');
        }
      } else if (response.statusCode == 400) {
        Map<String, dynamic> responseBody = jsonDecode(resPonDingString);
        if (context.mounted) {
          String errorMessage = responseBody['errors'].isNotEmpty
              ? responseBody['errors'].first['msg']
              : 'An error occurred';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMessage)),
          );
          log('An error occurred :$errorMessage');
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Unexpected status code: $resPonDingString')),
          );
          log('Unexpected status code :$resPonDingString');
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Something went wrong: ${e.toString()}')),
        );
        log("An unexpected error occurred ${e.toString()}");
      }
    }
  }

  Future<String> getLocalFilePath(String fileName) async {
    final directory =
        await getTemporaryDirectory(); // Use getApplicationDocumentsDirectory() if you need persistence
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


  Future<void> payCampaignFee({required context,required String token}) async {
    final url = Uri.parse("$baseUrl/$campaignFeeEp");
    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    try {
      final response = await http.post(url, headers: headers);
      if (response.statusCode == 200) {
        Map<String ,dynamic>responseBody=jsonDecode(response.body);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar( SnackBar(
              content: Text(responseBody["message"])));
        }
      } else if (response.statusCode == 500) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Cast to ObjectId failed for value')));
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

  //Campaign Cancel
  Future<void> cancelCampaign({required String token, required context}) async {
    final url = Uri.parse("$baseUrl/$campaignFeeEp");
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };
    try {
      final response = await http.put(url, headers: headers);
      if (response.statusCode == 200) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Your campaign cancel successfully')));
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

  //get business design Request
  Future<void> getDesignRequest(
      {required String description,
      required String token,
      required String businessId,
      required context}) async {
    final url = Uri.parse("$baseUrl/$getDesignRequestEp");
    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    final body = jsonEncode({
      "description": description,
      "businessId":businessId,
    });
    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 201) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Design request submitted successfully')));
        }
        Get.back();
      } else if (response.statusCode == 401) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Authentication token is required')));
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



  //getCampaignByStatus
  Future<GetCampaignsByStatusModel?> getCampaignByStatus({
    required String status,
  }) async {
    final url = Uri.parse("$baseUrl/$getCampaignByStatusEp/$status");
    final headers = {
      'Content-Type': 'application/json',
    };
    try {
      final response = await http.get(url, headers: headers);

      // Debug prints
      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        log('fetching campaign by status: ${response.body}');

        // Parse the response into the model
        GetCampaignsByStatusModel allCampaigns = getCampaignsByStatusModelFromJson(response.body);

        // Filter the campaigns where the owner ID matches the user ID
        String userId = MySharedPreferences.getString(userIdKey);
        List<Campaign> filteredCampaigns = allCampaigns.campaigns.where((campaign) {
          return campaign.business.owner.id == userId;
        }).toList();

        // Return a new model with the filtered campaigns
        return GetCampaignsByStatusModel(campaigns: filteredCampaigns);
      } else {
        log('Error fetching campaigns: ${response.body}');
        return null;
      }
    } catch (e) {
      log('Unexpected Error fetching campaigns: ${e.toString()}');
      return null;
    }
  }
}
