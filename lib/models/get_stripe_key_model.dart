
import 'dart:convert';

GetStripeKeyModel getStripeKeyModelFromJson(String str) => GetStripeKeyModel.fromJson(json.decode(str));

String getStripeKeyModelToJson(GetStripeKeyModel data) => json.encode(data.toJson());

class GetStripeKeyModel {
  String secretKey;

  GetStripeKeyModel({
    required this.secretKey,
  });

  GetStripeKeyModel copyWith({
    String? secretKey,
  }) =>
      GetStripeKeyModel(
        secretKey: secretKey ?? this.secretKey,
      );

  factory GetStripeKeyModel.fromJson(Map<String, dynamic> json) => GetStripeKeyModel(
    secretKey: json["secretKey"],
  );

  Map<String, dynamic> toJson() => {
    "secretKey": secretKey,
  };
}
