// To parse this JSON data, do
//
//     final categoriesData = categoriesDataFromJson(jsonString);

import 'dart:convert';

CategoriesData categoriesDataFromJson(String str) => CategoriesData.fromJson(json.decode(str));

String categoriesDataToJson(CategoriesData data) => json.encode(data.toJson());

class CategoriesData {
  CategoriesData({
    required this.status,
    required this.msg,
    required this.data,
  });

  bool status;
  String msg;
  List<CategoriesDatum> data;

  factory CategoriesData.fromJson(Map<String, dynamic> json) => CategoriesData(
    status: json["status"],
    msg: json["msg"],
    data: List<CategoriesDatum>.from(json["data"].map((x) => CategoriesDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class CategoriesDatum {
  CategoriesDatum({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.subCategory,
    required this.categoryId,
  });

  int id;
  String name;
  String image;
  String description;
  int status;
  String createdAt;
  String updatedAt;
  List<CategoriesDatum> subCategory;
  int categoryId;

  factory CategoriesDatum.fromJson(Map<String, dynamic> json) => CategoriesDatum(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    description: json["description"] == null ? '' : json["description"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    subCategory: json["sub_category"] == null ? [] : List<CategoriesDatum>.from(json["sub_category"].map((x) => CategoriesDatum.fromJson(x))),
    categoryId: json["category_id"] == null ? 0 : json["category_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "description": description == null ? null : description,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "sub_category": subCategory == null ? null : List<dynamic>.from(subCategory.map((x) => x.toJson())),
    "category_id": categoryId == null ? null : categoryId,
  };
}
