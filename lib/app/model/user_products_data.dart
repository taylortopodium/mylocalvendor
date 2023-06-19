// To parse this JSON data, do
//
//     final myProductsData = myProductsDataFromJson(jsonString);

import 'dart:convert';

UserProductsData myProductsDataFromJson(String str) => UserProductsData.fromJson(json.decode(str));

String myProductsDataToJson(UserProductsData data) => json.encode(data.toJson());

class UserProductsData {
  UserProductsData({
    required this.status,
    required this.msg,
    required this.data,
  });

  bool status;
  String msg;
  List<UserProductsDatum> data;

  factory UserProductsData.fromJson(Map<String, dynamic> json) => UserProductsData(
    status: json["status"],
    msg: json["msg"],
    data: List<UserProductsDatum>.from(json["data"].map((x) => UserProductsDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class UserProductsDatum {
  UserProductsDatum({
    required this.id,
    required this.userId,
    required this.categoryId,
    required this.subCategoryId,
    required this.title,
    required this.name,
    required this.description,
    required this.quantity,
    required this.price,
    required this.rating,
    required this.location,
    required this.totalSale,
    required this.isFeatured,
    required this.status,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.category_name,
    required this.sub_category_name,
    required this.productImages,
  });

  dynamic id;
  dynamic userId;
  dynamic categoryId;
  dynamic subCategoryId;
  dynamic title;
  dynamic name;
  dynamic description;
  dynamic quantity;
  dynamic price;
  dynamic rating;
  dynamic location;
  dynamic totalSale;
  dynamic isFeatured;
  dynamic status;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic category_name;
  dynamic sub_category_name;
  List<ProductImage> productImages;

  factory UserProductsDatum.fromJson(Map<String, dynamic> json) => UserProductsDatum(
    id: json["id"],
    userId: json["user_id"],
    categoryId: json["category_id"],
    subCategoryId: json["sub_category_id"],
    title: json["title"],
    name: json["name"],
    description: json["description"],
    quantity: json["quantity"],
    price: json["price"],
    rating: json["rating"],
    location: json["location"] == null ? null : json["location"],
    totalSale: json["total_sale"],
    isFeatured: json["is_featured"],
    status: json["status"],
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    category_name: json["category_name"],
    sub_category_name: json["sub_category_name"],
    productImages: List<ProductImage>.from(json["product_images"].map((x) => ProductImage.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "category_id": categoryId,
    "sub_category_id": subCategoryId,
    "title": title,
    "name": name,
    "description": description,
    "quantity": quantity,
    "price": price,
    "rating": rating,
    "location": location == null ? null : location,
    "total_sale": totalSale,
    "is_featured": isFeatured,
    "status": status,
    "deleted_at": deletedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "category_name": category_name,
    "sub_category_name": sub_category_name,
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
