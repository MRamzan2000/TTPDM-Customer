import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttpdm/controller/apis_services/get_campaign_rules_api.dart';
import 'package:ttpdm/models/get_campaign_rules_model.dart';

class CampaignRuleController extends GetxController {
  final BuildContext context;
  CampaignRuleController({required this.context});
  //Get Campaign Rules
  Rxn<GetCampaignRulesModel?> allRules = Rxn<GetCampaignRulesModel?>();
  RxBool rulesLoading = true.obs;
  Future<void> fetchCampaignRules({required bool isLoading}) async {
    try {
      rulesLoading.value = true; // Set loading to true at the beginning
      allRules.value = await CampaignRulesApi(context: context).getCampaignRulesApi();
    } catch (e) {
      log("Unexpected error occurred: ${e.toString()}");

      // Show an error message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } finally {
      rulesLoading.value = false; // Ensure loading is set to false in the finally block
    }
  }
}
