// To parse this JSON data, do
//
//     final productDetailData = productDetailDataFromJson(jsonString);

import 'dart:convert';

ProductDetailData productDetailDataFromJson(String str) => ProductDetailData.fromJson(json.decode(str));

String productDetailDataToJson(ProductDetailData data) => json.encode(data.toJson());

class ProductDetailData {
  ProductDetailData({
    required this.status,
    required this.msg,
    required this.data,
  });

  bool status;
  String msg;
  ProductDetailDatum data;

  factory ProductDetailData.fromJson(Map<String, dynamic> json) => ProductDetailData(
    status: json["status"],
    msg: json["msg"],
    data: ProductDetailDatum.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": data.toJson(),
  };
}

class ProductDetailDatum {
  ProductDetailDatum({
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
    required this.status,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.subCategory,
    required this.timeToCreated,
    required this.vendor,
    required this.productImages,
    required this.category,
    required this.review,
    required this.is_wishlisted,
    required this.can_reviewed
  });

  int id;
  int userId;
  int categoryId;
  int subCategoryId;
  dynamic title;
  dynamic name;
  dynamic description;
  int quantity;
  dynamic price;
  bool is_wishlisted;
  bool can_reviewed;
  dynamic rating;
  dynamic location;
  int status;
  dynamic deletedAt;
  String createdAt;
  String updatedAt;
  SubCategory subCategory;
  String timeToCreated;
  Vendor vendor;
  List<ProductImage> productImages;
  Category category;
  List<dynamic> review;

  factory ProductDetailDatum.fromJson(Map<String, dynamic> json) => ProductDetailDatum(
    id: json["id"],
    userId: json["user_id"],
    categoryId: json["category_id"],
    subCategoryId: json["sub_category_id"],
    title: json["title"],
    name: json["name"],
    description: json["description"],
    quantity: json["quantity"],
    is_wishlisted: json["is_wishlisted"],
    can_reviewed: json["can_reviewed"],
    price: json["price"],
    rating: json["rating"],
    location: json["location"],
    status: json["status"],
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    subCategory: SubCategory.fromJson(json["sub_category"]),
    timeToCreated: json["time_to_created"],
    vendor: Vendor.fromJson(json["vendor"]),
    productImages: List<ProductImage>.from(json["product_images"].map((x) => ProductImage.fromJson(x))),
    category: Category.fromJson(json["category"]),
    review: List<dynamic>.from(json["review"].map((x) => x)),
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
    "location": location,
    "status": status,
    "deleted_at": deletedAt,
    "is_wishlisted": is_wishlisted,
    "can_reviewed": can_reviewed,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "sub_category": subCategory.toJson(),
    "time_to_created": timeToCreated,
    "vendor": vendor.toJson(),
    "product_images": List<dynamic>.from(productImages.map((x) => x.toJson())),
    "category": category.toJson(),
    "review": List<dynamic>.from(review.map((x) => x)),
  };
}

class Category {
  Category({
    required this.id,
    required this.name,
    required this.image,
  });

  int id;
  String name;
  String image;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
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

class SubCategory {
  SubCategory();

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
  );

  Map<String, dynamic> toJson() => {
  };
}

class Vendor {
  Vendor({
    required this.id,
    required this.name,
    required this.email,
    required this.mobileNo,
    required this.image,
    required this.rating,
    required this.createdAt,
    required this.review,
  });

  int id;
  String name;
  String email;
  int mobileNo;
  String image;
  dynamic rating;
  String createdAt;
  List<dynamic> review;

  factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    mobileNo: json["mobile_no"],
    image: json["image"],
    rating: json["rating"],
    createdAt: json["created_at"],
    review: json["review"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "mobile_no": mobileNo,
    "image": image,
    "rating": rating,
    "created_at": createdAt,
    "review": List<dynamic>.from(review.map((x) => x.toJson())),
  };
}












