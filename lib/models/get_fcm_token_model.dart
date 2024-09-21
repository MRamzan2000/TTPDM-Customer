
import 'dart:convert';

GetFcmTokenModel getFcmTokenModelFromJson(String str) => GetFcmTokenModel.fromJson(json.decode(str));

String getFcmTokenModelToJson(GetFcmTokenModel data) => json.encode(data.toJson());

class GetFcmTokenModel {
  String fcmToken;

  GetFcmTokenModel({
    required this.fcmToken,
  });

  GetFcmTokenModel copyWith({
    String? fcmToken,
  }) =>
      GetFcmTokenModel(
        fcmToken: fcmToken ?? this.fcmToken,
      );

  factory GetFcmTokenModel.fromJson(Map<String, dynamic> json) => GetFcmTokenModel(
    fcmToken: json["fcmToken"],
  );

  Map<String, dynamic> toJson() => {
    "fcmToken": fcmToken,
  };
}
