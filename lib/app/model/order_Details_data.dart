// To parse this JSON data, do
//
//     final orderDetailsData = orderDetailsDataFromJson(jsonString);

import 'dart:convert';

OrderDetailsData orderDetailsDataFromJson(String str) => OrderDetailsData.fromJson(json.decode(str));

String orderDetailsDataToJson(OrderDetailsData data) => json.encode(data.toJson());

class OrderDetailsData {
  OrderDetailsData({
    required this.status,
    required this.msg,
    required this.data,
  });

  bool status;
  String msg;
  Data data;

  factory OrderDetailsData.fromJson(Map<String, dynamic> json) => OrderDetailsData(
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
    required this.id,
    required this.userId,
    required this.productId,
    required this.total,
    required this.amountReceived,
    required this.email,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
    required this.address,
    required this.city,
    required this.product,
    required this.paymentDetail,
  });

  int id;
  int userId;
  int productId;
  int total;
  int amountReceived;
  String email;
  int status;
  String createdAt;
  DateTime updatedAt;
  String type;
  String address;
  String city;
  Product product;
  List<PaymentDetail> paymentDetail;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    userId: json["user_id"],
    productId: json["product_id"],
    total: json["total"],
    amountReceived: json["amount_received"],
    email: json["email"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: DateTime.parse(json["updated_at"]),
    type: json["type"],
    address: json["address"],
    city: json["city"],
    product: Product.fromJson(json["product"]),
    paymentDetail: List<PaymentDetail>.from(json["payment_detail"].map((x) => PaymentDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "product_id": productId,
    "total": total,
    "amount_received": amountReceived,
    "email": email,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt.toIso8601String(),
    "type": type,
    "address": address,
    "city": city,
    "product": product.toJson(),
    "payment_detail": List<dynamic>.from(paymentDetail.map((x) => x.toJson())),
  };
}

class PaymentDetail {
  PaymentDetail({
   required this.id,
   required this.orderId,
   required this.userId,
   required this.total,
   required this.dueDate,
   required this.value,
   required this.status,
   required this.createdAt,
   required this.updatedAt,
  });

  int id;
  dynamic orderId;
  dynamic userId;
  dynamic total;
  dynamic dueDate;
  dynamic value;
  dynamic status;
  dynamic createdAt;
  DateTime updatedAt;

  factory PaymentDetail.fromJson(Map<String, dynamic> json) => PaymentDetail(
    id: json["id"],
    orderId: json["order_id"],
    userId: json["user_id"],
    total: json["total"],
    dueDate: json["due_date"],
    value: json["value"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "user_id": userId,
    "total": total,
    "due_date": "${dueDate.year.toString().padLeft(4, '0')}-${dueDate.month.toString().padLeft(2, '0')}-${dueDate.day.toString().padLeft(2, '0')}",
    "value": value,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Product {
  Product({
    required this.id,
    required this.userId,
    required this.title,
    required this.name,
    required this.price,
    required this.rating,
    required this.status,
    required this.productImages,
    required this.vendor,
  });

  int id;
  int userId;
  dynamic title;
  dynamic name;
  dynamic price;
  dynamic rating;
  dynamic status;
  List<ProductImage> productImages;
  Vendor vendor;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    userId: json["user_id"],
    title: json["title"],
    name: json["name"],
    price: json["price"],
    rating: json["rating"],
    status: json["status"],
    productImages: List<ProductImage>.from(json["product_images"].map((x) => ProductImage.fromJson(x))),
    vendor: Vendor.fromJson(json["vendor"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "title": title,
    "name": name,
    "price": price,
    "rating": rating,
    "status": status,
    "product_images": List<dynamic>.from(productImages.map((x) => x.toJson())),
    "vendor": vendor.toJson(),
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
