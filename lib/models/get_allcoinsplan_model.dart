// To parse this JSON data, do
//
//     final getAllCoinsPlan = getAllCoinsPlanFromJson(jsonString);

import 'dart:convert';

List<GetAllCoinsPlan> getAllCoinsPlanFromJson(String str) => List<GetAllCoinsPlan>.from(json.decode(str).map((x) => GetAllCoinsPlan.fromJson(x)));

String getAllCoinsPlanToJson(List<GetAllCoinsPlan> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllCoinsPlan {
  String id;
  int amount;
  int priceInCents;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  GetAllCoinsPlan({
    required this.id,
    required this.amount,
    required this.priceInCents,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory GetAllCoinsPlan.fromJson(Map<String, dynamic> json) => GetAllCoinsPlan(
    id: json["_id"],
    amount: json["amount"],
    priceInCents: json["priceInCents"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "amount": amount,
    "priceInCents": priceInCents,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
