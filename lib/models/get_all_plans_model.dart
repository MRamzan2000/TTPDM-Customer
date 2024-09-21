
import 'dart:convert';

List<GetAllPlansModel> getAllPlansModelFromJson(String str) => List<GetAllPlansModel>.from(json.decode(str).map((x) => GetAllPlansModel.fromJson(x)));

String getAllPlansModelToJson(List<GetAllPlansModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllPlansModel {
  String id;
  String name;
  int price;
  int businessLimit;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  GetAllPlansModel({
    required this.id,
    required this.name,
    required this.price,
    required this.businessLimit,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  GetAllPlansModel copyWith({
    String? id,
    String? name,
    int? price,
    int? businessLimit,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) =>
      GetAllPlansModel(
        id: id ?? this.id,
        name: name ?? this.name,
        price: price ?? this.price,
        businessLimit: businessLimit ?? this.businessLimit,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  factory GetAllPlansModel.fromJson(Map<String, dynamic> json) => GetAllPlansModel(
    id: json["_id"],
    name: json["name"],
    price: json["price"],
    businessLimit: json["businessLimit"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "price": price,
    "businessLimit": businessLimit,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
