// To parse this JSON data, do
//
//     final detailReviewData = detailReviewDataFromJson(jsonString);

import 'dart:convert';

DetailReviewData detailReviewDataFromJson(String str) => DetailReviewData.fromJson(json.decode(str));

String detailReviewDataToJson(DetailReviewData data) => json.encode(data.toJson());

class DetailReviewData {
  DetailReviewData({
    required this.status,
    required this.msg,
    required this.data,
  });

  bool status;
  String msg;
  Data data;

  factory DetailReviewData.fromJson(Map<String, dynamic> json) => DetailReviewData(
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
    required this.review,
    required this.rating,
    required this.buyer,
  });

  dynamic id;
  dynamic buyerId;
  dynamic review;
  dynamic rating;
  Buyer buyer;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    id: json["id"],
    buyerId: json["buyer_id"],
    review: json["review"],
    rating: json["rating"],
    buyer: Buyer.fromJson(json["buyer"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "buyer_id": buyerId,
    "review": review,
    "rating": rating,
    "buyer": buyer.toJson(),
  };
}

class Buyer {
  Buyer({
    required this.id,
    required this.name,
    required this.image,
  });

  dynamic id;
  dynamic name;
  dynamic image;

  factory Buyer.fromJson(Map<String, dynamic> json) => Buyer(
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
