// To parse this JSON data, do
//
//     final ordersData = ordersDataFromJson(jsonString);

import 'dart:convert';

OrdersData ordersDataFromJson(String str) => OrdersData.fromJson(json.decode(str));

String ordersDataToJson(OrdersData data) => json.encode(data.toJson());

class OrdersData {
  OrdersData({
    required this.status,
    required this.msg,
    required this.data,
  });

  bool status;
  String msg;
  List<Datum> data;

  factory OrdersData.fromJson(Map<String, dynamic> json) => OrdersData(
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
    required this.total,
    required this.amountReceived,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
    required this.address,
    required this.city,
    required this.product,
  });

  int id;
  int userId;
  int productId;
  dynamic total;
  dynamic amountReceived;
  int status;
  String createdAt;
  DateTime updatedAt;
  String type;
  dynamic address;
  String city;
  Product product;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    productId: json["product_id"],
    total: json["total"],
    amountReceived: json["amount_received"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: DateTime.parse(json["updated_at"]),
    type: json["type"],
    address: json["address"],
    city: json["city"],
    product: Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "product_id": productId,
    "total": total,
    "amount_received": amountReceived,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt.toIso8601String(),
    "type": type,
    "address": address,
    "city": city,
    "product": product.toJson(),
  };
}

class Product {
  Product({
    required this.id,
    required this.title,
    required this.name,
    required this.price,
    required this.vendor,
    required this.rating,
    required this.status,
    required this.productImages,
  });

  int id;
  dynamic title;
  String name;
  dynamic price;
  dynamic rating;
  dynamic vendor;
  int status;
  List<ProductImage> productImages;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    title: json["title"],
    name: json["name"],
    price: json["price"],
    vendor: json["vendor"],
    rating: json["rating"],
    status: json["status"],
    productImages: List<ProductImage>.from(json["product_images"].map((x) => ProductImage.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "name": name,
    "price": price,
    "vendor": vendor,
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
