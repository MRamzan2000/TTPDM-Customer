import 'dart:convert';

GetAllCoins getAllCoinsFromJson(String str) => GetAllCoins.fromJson(json.decode(str));

String getAllCoinsToJson(GetAllCoins data) => json.encode(data.toJson());

class GetAllCoins {
  int coinBalance;

  GetAllCoins({
    required this.coinBalance,
  });

  factory GetAllCoins.fromJson(Map<String, dynamic> json) => GetAllCoins(
    coinBalance: json["coinBalance"],
  );

  Map<String, dynamic> toJson() => {
    "coinBalance": coinBalance,
  };
}
