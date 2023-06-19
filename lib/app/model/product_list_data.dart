// To parse this JSON data, do
//
//     final productListData = productListDataFromJson(jsonString);

import 'dart:convert';

ProductListData productListDataFromJson(String str) => ProductListData.fromJson(json.decode(str));

String productListDataToJson(ProductListData data) => json.encode(data.toJson());

class ProductListData {
  ProductListData({
    required this.status,
    required this.msg,
    required this.data,
  });

  bool status;
  String msg;
  Data data;

  factory ProductListData.fromJson(Map<String, dynamic> json) => ProductListData(
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
    required this.data,
    required this.total,
    required this.count,
    required this.perPage,
    required this.currentPage,
    required this.lastPage,
  });

  List<ProductListDatum> data;
  int total;
  int count;
  int perPage;
  int currentPage;
  int lastPage;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    data: List<ProductListDatum>.from(json["data"].map((x) => ProductListDatum.fromJson(x))),
    total: json["total"],
    count: json["count"],
    perPage: json["per_page"],
    currentPage: json["current_page"],
    lastPage: json["last_page"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "total": total,
    "count": count,
    "per_page": perPage,
    "current_page": currentPage,
    "last_page": lastPage,
  };
}

class ProductListDatum {
  ProductListDatum({
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
    required this.status,
    required this.categoryName,
    required this.subCategoryName,
    required this.productImages,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int userId;
  int categoryId;
  dynamic subCategoryId;
  dynamic title;
  dynamic name;
  dynamic description;
  int quantity;
  dynamic price;
  dynamic rating;
  int status;
  String categoryName;
  dynamic subCategoryName;
  List<ProductImage> productImages;
  DateTime createdAt;
  DateTime updatedAt;

  factory ProductListDatum.fromJson(Map<String, dynamic> json) => ProductListDatum(
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
    status: json["status"],
    categoryName: json["category_name"],
    subCategoryName: json["sub_category_name"],
    productImages: List<ProductImage>.from(json["product_images"].map((x) => ProductImage.fromJson(x))),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
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
    "status": status,
    "category_name": categoryName,
    "sub_category_name": subCategoryName,
    "product_images": List<dynamic>.from(productImages.map((x) => x.toJson())),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
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