// // To parse this JSON data, do
// //
// //     final productDetailData = productDetailDataFromJson(jsonString);
//
// import 'dart:convert';
//
// ProductDetailData productDetailDataFromJson(String str) =>
//     ProductDetailData.fromJson(json.decode(str));
//
// String productDetailDataToJson(ProductDetailData data) =>
//     json.encode(data.toJson());
//
// class ProductDetailData {
//   ProductDetailData({
//     required this.status,
//     required this.msg,
//     required this.data,
//   });
//
//   bool status;
//   String msg;
//   ProductDetailsDatum data;
//
//   factory ProductDetailData.fromJson(Map<String, dynamic> json) =>
//       ProductDetailData(
//         status: json["status"],
//         msg: json["msg"],
//         data: ProductDetailsDatum.fromJson(json["data"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "msg": msg,
//         "data": data.toJson(),
//       };
// }
//
// class ProductDetailsDatum {
//   ProductDetailsDatum({
//     required this.id,
//     required this.userId,
//     required this.categoryId,
//     required this.subCategoryId,
//     required this.title,
//     required this.name,
//     required this.description,
//     required this.quantity,
//     required this.price,
//     required this.rating,
//     required this.status,
//     required this.slug,
//     required this.deletedAt,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.vendor,
//     required this.productImages,
//     required this.category,
//     required this.subCategory,
//     required this.review,
//   });
//
//   int id;
//   int userId;
//   int categoryId;
//   dynamic subCategoryId;
//   String title;
//   String name;
//   dynamic description;
//   int quantity;
//   int price;
//   dynamic rating;
//   int status;
//   String slug;
//   dynamic deletedAt;
//   String createdAt;
//   String updatedAt;
//   Vendor vendor;
//   List<ProductImageDetails> productImages;
//   CategoryDetails category;
//   CategoryDetails subCategory;
//   List<dynamic> review;
//
//   factory ProductDetailsDatum.fromJson(Map<String, dynamic> json) =>
//       ProductDetailsDatum(
//         id: json["id"],
//         userId: json["user_id"],
//         categoryId: json["category_id"],
//         subCategoryId: json["sub_category_id"],
//         title: json["title"],
//         name: json["name"],
//         description: json["description"],
//         quantity: json["quantity"],
//         price: json["price"],
//         rating: json["rating"],
//         status: json["status"],
//         slug: json["slug"],
//         deletedAt: json["deleted_at"],
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//         vendor: Vendor.fromJson(json["vendor"]),
//         productImages: List<ProductImageDetails>.from(
//             json["product_images"].map((x) => ProductImageDetails.fromJson(x))),
//         category: CategoryDetails.fromJson(json["category"]),
//         subCategory: CategoryDetails.fromJson(json["sub_category"]),
//         review: List<dynamic>.from(json["review"].map((x) => x)),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "user_id": userId,
//         "category_id": categoryId,
//         "sub_category_id": subCategoryId,
//         "title": title,
//         "name": name,
//         "description": description,
//         "quantity": quantity,
//         "price": price,
//         "rating": rating,
//         "status": status,
//         "slug": slug,
//         "deleted_at": deletedAt,
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//         "vendor": vendor.toJson(),
//         "product_images": List<dynamic>.from(productImages.map((x) => x.toJson())),
//         "category": category.toJson(),
//         "sub_category": subCategory.toJson(),
//         "review": List<dynamic>.from(review.map((x) => x)),
//       };
// }
//
// class CategoryDetails {
//   CategoryDetails({
//     required this.id,
//     required this.name,
//     required this.image,
//   });
//
//   int id;
//   String name;
//   String image;
//
//   factory CategoryDetails.fromJson(Map<String, dynamic> json) =>
//       CategoryDetails(
//         id: json["id"],
//         name: json["name"],
//         image: json["image"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "image": image,
//       };
// }
//
// class ProductImageDetails {
//   ProductImageDetails({
//     required this.id,
//     required this.productId,
//     required this.name,
//   });
//
//   int id;
//   int productId;
//   String name;
//
//   factory ProductImageDetails.fromJson(Map<String, dynamic> json) =>
//       ProductImageDetails(
//         id: json["id"],
//         productId: json["product_id"],
//         name: json["name"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "product_id": productId,
//         "name": name,
//       };
// }
//
// class Vendor {
//   Vendor({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.mobileNo,
//     required this.image,
//     required this.rating,
//     required this.createdAt,
//     required this.review,
//   });
//
//   int id;
//   String name;
//   String email;
//   int mobileNo;
//   String image;
//   dynamic rating;
//   String createdAt;
//   List<dynamic> review;
//
//   factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
//     id: json["id"],
//     name: json["name"],
//     email: json["email"],
//     mobileNo: json["mobile_no"],
//     image: json["image"],
//     rating: json["rating"],
//     createdAt: json["created_at"],
//     review: List<dynamic>.from(json["review"].map((x) => x)),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "email": email,
//     "mobile_no": mobileNo,
//     "image": image,
//     "rating": rating,
//     "created_at": createdAt,
//     "review": List<dynamic>.from(review.map((x) => x)),
//   };
// }
//
