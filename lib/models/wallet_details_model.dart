import 'dart:convert';

WalletDetailsModel walletDetailsModelFromJson(String str) => WalletDetailsModel.fromJson(json.decode(str));

String walletDetailsModelToJson(WalletDetailsModel data) => json.encode(data.toJson());

class WalletDetailsModel {
  double balance;
  Withdrawals withdrawals;

  WalletDetailsModel({
    required this.balance,
    required this.withdrawals,
  });

  WalletDetailsModel copyWith({
    double? balance,
    Withdrawals? withdrawals,
  }) =>
      WalletDetailsModel(
        balance: balance ?? this.balance,
        withdrawals: withdrawals ?? this.withdrawals,
      );

  factory WalletDetailsModel.fromJson(Map<String, dynamic> json) => WalletDetailsModel(
    balance: json["balance"]  is int
        ? (json["balance"] as int).toDouble()
        : json["balance"].toDouble(),
    withdrawals: Withdrawals.fromJson(json["withdrawals"]),
  );

  Map<String, dynamic> toJson() => {
    "balance": balance,
    "withdrawals": withdrawals.toJson(),
  };
}

class Withdrawals {
  List<Withdraw> approved;
  List<Withdraw> pending;

  Withdrawals({
    required this.approved,
    required this.pending,
  });

  Withdrawals copyWith({
    List<Withdraw>? approved,
    List<Withdraw>? pending,
  }) =>
      Withdrawals(
        approved: approved ?? this.approved,
        pending: pending ?? this.pending,
      );

  factory Withdrawals.fromJson(Map<String, dynamic> json) => Withdrawals(
    approved: List<Withdraw>.from(json["approved"].map((x) => Withdraw.fromJson(x))),
    pending: List<Withdraw>.from(json["pending"].map((x) => Withdraw.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "approved": List<dynamic>.from(approved.map((x) => x.toJson())),
    "pending": List<dynamic>.from(pending.map((x) => x.toJson())),
  };
}

class Withdraw {
  String messageType;
  String text;
  String bankName;
  String accountTitle;
  String iban;
  double amount; // Change to double to handle both int and double types
  String status;
  bool isRead;
  String sender;
  String id;
  DateTime createdAt;

  Withdraw({
    required this.messageType,
    required this.text,
    required this.bankName,
    required this.accountTitle,
    required this.iban,
    required this.amount,
    required this.status,
    required this.isRead,
    required this.sender,
    required this.id,
    required this.createdAt,
  });

  Withdraw copyWith({
    String? messageType,
    String? text,
    String? bankName,
    String? accountTitle,
    String? iban,
    double? amount, // Change to double to handle both int and double types
    String? status,
    bool? isRead,
    String? sender,
    String? id,
    DateTime? createdAt,
  }) =>
      Withdraw(
        messageType: messageType ?? this.messageType,
        text: text ?? this.text,
        bankName: bankName ?? this.bankName,
        accountTitle: accountTitle ?? this.accountTitle,
        iban: iban ?? this.iban,
        amount: amount ?? this.amount,
        status: status ?? this.status,
        isRead: isRead ?? this.isRead,
        sender: sender ?? this.sender,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
      );

  // Modify the fromJson factory to handle int or double for amount
  factory Withdraw.fromJson(Map<String, dynamic> json) => Withdraw(
    messageType: json["message_type"],
    text: json["text"],
    bankName: json["bank_name"],
    accountTitle: json["account_title"],
    iban: json["IBAN"],
    amount: json["amount"] is int
        ? (json["amount"] as int).toDouble()
        : json["amount"].toDouble(),
    status: json["status"],
    isRead: json["is_read"],
    sender: json["sender"],
    id: json["_id"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "message_type": messageType,
    "text": text,
    "bank_name": bankName,
    "account_title": accountTitle,
    "IBAN": iban,
    "amount": amount, // amount is now properly converted to double
    "status": status,
    "is_read": isRead,
    "sender": sender,
    "_id": id,
    "created_at": createdAt.toIso8601String(),
  };
}
