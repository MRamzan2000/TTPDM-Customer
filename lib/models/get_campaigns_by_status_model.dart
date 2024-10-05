import 'dart:convert';
import 'package:http/http.dart' as http;

GetCampaignsByStatusModel getCampaignsByStatusModelFromJson(String str) =>
    GetCampaignsByStatusModel.fromJson(json.decode(str));

String getCampaignsByStatusModelToJson(GetCampaignsByStatusModel data) =>
    json.encode(data.toJson());

class GetCampaignsByStatusModel {
  List<Campaign> campaigns;

  GetCampaignsByStatusModel({
    required this.campaigns,
  });

  factory GetCampaignsByStatusModel.fromJson(Map<String, dynamic> json) =>
      GetCampaignsByStatusModel(
        campaigns: List<Campaign>.from(
            json["campaigns"].map((x) => Campaign.fromJson(x))),
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
  int cost;
  List<Analytics> analytics;
  DateTime createdAt;
  DateTime updatedAt;
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
    required this.cost,
    required this.analytics,
    required this.createdAt,
    required this.updatedAt,
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
    cost: (json["cost"] is int) ? json["cost"] : (json["cost"] as double).toInt(), // Handle type conversion
    analytics: List<Analytics>.from(json["analytics"].map((x) => Analytics.fromJson(x))),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
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
    "cost": cost,
    "analytics": List<dynamic>.from(analytics.map((x) => x.toJson())),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
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

  factory DateSchedule.fromJson(Map<String, dynamic> json) => DateSchedule(
    startDate: DateTime.parse(json["startDate"]),
    endDate: DateTime.parse(json["endDate"]),
  );

  Map<String, dynamic> toJson() => {
    "startDate": startDate.toIso8601String(),
    "endDate": endDate.toIso8601String(),
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
    clicks: json["clicks"] is int ? json["clicks"] : (json["clicks"] as double).toInt(),
    impressions: json["impressions"] is int ? json["impressions"] : (json["impressions"] as double).toInt(),
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "date": date.toIso8601String(),
    "clicks": clicks,
    "impressions": impressions,
  };
}

// Function to fetch campaigns
Future<void> fetchCampaigns() async {
  try {
    final response = await http.get(Uri.parse('https://api.yourservice.com/campaigns/status'));

    if (response.statusCode == 200) {
      final campaigns = getCampaignsByStatusModelFromJson(response.body);
      // Process your campaigns
      print('Fetched campaigns: ${campaigns.campaigns}');
    } else {
      final errorResponse = json.decode(response.body);
      throw Exception(errorResponse['message']); // Handle the error message
    }
  } catch (e) {
    print('Error fetching campaigns: $e');
    // Handle your error UI/logic here
  }
}
