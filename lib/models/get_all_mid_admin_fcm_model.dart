
import 'dart:convert';

GetAllMidAdminFcmModel getAllMidAdminFcmModelFromJson(String str) => GetAllMidAdminFcmModel.fromJson(json.decode(str));

String getAllMidAdminFcmModelToJson(GetAllMidAdminFcmModel data) => json.encode(data.toJson());

class GetAllMidAdminFcmModel {
  String message;
  List<String> tokens;

  GetAllMidAdminFcmModel({
    required this.message,
    required this.tokens,
  });

  GetAllMidAdminFcmModel copyWith({
    String? message,
    List<String>? tokens,
  }) =>
      GetAllMidAdminFcmModel(
        message: message ?? this.message,
        tokens: tokens ?? this.tokens,
      );

  factory GetAllMidAdminFcmModel.fromJson(Map<String, dynamic> json) => GetAllMidAdminFcmModel(
    message: json["message"],
    tokens: List<String>.from(json["tokens"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "tokens": List<dynamic>.from(tokens.map((x) => x)),
  };
}
