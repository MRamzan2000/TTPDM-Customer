import 'dart:convert';

GetCampaignsByStatusModel getCampaignByStatusModelFromJson(String str) => GetCampaignsByStatusModel.fromJson(json.decode(str));

String getCampaignByStatusModelToJson(GetCampaignsByStatusModel data) => json.encode(data.toJson());

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
  List<Analytics> analytics; // Update type here
  int v;

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
    required this.analytics, // Update type here
    required this.v,
  });

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
    analytics: List<Analytics>.from(json["analytics"].map((x) => Analytics.fromJson(x))), // Update parsing here
    v: json["__v"],
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
    "analytics": List<dynamic>.from(analytics.map((x) => x.toJson())), // Update serialization here
    "__v": v,
  };
}
class Analytics {
  DateTime date;
  int clicks;
  int impressions;
  String id;

  Analytics({
    required this.date,
    required this.clicks,
    required this.impressions,
    required this.id,
  });

  factory Analytics.fromJson(Map<String, dynamic> json) => Analytics(
    date: DateTime.parse(json["date"]),
    clicks: json["clicks"],
    impressions: json["impressions"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "date": date.toIso8601String(),
    "clicks": clicks,
    "impressions": impressions,
  };
}

class Business {
  String id;
  String name;
  String location;

  Business({
    required this.id,
    required this.name,
    required this.location,
  });

  Business copyWith({
    String? id,
    String? name,
    String? location,
  }) =>
      Business(
        id: id ?? this.id,
        name: name ?? this.name,
        location: location ?? this.location,
      );

  factory Business.fromJson(Map<String, dynamic> json) => Business(
    id: json["_id"],
    name: json["name"],
    location: json["location"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "location": location,
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
