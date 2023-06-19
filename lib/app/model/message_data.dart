// To parse this JSON data, do
//
//     final messageData = messageDataFromJson(jsonString);

import 'dart:convert';

MessageData messageDataFromJson(String str) => MessageData.fromJson(json.decode(str));

String messageDataToJson(MessageData data) => json.encode(data.toJson());

class MessageData {
  MessageData({
    required this.status,
    required this.msg,
    required this.data,
  });

  bool status;
  String msg;
  Data data;

  factory MessageData.fromJson(Map<String, dynamic> json) => MessageData(
    status: json["status"],
    msg: json["msg"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.data,
    required this.total,
    required this.count,
    required this.perPage,
    required this.currentPage,
    required this.lastPage,
    required this.is_sender_blocked,
    required this.is_receiver_blocked,
  });

  List<MessageDatum> data;
  int total;
  int count;
  int perPage;
  int currentPage;
  int lastPage;
  bool is_sender_blocked;
  bool is_receiver_blocked;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    data: List<MessageDatum>.from(json["data"].map((x) => MessageDatum.fromJson(x))),
    total: json["total"],
    count: json["count"],
    perPage: json["per_page"],
    currentPage: json["current_page"],
    lastPage: json["last_page"],
    is_sender_blocked: json["is_sender_blocked"],
    is_receiver_blocked: json["is_receiver_blocked"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "total": total,
    "count": count,
    "per_page": perPage,
    "current_page": currentPage,
    "last_page": lastPage,
    "is_sender_blocked": is_sender_blocked,
    "is_receiver_blocked": is_receiver_blocked,
  };
}

class MessageDatum {
  MessageDatum({
    required this.id,
    required this.senderId,
    required this.body,
    required this.conversationId,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int senderId;
  String body;
  int conversationId;
  int isRead;
  String createdAt;
  String updatedAt;

  factory MessageDatum.fromJson(Map<String, dynamic> json) => MessageDatum(
    id: json["id"],
    senderId: json["sender_id"],
    body: json["body"],
    conversationId: json["conversation_id"],
    isRead: json["is_read"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sender_id": senderId,
    "body": body,
    "conversation_id": conversationId,
    "is_read": isRead,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
