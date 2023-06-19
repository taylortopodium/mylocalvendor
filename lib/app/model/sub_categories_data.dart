// To parse this JSON data, do
//
//     final subCategoriesData = subCategoriesDataFromJson(jsonString);

import 'dart:convert';

SubCategoriesData subCategoriesDataFromJson(String str) => SubCategoriesData.fromJson(json.decode(str));

String subCategoriesDataToJson(SubCategoriesData data) => json.encode(data.toJson());

class SubCategoriesData {
  SubCategoriesData({
    required this.status,
    required this.msg,
    required this.data,
  });

  bool status;
  String msg;
  List<SubCategoriesDatum> data;

  factory SubCategoriesData.fromJson(Map<String, dynamic> json) => SubCategoriesData(
    status: json["status"],
    msg: json["msg"],
    data: List<SubCategoriesDatum>.from(json["data"].map((x) => SubCategoriesDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class SubCategoriesDatum {
  SubCategoriesDatum({
    required this.id,
    required this.categoryId,
    required this.name,
  });

  int id;
  int categoryId;
  String name;

  factory SubCategoriesDatum.fromJson(Map<String, dynamic> json) => SubCategoriesDatum(
    id: json["id"],
    categoryId: json["category_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "name": name,
  };
}
