

import 'dart:convert';

import 'package:ttpdm/controller/utils/constants.dart';

GetUserProfileModel getUserProfileModelFromJson(String str) => GetUserProfileModel.fromJson(json.decode(str));

String getUserProfileModelToJson(GetUserProfileModel data) => json.encode(data.toJson());

class GetUserProfileModel {
  Subscription subscription;
  Permissions permissions;
  dynamic profilePic;
  dynamic fcmToken;
  String id;
  String fullname;
  String email;
  String phoneNumber;
  String confirmPassword;
  String role;
  List<dynamic> businesses;
  int coinBalance;
  int v;

  GetUserProfileModel({
    required this.subscription,
    required this.permissions,
    required this.profilePic,
    required this.fcmToken,
    required this.id,
    required this.fullname,
    required this.email,
    required this.phoneNumber,
    required this.confirmPassword,
    required this.role,
    required this.businesses,
    required this.coinBalance,
    required this.v,
  });

  GetUserProfileModel copyWith({
    Subscription? subscription,
    Permissions? permissions,
    dynamic profilePic,
    dynamic fcmToken,
    String? id,
    String? fullname,
    String? email,
    String? phoneNumber,
    String? confirmPassword,
    String? role,
    List<dynamic>? businesses,
    int? coinBalance,
    int? v,
  }) =>
      GetUserProfileModel(
        subscription: subscription ?? this.subscription,
        permissions: permissions ?? this.permissions,
        profilePic: profilePic ?? this.profilePic,
        fcmToken: fcmToken ?? this.fcmToken,
        id: id ?? this.id,
        fullname: fullname ?? this.fullname,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        role: role ?? this.role,
        businesses: businesses ?? this.businesses,
        coinBalance: coinBalance ?? this.coinBalance,
        v: v ?? this.v,
      );

  factory GetUserProfileModel.fromJson(Map<String, dynamic> json) => GetUserProfileModel(
    subscription: Subscription.fromJson(json["subscription"]),
    permissions: Permissions.fromJson(json["permissions"]),
    profilePic: json["profilePic"]??placeHolderImage,
    fcmToken: json["fcmToken"],
    id: json["_id"],
    fullname: json["fullname"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
    confirmPassword: json["confirmPassword"],
    role: json["role"],
    businesses: List<dynamic>.from(json["businesses"].map((x) => x)),
    coinBalance: json["coinBalance"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "subscription": subscription.toJson(),
    "permissions": permissions.toJson(),
    "profilePic": profilePic,
    "fcmToken": fcmToken,
    "_id": id,
    "fullname": fullname,
    "email": email,
    "phoneNumber": phoneNumber,
    "confirmPassword": confirmPassword,
    "role": role,
    "businesses": List<dynamic>.from(businesses.map((x) => x)),
    "coinBalance": coinBalance,
    "__v": v,
  };
}

class Permissions {
  AdBannerDesigns campaigns;
  AdBannerDesigns businesses;
  AdBannerDesigns adBannerDesigns;

  Permissions({
    required this.campaigns,
    required this.businesses,
    required this.adBannerDesigns,
  });

  Permissions copyWith({
    AdBannerDesigns? campaigns,
    AdBannerDesigns? businesses,
    AdBannerDesigns? adBannerDesigns,
  }) =>
      Permissions(
        campaigns: campaigns ?? this.campaigns,
        businesses: businesses ?? this.businesses,
        adBannerDesigns: adBannerDesigns ?? this.adBannerDesigns,
      );

  factory Permissions.fromJson(Map<String, dynamic> json) => Permissions(
    campaigns: AdBannerDesigns.fromJson(json["campaigns"]),
    businesses: AdBannerDesigns.fromJson(json["businesses"]),
    adBannerDesigns: AdBannerDesigns.fromJson(json["adBannerDesigns"]),
  );

  Map<String, dynamic> toJson() => {
    "campaigns": campaigns.toJson(),
    "businesses": businesses.toJson(),
    "adBannerDesigns": adBannerDesigns.toJson(),
  };
}

class AdBannerDesigns {
  bool manage;

  AdBannerDesigns({
    required this.manage,
  });

  AdBannerDesigns copyWith({
    bool? manage,
  }) =>
      AdBannerDesigns(
        manage: manage ?? this.manage,
      );

  factory AdBannerDesigns.fromJson(Map<String, dynamic> json) => AdBannerDesigns(
    manage: json["manage"],
  );

  Map<String, dynamic> toJson() => {
    "manage": manage,
  };
}

class Subscription {
  dynamic startDate;

  Subscription({
    required this.startDate,
  });

  Subscription copyWith({
    dynamic startDate,
  }) =>
      Subscription(
        startDate: startDate ?? this.startDate,
      );

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
    startDate: json["startDate"],
  );

  Map<String, dynamic> toJson() => {
    "startDate": startDate,
  };
}
