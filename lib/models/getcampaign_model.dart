// // To parse this JSON data, do
// //
// //     final getCampaignModel = getCampaignModelFromJson(jsonString);
//
// import 'dart:convert';
//
// GetCampaignModel getCampaignModelFromJson(String str) => GetCampaignModel.fromJson(json.decode(str));
//
// String getCampaignModelToJson(GetCampaignModel data) => json.encode(data.toJson());
//
// class GetCampaignModel {
//   List<Campaign> campaigns;
//
//   GetCampaignModel({
//     required this.campaigns,
//   });
//
//   factory GetCampaignModel.fromJson(Map<String, dynamic> json) => GetCampaignModel(
//     campaigns: List<Campaign>.from(json["campaigns"].map((x) => Campaign.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "campaigns": List<dynamic>.from(campaigns.map((x) => x.toJson())),
//   };
// }
//
// class Campaign {
//   DateSchedule dateSchedule;
//   String id;
//   String adBanner;
//   String business;
//   String adsName;
//   String websiteUrl;
//   String campaignDesc;
//   List<String> campaignPlatforms;
//   String startTime;
//   String endTime;
//   String status;
//   int v;
//
//   Campaign({
//     required this.dateSchedule,
//     required this.id,
//     required this.adBanner,
//     required this.business,
//     required this.adsName,
//     required this.websiteUrl,
//     required this.campaignDesc,
//     required this.campaignPlatforms,
//     required this.startTime,
//     required this.endTime,
//     required this.status,
//     required this.v,
//   });
//
//   factory Campaign.fromJson(Map<String, dynamic> json) => Campaign(
//     dateSchedule: DateSchedule.fromJson(json["dateSchedule"]),
//     id: json["_id"],
//     adBanner: json["adBanner"],
//     business: json["business"],
//     adsName: json["adsName"],
//     websiteUrl: json["websiteUrl"],
//     campaignDesc: json["campaignDesc"],
//     campaignPlatforms: List<String>.from(json["campaignPlatforms"].map((x) => x)),
//     startTime: json["startTime"],
//     endTime: json["endTime"],
//     status: json["status"],
//     v: json["__v"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "dateSchedule": dateSchedule.toJson(),
//     "_id": id,
//     "adBanner": adBanner,
//     "business": business,
//     "adsName": adsName,
//     "websiteUrl": websiteUrl,
//     "campaignDesc": campaignDesc,
//     "campaignPlatforms": List<dynamic>.from(campaignPlatforms.map((x) => x)),
//     "startTime": startTime,
//     "endTime": endTime,
//     "status": status,
//     "__v": v,
//   };
// }
//
// class DateSchedule {
//   DateTime startDate;
//   DateTime endDate;
//
//   DateSchedule({
//     required this.startDate,
//     required this.endDate,
//   });
//
//   factory DateSchedule.fromJson(Map<String, dynamic> json) => DateSchedule(
//     startDate: DateTime.parse(json["startDate"]),
//     endDate: DateTime.parse(json["endDate"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "startDate": startDate.toIso8601String(),
//     "endDate": endDate.toIso8601String(),
//   };
// }
