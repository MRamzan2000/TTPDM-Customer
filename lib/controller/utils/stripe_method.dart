import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ttpdm/controller/getx_controllers/subcription_controller.dart';
import 'package:ttpdm/view/screens/bottom_navigationbar.dart';

import 'alert_box.dart';

class StripePayments {
  final BuildContext context;
  double amount;
  String clientSecretKey;
  String token;
  String plan;
  String businessId;
      String businessName;
  String campaignName;
      String campaignDescription;
   File selectedPoster;
   String campaignPlatForms;
   String startDate;
   String endDate;
   String startTime;
   String endTime;

  StripePayments.name(this.amount,
  {
   required  this.clientSecretKey,
   required  this.context,
   required  this.token,
   required  this.endTime,
    required this.startTime,
   required  this.campaignPlatForms,
   required  this.businessId,
   required  this.startDate,
  required   this.businessName,
   required  this.campaignDescription,
   required  this.plan,
  required   this.campaignName,
   required  this.endDate,
  required   this.selectedPoster,
  }
      );

  final SubscriptionController subscriptionController = Get.put(SubscriptionController());
  Map<String, dynamic> paymentIntent = {};
  String publishableKey = "pk_test_51PWFAtRsuZrhcR6RkiVOIRrb6Nfhw9f8alHztCUuBZBSaBU6VHzlbpS2E4PaVcQF6VLDI66X5YKjnCJYkVCorioY00cQAyLk2R";

  Future<void> startPayment() async {
    Stripe.publishableKey = publishableKey;
    Stripe.merchantIdentifier = 'MerchantIdentifier';
    await setupPaymentIntent(token: token, plan: plan);
  }

  Future<void> setupPaymentIntent({required String token, required String plan}) async {
    log("Setting up payment intent");
    try {
      final body = {
        "currency": "USD",
        "amount": (amount * 100).toInt().toString(),
      };

      final response = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        body: body,
        headers: {
          "Authorization": "Bearer $clientSecretKey",
          "Content-Type": "application/x-www-form-urlencoded",
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        paymentIntent = responseBody;
        await setIntentData();
        await displayPaymentSheet(token: token, plan: plan);
      } else {
        log("Failed to create payment intent: ${response.body}");
        throw Exception("Failed to create payment intent");
      }
    } catch (e) {
      log("Error setting up payment intent: $e");
      throw Exception("Error setting up payment intent: $e");
    }
  }

  Future<void> setIntentData() async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntent["client_secret"],
        style: ThemeMode.system,
        merchantDisplayName: "Khan",
      ),
    );
  }

  Future<void> displayPaymentSheet({required String token, required String plan}) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      log("Payment successful!");

      // Call confirmPayment only after successful payment
      if(plan=="no plan"){
       await addCampaignController
            .submitCampaign(
            businessId: businessId,
            adsName:campaignName,
            campaignDesc: campaignDescription,
            campaignPlatforms:campaignPlatForms,
            startDate: startDate,
            endDate:endDate,
            startTime: startTime,
            endTime: endTime,
            adBanner: selectedPoster.path,
            token: token,
            context: context)
            .then(
              (value) {
            Get.to(() => const CustomBottomNavigationBar());
          },
        ); }
      else{
        await subscriptionController.confirmPayment(context: context, plan: plan, token: token);
      }
      Get.to(()=>const CustomBottomNavigationBar());
    } on StripeException catch (e) {
      log("Stripe error: ${e.toString()}");
    } catch (e) {
      log("General error displaying payment sheet: $e");
    }
  }
}
