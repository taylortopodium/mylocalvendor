// To parse this JSON data, do
//
//     final productReviewData = productReviewDataFromJson(jsonString);

import 'dart:convert';

ProductReviewData productReviewDataFromJson(String str) => ProductReviewData.fromJson(json.decode(str));

String productReviewDataToJson(ProductReviewData data) => json.encode(data.toJson());

class ProductReviewData {
  ProductReviewData({
    required this.status,
    required this.msg,
    required this.data,
  });

  bool status;
  String msg;
  ProductReviewDatum data;

  factory ProductReviewData.fromJson(Map<String, dynamic> json) => ProductReviewData(
    status: json["status"],
    msg: json["msg"],
    data: ProductReviewDatum.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": data.toJson(),
  };
}

class ProductReviewDatum {
  ProductReviewDatum({
    required this.totalReviews,
    required this.overallRating,
    required this.fiveStarReviews,
    required this.reviews,
  });

  dynamic totalReviews;
  dynamic overallRating;
  dynamic fiveStarReviews;
  List<ProductReview> reviews;

  factory ProductReviewDatum.fromJson(Map<String, dynamic> json) => ProductReviewDatum(
    totalReviews: json["total_reviews"],
    overallRating: json["overall_rating"],
    fiveStarReviews: json["five_star_reviews"],
    reviews: List<ProductReview>.from(json["reviews"].map((x) => ProductReview.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total_reviews": totalReviews,
    "overall_rating": overallRating,
    "five_star_reviews": fiveStarReviews,
    "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
  };
}

class ProductReview {
  ProductReview({
    required this.id,
    required this.buyerId,
    required this.productId,
    required this.review,
    required this.rating,
    required this.product,
  });

  int id;
  int buyerId;
  int productId;
  String review;
  int rating;
  Product product;

  factory ProductReview.fromJson(Map<String, dynamic> json) => ProductReview(
    id: json["id"],
    buyerId: json["buyer_id"],
    productId: json["product_id"],
    review: json["review"],
    rating: json["rating"],
    product: Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "buyer_id": buyerId,
    "product_id": productId,
    "review": review,
    "rating": rating,
    "product": product.toJson(),
  };
}

class Product {
  Product({
    required this.id,
    required this.name,
    required this.productImages,
  });

  int id;
  String name;
  List<ProductImage> productImages;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    productImages: List<ProductImage>.from(json["product_images"].map((x) => ProductImage.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "product_images": List<dynamic>.from(productImages.map((x) => x.toJson())),
  };
}

class ProductImage {
  ProductImage({
    required this.id,
    required this.productId,
    required this.name,
  });

  int id;
  int productId;
  String name;

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
    id: json["id"],
    productId: json["product_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "name": name,
  };
}
