// To parse this JSON data, do
//
//     final cardListData = cardListDataFromJson(jsonString);

import 'dart:convert';

CardListData cardListDataFromJson(String str) => CardListData.fromJson(json.decode(str));

String cardListDataToJson(CardListData data) => json.encode(data.toJson());

class CardListData {
  CardListData({
    required this.status,
    required this.msg,
    required this.data,
  });

  bool status;
  String msg;
  List<CardListDatum> data;

  factory CardListData.fromJson(Map<String, dynamic> json) => CardListData(
    status: json["status"],
    msg: json["msg"],
    data: List<CardListDatum>.from(json["data"].map((x) => CardListDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class CardListDatum {
  CardListDatum({
    required this.id,
    required this.userId,
    required this.name,
    required this.cardNumber,
    required this.expiryDate,
    required this.securityCode,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int userId;
  String name;
  String cardNumber;
  String expiryDate;
  String securityCode;
  int status;
  String createdAt;
  String updatedAt;

  factory CardListDatum.fromJson(Map<String, dynamic> json) => CardListDatum(
    id: json["id"],
    userId: json["user_id"],
    name: json["name"],
    cardNumber: json["card_number"],
    expiryDate: json["expiry_date"],
    securityCode: json["security_code"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "name": name,
    "card_number": cardNumber,
    "expiry_date": expiryDate,
    "security_code": securityCode,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
