// To parse this JSON data, do
//
//     final profileData = profileDataFromJson(jsonString);

import 'dart:convert';

ProfileData profileDataFromJson(String str) => ProfileData.fromJson(json.decode(str));

String profileDataToJson(ProfileData data) => json.encode(data.toJson());

class ProfileData {
  ProfileData({
    required this.status,
    required this.msg,
    required this.data,
  });

  bool status;
  String msg;
  ProfileDatum data;

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
    status: json["status"],
    msg: json["msg"],
    data: ProfileDatum.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": data.toJson(),
  };
}

class ProfileDatum {
  ProfileDatum({
    required this.id,
    required this.name,
    required this.email,
    required this.mobileNo,
    required this.country_code,
    // required this.isVendor,
    required this.image,
    required this.emailVerifiedAt,
    required this.address,
    required this.city,
    required this.about,
    required this.rating,
    // required this.status,
    // required this.vendorStatus,
    required this.createdAt,
    // required this.updatedAt,
    // required this.socialId,
    // required this.loginType,
    required this.totalReviews,
  });

  int id;
  String name;
  String email;
  dynamic mobileNo;
  // int isVendor;
  String image;
  dynamic emailVerifiedAt;
  dynamic address;
  dynamic country_code;
  String city;
  dynamic about;
  dynamic rating;
  // int status;
  // int vendorStatus;
  String createdAt;
  // String updatedAt;
  // String socialId;
  // String loginType;
  int totalReviews;

  factory ProfileDatum.fromJson(Map<String, dynamic> json) => ProfileDatum(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    mobileNo: json["mobile_no"],
    country_code: json["country_code"],
    // isVendor: json["is_vendor"],
    image: json["image"],
    emailVerifiedAt: json["email_verified_at"],
    address: json["address"],
    city: json["city"],
    about: json["about"],
    rating: json["rating"],
    // status: json["status"],
    // vendorStatus: json["vendor_status"],
    createdAt: json["created_at"],
    // updatedAt: json["updated_at"],
    // socialId: json["social_id"],
    // loginType: json["login_type"],
    totalReviews: json["total_reviews"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "mobile_no": mobileNo,
    "country_code": country_code,
    // "is_vendor": isVendor,
    "image": image,
    "email_verified_at": emailVerifiedAt,
    "address": address,
    "city": city,
    "about": about,
    "rating": rating,
    // "status": status,
    // "vendor_status": vendorStatus,
    "created_at": createdAt,
    // "updated_at": updatedAt,
    // "social_id": socialId,
    // "login_type": loginType,
    "total_reviews": totalReviews,
  };
}
