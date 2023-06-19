// To parse this JSON data, do
//
//     final authData = authDataFromJson(jsonString);

import 'dart:convert';

AuthData authDataFromJson(String str) => AuthData.fromJson(json.decode(str));

String authDataToJson(AuthData data) => json.encode(data.toJson());

class AuthData {
  AuthData({
    required this.status,
    required this.token,
    required this.data,
  });

  bool status;
  String token;
  Data data;

  factory AuthData.fromJson(Map<String, dynamic> json) => AuthData(
    status: json["status"],
    token: json["token"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "token": token,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.id,
    required this.name,
    required this.email,
    required this.mobileNo,
    required this.image,
    required this.emailVerifiedAt,
    required this.address,
    required this.city,
    required this.about,
    required this.rating,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  dynamic email;
  dynamic mobileNo;
  String image;
  dynamic emailVerifiedAt;
  dynamic address;
  String city;
  dynamic about;
  dynamic rating;
  int status;
  DateTime createdAt;
  DateTime updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    mobileNo: json["mobile_no"],
    image: json["image"],
    emailVerifiedAt: json["email_verified_at"],
    address: json["address"],
    city: json["city"],
    about: json["about"],
    rating: json["rating"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "mobile_no": mobileNo,
    "image": image,
    "email_verified_at": emailVerifiedAt,
    "address": address,
    "city": city,
    "about": about,
    "rating": rating,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
