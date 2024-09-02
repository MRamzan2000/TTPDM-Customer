// To parse this JSON data, do
//
//     final getAllDesignsModel = getAllDesignsModelFromJson(jsonString);

import 'dart:convert';

GetAllDesignsModel getAllDesignsModelFromJson(String str) => GetAllDesignsModel.fromJson(json.decode(str));

String getAllDesignsModelToJson(GetAllDesignsModel data) => json.encode(data.toJson());

class GetAllDesignsModel {
  List<Design> designs;

  GetAllDesignsModel({
    required this.designs,
  });

  factory GetAllDesignsModel.fromJson(Map<String, dynamic> json) => GetAllDesignsModel(
    designs: List<Design>.from(json["designs"].map((x) => Design.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "designs": List<dynamic>.from(designs.map((x) => x.toJson())),
  };
}

class Design {
  String id;
  String fileUrl;
  UploadedBy uploadedBy;
  DateTime uploadDate;
  int v;

  Design({
    required this.id,
    required this.fileUrl,
    required this.uploadedBy,
    required this.uploadDate,
    required this.v,
  });

  factory Design.fromJson(Map<String, dynamic> json) => Design(
    id: json["_id"],
    fileUrl: json["fileUrl"],
    uploadedBy: UploadedBy.fromJson(json["uploadedBy"]),
    uploadDate: DateTime.parse(json["uploadDate"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fileUrl": fileUrl,
    "uploadedBy": uploadedBy.toJson(),
    "uploadDate": uploadDate.toIso8601String(),
    "__v": v,
  };
}

class UploadedBy {
  String id;
  String fullname;
  String email;

  UploadedBy({
    required this.id,
    required this.fullname,
    required this.email,
  });

  factory UploadedBy.fromJson(Map<String, dynamic> json) => UploadedBy(
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
