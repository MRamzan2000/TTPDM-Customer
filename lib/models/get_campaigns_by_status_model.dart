
import 'dart:convert';

GetCampaignsByStatusModel getCampaignsByStatusModelFromJson(String str) => GetCampaignsByStatusModel.fromJson(json.decode(str));

String getCampaignsByStatusModelToJson(GetCampaignsByStatusModel data) => json.encode(data.toJson());

class GetCampaignsByStatusModel {
  List<Campaign> campaigns;

  GetCampaignsByStatusModel({
    required this.campaigns,
  });

  GetCampaignsByStatusModel copyWith({
    List<Campaign>? campaigns,
  }) =>
      GetCampaignsByStatusModel(
        campaigns: campaigns ?? this.campaigns,
      );

  factory GetCampaignsByStatusModel.fromJson(Map<String, dynamic> json) => GetCampaignsByStatusModel(
    campaigns: List<Campaign>.from(json["campaigns"].map((x) => Campaign.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "campaigns": List<dynamic>.from(campaigns.map((x) => x.toJson())),
  };
}

class Campaign {
  DateSchedule dateSchedule;
  String id;
  String adBanner;
  Business business;
  String adsName;
  String campaignDesc;
  List<String> campaignPlatforms;
  String startTime;
  String endTime;
  String status;
  List<Analytics> analytics;
  int v;
  DateTime updatedAt;
  String? rejectionReason; // Add rejectionReason here

  Campaign({
    required this.dateSchedule,
    required this.id,
    required this.adBanner,
    required this.business,
    required this.adsName,
    required this.campaignDesc,
    required this.campaignPlatforms,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.analytics,
    required this.v,
    required this.updatedAt,
    this.rejectionReason, // Add rejectionReason here
  });

  Campaign copyWith({
    DateSchedule? dateSchedule,
    String? id,
    String? adBanner,
    Business? business,
    String? adsName,
    String? campaignDesc,
    List<String>? campaignPlatforms,
    String? startTime,
    String? endTime,
    String? status,
    List<Analytics>? analytics,
    int? v,
    DateTime? updatedAt,
    String? rejectionReason, // Add rejectionReason here
  }) =>
      Campaign(
        dateSchedule: dateSchedule ?? this.dateSchedule,
        id: id ?? this.id,
        adBanner: adBanner ?? this.adBanner,
        business: business ?? this.business,
        adsName: adsName ?? this.adsName,
        campaignDesc: campaignDesc ?? this.campaignDesc,
        campaignPlatforms: campaignPlatforms ?? this.campaignPlatforms,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        status: status ?? this.status,
        analytics: analytics ?? this.analytics,
        v: v ?? this.v,
        updatedAt: updatedAt ?? this.updatedAt,
        rejectionReason: rejectionReason ?? this.rejectionReason, // Add rejectionReason here
      );

  factory Campaign.fromJson(Map<String, dynamic> json) => Campaign(
    dateSchedule: DateSchedule.fromJson(json["dateSchedule"]),
    id: json["_id"],
    adBanner: json["adBanner"],
    business: Business.fromJson(json["business"]),
    adsName: json["adsName"],
    campaignDesc: json["campaignDesc"],
    campaignPlatforms: List<String>.from(json["campaignPlatforms"].map((x) => x)),
    startTime: json["startTime"],
    endTime: json["endTime"],
    status: json["status"],
    analytics: List<Analytics>.from(json["analytics"].map((x) => Analytics.fromJson(x))),
    v: json["__v"],
    updatedAt: DateTime.parse(json["updatedAt"]),
    rejectionReason: json["rejectionReason"], // Add rejectionReason here
  );

  Map<String, dynamic> toJson() => {
    "dateSchedule": dateSchedule.toJson(),
    "_id": id,
    "adBanner": adBanner,
    "business": business.toJson(),
    "adsName": adsName,
    "campaignDesc": campaignDesc,
    "campaignPlatforms": List<dynamic>.from(campaignPlatforms.map((x) => x)),
    "startTime": startTime,
    "endTime": endTime,
    "status": status,
    "analytics": List<dynamic>.from(analytics.map((x) => x.toJson())),
    "__v": v,
    "updatedAt": updatedAt.toIso8601String(),
    "rejectionReason": rejectionReason, // Add rejectionReason here
  };
}

class Analytics {
  DateTime date;
  int impressions;
  int clicks;
  String id;

  Analytics({
    required this.date,
    required this.impressions,
    required this.clicks,
    required this.id,
  });

  Analytics copyWith({
    DateTime? date,
    int? impressions,
    int? clicks,
    String? id,
  }) =>
      Analytics(
        date: date ?? this.date,
        impressions: impressions ?? this.impressions,
        clicks: clicks ?? this.clicks,
        id: id ?? this.id,
      );

  factory Analytics.fromJson(Map<String, dynamic> json) => Analytics(
    date: DateTime.parse(json["date"]),
    impressions: json["impressions"],
    clicks: json["clicks"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "date": date.toIso8601String(),
    "impressions": impressions,
    "clicks": clicks,
    "_id": id,
  };
}

class Business {
  String id;
  String name;
  String location;
  Owner owner;

  Business({
    required this.id,
    required this.name,
    required this.location,
    required this.owner,
  });

  Business copyWith({
    String? id,
    String? name,
    String? location,
    Owner? owner,
  }) =>
      Business(
        id: id ?? this.id,
        name: name ?? this.name,
        location: location ?? this.location,
        owner: owner ?? this.owner,
      );

  factory Business.fromJson(Map<String, dynamic> json) => Business(
    id: json["_id"],
    name: json["name"],
    location: json["location"],
    owner: Owner.fromJson(json["owner"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "location": location,
    "owner": owner.toJson(),
  };
}

class Owner {
  String id;
  String fullname;
  String email;

  Owner({
    required this.id,
    required this.fullname,
    required this.email,
  });

  Owner copyWith({
    String? id,
    String? fullname,
    String? email,
  }) =>
      Owner(
        id: id ?? this.id,
        fullname: fullname ?? this.fullname,
        email: email ?? this.email,
      );

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
    id: json["_id"],
    fullname: json["fullname"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullname": fullname,
    "email": email,
  };
}

class DateSchedule {
  DateTime startDate;
  DateTime endDate;

  DateSchedule({
    required this.startDate,
    required this.endDate,
  });

  DateSchedule copyWith({
    DateTime? startDate,
    DateTime? endDate,
  }) =>
      DateSchedule(
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
      );

  factory DateSchedule.fromJson(Map<String, dynamic> json) => DateSchedule(
    startDate: DateTime.parse(json["startDate"]),
    endDate: DateTime.parse(json["endDate"]),
  );

  Map<String, dynamic> toJson() => {
    "startDate": startDate.toIso8601String(),
    "endDate": endDate.toIso8601String(),
  };
}
