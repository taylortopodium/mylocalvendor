// To parse this JSON data, do
//
//     final sellerReviewData = sellerReviewDataFromJson(jsonString);

import 'dart:convert';

SellerReviewData sellerReviewDataFromJson(String str) => SellerReviewData.fromJson(json.decode(str));

String sellerReviewDataToJson(SellerReviewData data) => json.encode(data.toJson());

class SellerReviewData {
  SellerReviewData({
    required this.status,
    required this.msg,
    required this.data,
  });

  bool status;
  String msg;
  Data data;

  factory SellerReviewData.fromJson(Map<String, dynamic> json) => SellerReviewData(
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
    required this.totalReviews,
    required this.overallRating,
    required this.fiveStarReviews,
    required this.reviews,
  });

  dynamic totalReviews;
  dynamic overallRating;
  dynamic fiveStarReviews;
  List<Review> reviews;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    totalReviews: json["total_reviews"],
    overallRating: json["overall_rating"],
    fiveStarReviews: json["five_star_reviews"],
    reviews: List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total_reviews": totalReviews,
    "overall_rating": overallRating,
    "five_star_reviews": fiveStarReviews,
    "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
  };
}

class Review {
  Review({
    required this.id,
    required this.buyerId,
    required this.vendorId,
    required this.review,
    required this.rating,
    required this.vendor,
  });

  int id;
  int buyerId;
  int vendorId;
  dynamic review;
  int rating;
  Vendor vendor;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    id: json["id"],
    buyerId: json["buyer_id"],
    vendorId: json["vendor_id"],
    review: json["review"],
    rating: json["rating"],
    vendor: Vendor.fromJson(json["vendor"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "buyer_id": buyerId,
    "vendor_id": vendorId,
    "review": review,
    "rating": rating,
    "vendor": vendor.toJson(),
  };
}

class Vendor {
  Vendor({
    required this.id,
    required this.name,
    required this.image,
  });

  int id;
  String name;
  String image;

  factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
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
