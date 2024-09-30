// To parse this JSON data, do
//
//     final chatDetailsModel = chatDetailsModelFromJson(jsonString);

import 'dart:convert';

List<ChatDetailsModel> chatDetailsModelFromJson(String str) =>
    List<ChatDetailsModel>.from(
        json.decode(str).map((x) => ChatDetailsModel.fromJson(x)));

String chatDetailsModelToJson(List<ChatDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChatDetailsModel {
  String id;
  MessageType messageType;
  String text;
  String bankName;
  String accountTitle;
  String iban;
  int amount;
  Status status;
  bool isRead;
  Sender sender;
  DateTime createdAt;

  ChatDetailsModel({
    required this.id,
    required this.messageType,
    required this.text,
    required this.bankName,
    required this.accountTitle,
    required this.iban,
    required this.amount,
    required this.status,
    required this.isRead,
    required this.sender,
    required this.createdAt,
  });

  factory ChatDetailsModel.fromJson(Map<String, dynamic> json) =>
      ChatDetailsModel(
        id: json["_id"] ?? '',
        messageType: messageTypeValues.map[json["message_type"]]!,
        text: json["text"] ?? 'Ar',
        bankName: json["bank_name"] ?? '',
        accountTitle: json["account_title"] ?? '',
        iban: json["IBAN"] ?? '',
        amount: json["amount"] ?? 0,
        status: statusValues.map[json["status"]]!,
        isRead: json["is_read"],
        sender: senderValues.map[json["sender"]]!,
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "message_type": messageTypeValues.reverse[messageType],
    "text": text,
    "bank_name": bankName,
    "account_title": accountTitle,
    "IBAN": iban,
    "amount": amount,
    "status": statusValues.reverse[status],
    "is_read": isRead,
    "sender": senderValues.reverse[sender],
    "created_at": createdAt.toIso8601String(),
  };
}

enum MessageType { MESSAGE, WITHDRAW }

final messageTypeValues = EnumValues(
    {"message": MessageType.MESSAGE, "withdraw": MessageType.WITHDRAW});

enum Sender { ADMIN, USER }

final senderValues = EnumValues({"admin": Sender.ADMIN, "user": Sender.USER});

enum Status { CONFIRMED, PENDING }

final statusValues =
EnumValues({"confirmed": Status.CONFIRMED, "pending": Status.PENDING});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
