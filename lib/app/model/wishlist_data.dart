// To parse this JSON data, do
//
//     final wishListData = wishListDataFromJson(jsonString);

import 'dart:convert';

WishListData wishListDataFromJson(String str) => WishListData.fromJson(json.decode(str));

String wishListDataToJson(WishListData data) => json.encode(data.toJson());

class WishListData {
  WishListData({
    required this.status,
    required this.msg,
    required this.data,
  });

  bool status;
  String msg;
  List<Datum> data;

  factory WishListData.fromJson(Map<String, dynamic> json) => WishListData(
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
    required this.userId,
    required this.productId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
  });

  int id;
  int userId;
  int productId;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  Product? product;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    productId: json["product_id"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "product_id": productId,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "product": product == null ? null : product!.toJson(),
  };
}

class Product {
  Product({
    required this.id,
    required this.title,
    required this.name,
    required this.price,
    required this.rating,
    required this.status,
    required this.productImages,
  });

  int id;
  dynamic title;
  String name;
  dynamic price;
  dynamic rating;
  int status;
  List<ProductImage> productImages;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    title: json["title"],
    name: json["name"],
    price: json["price"],
    rating: json["rating"],
    status: json["status"],
    productImages: List<ProductImage>.from(json["product_images"].map((x) => ProductImage.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "name": name,
    "price": price,
    "rating": rating,
    "status": status,
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
