// To parse this JSON data, do
//
//     final notificationData = notificationDataFromJson(jsonString);

import 'dart:convert';

NotificationData notificationDataFromJson(String str) => NotificationData.fromJson(json.decode(str));

String notificationDataToJson(NotificationData data) => json.encode(data.toJson());

class NotificationData {
  NotificationData({
    required this.status,
    required this.msg,
    required this.data,
  });

  bool status;
  String msg;
  List<Datum> data;

  factory NotificationData.fromJson(Map<String, dynamic> json) => NotificationData(
    status: json["status"],
    msg: json["msg"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.title,
    required this.description,
    required this.notificationType,
    required this.isRead,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.timeToCreate,
    required this.sender,
  });

  int id;
  int senderId;
  int receiverId;
  dynamic title;
  String description;
  String notificationType;
  int isRead;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  String timeToCreate;
  Sender sender;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    senderId: json["sender_id"],
    receiverId: json["receiver_id"],
    title: json["title"],
    description: json["description"],
    notificationType: json["notification_type"],
    isRead: json["is_read"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    timeToCreate: json["time_to_create"],
    sender: Sender.fromJson(json["sender"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sender_id": senderId,
    "receiver_id": receiverId,
    "title": title,
    "description": description,
    "notification_type": notificationType,
    "is_read": isRead,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "time_to_create": timeToCreate,
    "sender": sender.toJson(),
  };
}

class Sender {
  Sender({
    required this.id,
    required this.name,
    required this.image,
    required this.rating,
    required this.status,
  });

  int id;
  String name;
  String image;
  dynamic rating;
  int status;

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    rating: json["rating"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "rating": rating,
    "status": status,
  };
}
