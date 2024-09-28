import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm/controller/custom_widgets/app_colors.dart';
const baseUrl='https://advyro-efeje5atfcd3hrbq.canadacentral-01.azurewebsites.net/';
const signUpEndP="user/register";
const signInEndP="user/login";
const verifyOtpEp="user/verify-otp";
const forgetPasswordEp="user/forgot-password";
const setBusinessProfileEp="business/add-business";
const getBusinessProfileEp="business/my-businesses";
const editBusinessProfileEp="business/edit";
const getDesignRequestEp="campaign/request-designs";
const deleteBusinessProfileEp="business/delete-business";
const addCampaignEp="campaign/add";
const getCampaignEp="campaign/business";
const getCampaignByStatusEp="midAdmin/campaigns";
const campaignFeeEp="campaign/pay-fee";
const cancelCampaignEp="campaign/cancel";
const subscriptionEp="business/select-plan";
const confirmSubscriptionPaymentEp="business/payment-success?plan=";
const getAllDesignsEP="campaign/allDesigns";
const getAllCoinsEP="coin/coin-balance";
const getAllCoinsPlanEP="superAdmin/allCoins";
const purchaseCoinsEP="coin/purchase-coins";
const resetPasswordEp="user/reset-password";
const getUserProfileEp="user";
const updateUserProfileEp="user/profile-pic";
const deleteUserProfileEp="user/delUser";
const getAllSubPlanEP="superAdmin/allPlans";
const likeDesignEp="campaign/";
const getFcmTokenEP="fcm-token";
const sendNotificationEp="user/send-notification";
const getStripeKeyEp="stripe/get";
const editDesignEp="campaign/editDesign";
const walletDetailsEP="wallet";
const walletWithdrawRequestEP="wallet/withdraw";
const getChatDetailEp="chat/";
const sendMessageEp="chat/send-admin-message";

final spinkit = Container(
  alignment: Alignment.centerLeft,
  height: 3.h,

  child: SpinKitThreeBounce(
    size: 3.h,

    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:  AppColors.whiteColor
        ),
      );
    },
  ),
);

 final spinkit1 =  Center(
  child: SpinKitWaveSpinner(
    color: AppColors.mainColor,
    size: 30.h,
  )
  ,
);

final internetLoading =  Center(
  child: SpinKitRotatingCircle(
    color: AppColors.mainColor,
    size: 30.h,
  )
  ,
);