import 'dart:convert';

GetBusinessProfileModel getBusinessProfileModelFromJson(String str) => GetBusinessProfileModel.fromJson(json.decode(str));

String getBusinessProfileModelToJson(GetBusinessProfileModel data) => json.encode(data.toJson());

class GetBusinessProfileModel {
  List<Business> businesses;

  GetBusinessProfileModel({
    required this.businesses,
  });

  factory GetBusinessProfileModel.fromJson(Map<String, dynamic> json) => GetBusinessProfileModel(
    businesses: List<Business>.from(json["businesses"].map((x) => Business.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "businesses": List<dynamic>.from(businesses.map((x) => x.toJson())),
  };
}

class Business {
  String id;
  String name;
  String phone;
  String location;
  String targetMapArea;
  String description;
  List<String> gallery;
  String owner;
  String status;
  int v;
  String? logo;
  String? rejectionReason;
  String? websiteUrl;
  String? facebookUrl;
  String? instagramUrl;
  String? linkedinUrl;
  String? tiktokUrl;

  Business({
    required this.id,
    required this.name,
    required this.phone,
    required this.location,
    required this.targetMapArea,
    required this.description,
    required this.gallery,
    required this.owner,
    required this.status,
    required this.v,
    this.logo,
    this.rejectionReason,
    this.websiteUrl,
    this.facebookUrl,
    this.instagramUrl,
    this.linkedinUrl,
    this.tiktokUrl,
  });

  factory Business.fromJson(Map<String, dynamic> json) => Business(
    id: json["_id"],
    name: json["name"],
    phone: json["phone"],
    location: json["location"],
    targetMapArea: json["targetMapArea"],
    description: json["description"],
    gallery: List<String>.from(json["gallery"].map((x) => x)),
    owner: json["owner"],
    status: json["status"],
    v: json["__v"],
    logo: json["logo"],
    rejectionReason: json["rejectionReason"],
    websiteUrl: json["websiteUrl"], // Nullable field
    facebookUrl: json["facebookUrl"], // Nullable field
    instagramUrl: json["instagramUrl"], // Nullable field
    linkedinUrl: json["linkedinUrl"], // Nullable field
    tiktokUrl: json["tiktokUrl"], // Nullable field
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "phone": phone,
    "location": location,
    "targetMapArea": targetMapArea,
    "description": description,
    "gallery": List<dynamic>.from(gallery.map((x) => x)),
    "owner": owner,
    "status": status,
    "__v": v,
    "logo": logo,
    "rejectionReason": rejectionReason,
    "websiteUrl": websiteUrl,
    "facebookUrl": facebookUrl,
    "instagramUrl": instagramUrl,
    "linkedinUrl": linkedinUrl,
    "tiktokUrl": tiktokUrl,
  };
}
