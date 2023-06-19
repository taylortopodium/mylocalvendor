// To parse this JSON data, do
//
//     final chatListData = chatListDataFromJson(jsonString);

import 'dart:convert';

ChatListData chatListDataFromJson(String str) => ChatListData.fromJson(json.decode(str));

String chatListDataToJson(ChatListData data) => json.encode(data.toJson());

class ChatListData {
  ChatListData({
    required this.status,
    required this.msg,
    required this.data,
  });

  bool status;
  String msg;
  List<ChatListDatum> data;

  factory ChatListData.fromJson(Map<String, dynamic> json) => ChatListData(
    status: json["status"],
    msg: json["msg"],
    data: List<ChatListDatum>.from(json["data"].map((x) => ChatListDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ChatListDatum {
  ChatListDatum({
    required this.id,
    required this.name,
    required this.image,
  });

  int id;
  String name;
  String image;

  factory ChatListDatum.fromJson(Map<String, dynamic> json) => ChatListDatum(
    id: json["id"],
    name: json["name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
  };
}
