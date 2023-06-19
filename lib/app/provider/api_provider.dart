// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as gett;
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_local_vendor/app/controller/pay_later_controller.dart';
import 'package:my_local_vendor/app/controller/payment_controller.dart';
import 'package:my_local_vendor/app/model/CheckCreditData.dart';
import 'package:my_local_vendor/app/model/auth_data.dart';
import 'package:my_local_vendor/app/model/card_list_data.dart';
import 'package:my_local_vendor/app/model/categories_data.dart';
import 'package:my_local_vendor/app/model/chat_list_data.dart';
import 'package:my_local_vendor/app/model/message_data.dart';
import 'package:my_local_vendor/app/model/normal_response.dart';
import 'package:my_local_vendor/app/model/product_detail_data.dart';
import 'package:my_local_vendor/app/model/product_list_data.dart';
import 'package:my_local_vendor/app/model/profile_data.dart';
import 'package:my_local_vendor/app/model/product_review_data.dart';
import 'package:my_local_vendor/app/model/seller_review_data.dart';
import 'package:my_local_vendor/app/model/wishlist_data.dart';
import 'package:my_local_vendor/common/preferences.dart';
import 'package:my_local_vendor/common/utils.dart';

import '../model/detail_review_data.dart';
import '../model/order_Details_data.dart';
import '../model/user_products_data.dart';
import '../model/notification_data.dart';
import '../model/orders_data.dart';
import '../model/pay_later_data.dart';
import '../model/sub_categories_data.dart';

class APIProvider {
  static var dio;
  static const _baseUrl =
      "http://3.108.209.20/jamail/public/api/buyer/";
  static var options;
  static var deviceId;
  static var deviceType;
  static var deviceToken;

  APIProvider() {
    dio = Dio();
    setDeviceVariables();
  }

  setDeviceVariables() async {
    deviceType = getDeviceType();
    await getDeviceId().then((value) {
      deviceId = value;
      storeValue(SharedPref.device_id, value.toString());
    });
    await getDeviceToken().then((value) {
      deviceToken = value;
      storeValue(SharedPref.device_token, value.toString());
    });
  }

  Future<APIProvider> init() async {
    return this;
  }

  String getBaseURL(String endpoint) {
    return _baseUrl + endpoint;
  }

  Options getOptions() {
    var token = getValue(SharedPref.authToken);
    var options = Options(headers: {
      'Authorization': 'Bearer $token',
    });

    return options;
  }

  Future<AuthData> registerUser(String name, String email, String mobileNo,
      String password, String countryCode) async {
    var formData = FormData.fromMap({
      'name': name,
      'email': email,
      'mobile_no': mobileNo,
      'password': password,
      'confirm_password': password,
      'country_code': countryCode,
    });
    var response = await dio.post(getBaseURL("register"), data: formData);
    if (response.statusCode == 200) {
      return AuthData.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  }

  Future<AuthData> loginUser(String email, String password, String loginType,
      String socialId, String name) async {
    FormData formData;
    if (loginType == '201') {
      formData = FormData.fromMap({
        'email': email,
        'password': password,
        'device_id': deviceToken,
        'device_type': deviceType,
        'login_type': loginType,
      });
    } else {
      formData = FormData.fromMap({
        'email': email,
        'device_id': deviceToken,
        'device_type': deviceType,
        'login_type': loginType,
        'social_id': socialId,
        'name': name,
      });
    }

    var response = await dio.post(
      getBaseURL("login"),
      data: formData,
    );
    log("asdfghjkl: ${response.data}");
    if (response.statusCode == 200) {
      return AuthData.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  }

  Future<NormalResponse> logoutUser() async {
    var formData = FormData.fromMap({});
    var response = await dio.post(getBaseURL("logout"),
        data: formData, options: getOptions());
    if (response.statusCode == 200) {
      return NormalResponse.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  }

  Future<CategoriesData> getCategories() async {
    Response response = await dio.get(getBaseURL("categories"));
    if (response.statusCode == 200) {
      return CategoriesData.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  }

  Future<ProductListData> getProductList(
      String categoryId, String itemType, int currentPage) async {
    final Map<String, String> params;
    if (itemType == 'none') {
      params = <String, String>{
        'category_id': categoryId,
        'sort_by': 'latest',
        'page': currentPage.toString(),
      };
    } else {
      params = <String, String>{
        'item_type': itemType,
        'sort_by': 'latest',
        'page': currentPage.toString(),
      };
    }
    Response response = await dio.get(getBaseURL("products"),
        queryParameters: params, options: getOptions());
    if (response.statusCode == 200) {
      return ProductListData.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  }

  Future<ProductListData> getFilteredItems(String categoryId, String itemType,
      String sortBy, String priceRange, String location) async {
    final Map<String, String> params;
    if (itemType == 'none') {
      params = <String, String>{
        'category_id': categoryId,
        'price_range': priceRange,
        'sort_by': sortBy,
        'location': location
      };
    } else {
      params = <String, String>{
        'item_type': itemType,
        'price_range': priceRange,
        'sort_by': sortBy,
        'location': location
      };
    }
    Response response = await dio.get(getBaseURL("products"),
        queryParameters: params, options: getOptions());
    if (response.statusCode == 200) {
      return ProductListData.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  }

  Future<ProductDetailData> getProductDetails(String productId) async {
    Response response =
        await dio.get(getBaseURL("products/$productId"), options: getOptions());
    if (response.statusCode == 200) {
      return ProductDetailData.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  }

  Future<ProfileData> getProfileDetails() async {
    Response response =
        await dio.get(getBaseURL("get_profile"), options: getOptions());
    if (response.statusCode == 200) {
      return ProfileData.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  }

  Future<NormalResponse> updateProfile(
      String name,
      String email,
      String mobile,
      String address,
      String city,
      String about,
      File image,
      String country_code) async {
    FormData formData;
    if (image.path == '') {
      formData = FormData.fromMap({
        'name': name,
        'email': email,
        'mobile_no': mobile,
        'address': address,
        'city': city,
        'about': about,
        'country_code': country_code,
      });
    } else {
      formData = FormData.fromMap({
        'name': name,
        'email': email,
        'mobile_no': mobile,
        'address': address,
        'city': city,
        'country_code': country_code,
        'about': about,
        'image': await MultipartFile.fromFile(image.path,
            filename: '${DateTime.now()}.png'),
      });
    }

    var response = await dio.post(getBaseURL("update_profile"),
        data: formData, options: getOptions());
    if (response.statusCode == 200) {
      return NormalResponse.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  }

  Future<NormalResponse> addReview(
      String productID, String rating, String review, bool isVendor) async {
    FormData formData;
    if (isVendor) {
      formData = FormData.fromMap(
          {'vendor_id': productID, 'rating': rating, 'review': review});
    } else {
      formData = FormData.fromMap(
          {'product_id': productID, 'rating': rating, 'review': review});
    }
    var response = await dio.post(getBaseURL("reviews"),
        data: formData, options: getOptions());
    if (response.statusCode == 200) {
      return NormalResponse.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  }

  Future<NormalResponse> addProduct(
      String price,
      String description,
      List<XFile> imageList,
      String categoryId,
      String subCategoryId,
      String prodName,
      String quantity) async {
    var imageFileList = [];

    for (int i = 0; i < imageList.length; i++)
      for (int i = 0; i < imageList.length; i++)
        imageFileList.add(await MultipartFile.fromFile(imageList[i].path,
            filename: imageList[i].name));

    price = price.replaceAll(",", '');

    var formData = FormData.fromMap({
      'name': prodName,
      'price': price,
      'description': description,
      'product_images[]': imageFileList,
      'category_id': categoryId,
      'sub_category_id': subCategoryId,
      'quantity': quantity,
    });
    var response = await dio.post(getBaseURL("products"),
        data: formData, options: getOptions());
    if (response.statusCode == 200) {
      return NormalResponse.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  }

  Future<SubCategoriesData> getSubCategories(String categoryId) async {
    var response = await dio.get(getBaseURL("sub_categories/$categoryId"),
        options: getOptions());
    if (response.statusCode == 200) {
      return SubCategoriesData.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  }

  Future<CheckCreditData> checkCreditScore(
      String referenceID,
      String type,
      String fName,
      String mName,
      String lName,
      String email,
      String mobile,
      String phoneNo,
      String socialNo,
      String dob,
      String currAddress,
      String prevAddress) async {
    var formData = FormData.fromMap({
      'reference_id': referenceID,
      'type': type,
      'first_name': fName,
      'middle_name': mName,
      'last_name': lName,
      'email': email,
      'mobile': mobile,
      'home_phone': phoneNo,
      'social_security_number': socialNo,
      'dob': dob,
      'current_address': currAddress,
      'previous_address': prevAddress
    });
    var response = await dio.post(getBaseURL("check_cibil_score"),
        data: formData, options: getOptions());
    if (response.statusCode == 200) {
      return CheckCreditData.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  }

  Future<NormalResponse> contactUs(
      String name, String email, String mobile, String message) async {
    var formData = FormData.fromMap(
        {'email': email, 'mobile': mobile, 'name': name, 'message': message});
    var response = await dio.post(getBaseURL("contact_us"),
        data: formData, options: getOptions());
    if (response.statusCode == 200) {
      return NormalResponse.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  }

  Future<CardListData> addCard(String card_number, String name,
      String expiry_date, String security_code) async {
    var formData = FormData.fromMap({
      'card_number': card_number,
      'name': name,
      'expiry_date': expiry_date,
      'security_code': security_code
    });
    var response = await dio.post(getBaseURL("cards"),
        data: formData, options: getOptions());
    if (response.statusCode == 200) {
      return CardListData.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  }

  Future<CardListData> getCardList() async {
    var response = await dio.get(getBaseURL("cards"), options: getOptions());
    if (response.statusCode == 200) {
      return CardListData.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  }

  Future<CardListData> editCard(String card_number, String name,
      String expiry_date, String security_code, String cardId) async {
    var formData = FormData.fromMap({
      'card_number': card_number,
      'name': name,
      'expiry_date': expiry_date,
      'security_code': security_code
    });
    var response = await dio.post(getBaseURL("cards/$cardId"),
        data: formData, options: getOptions());
    if (response.statusCode == 200) {
      return CardListData.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  }

  Future<CardListData> deleteCard(String cardId) async {
    var response =
        await dio.delete(getBaseURL("cards/$cardId"), options: getOptions());
    if (response.statusCode == 200) {
      return CardListData.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  }

  Future<NormalResponse> addToWishlist(String productId) async {
    var response = await dio.post(getBaseURL("wishlist/$productId"),
        options: getOptions());
    if (response.statusCode == 200) {
      return NormalResponse.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  }

  Future<WishListData> getWishList() async {
    var response = await dio.get(getBaseURL("wishlist"), options: getOptions());
    if (response.statusCode == 200) {
      return WishListData.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  }

  Future<OrdersData> getOrders() async {
    var response = await dio.get(getBaseURL("orders"), options: getOptions());
    if (response.statusCode == 200) {
      return OrdersData.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  }

  Future<OrderDetailsData> getOrderDetails(String orderId) async {
    var response =
        await dio.get(getBaseURL("orders/$orderId"), options: getOptions());
    if (response.statusCode == 200) {
      return OrderDetailsData.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  }

  Future<OrdersData> getVendorOrders() async {
    var response =
        await dio.get(getBaseURL("vendor_orders"), options: getOptions());
    if (response.statusCode == 200) {
      return OrdersData.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  }

  Future<NotificationData> getNotifications() async {
    var response =
        await dio.get(getBaseURL("notifications"), options: getOptions());
    if (response.statusCode == 200) {
      return NotificationData.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  }

  Future<PayLaterData> getPayLaterData(String productId) async {
    var response = await dio.get(getBaseURL("pay_later_data/$productId"),
        options: getOptions());
    if (response.statusCode == 200) {
      return PayLaterData.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  }

  Future<NormalResponse> proceedPayment(
      String productID,
      String total,
      String amountReceieved,
      String type,
      String emiOption,
      String cardId) async {
    FormData formData;
    if (type == 'full') {
      formData = FormData.fromMap({
        'product_id': productID,
        'type': type,
        'card_id': cardId,
        'email':
            gett.Get.find<PaymentCOntroller>().confirmationEmailController.text
      });
    } else {
      formData = FormData.fromMap({
        'product_id': productID,
        'type': type,
        'emi_option': emiOption,
        'card_id': cardId,
        'emi_data':
            json.encode(gett.Get.find<PayLaterController>().emiList.value),
        'email':
            gett.Get.find<PaymentCOntroller>().confirmationEmailController.text
      });
    }

    print('product_id : $productID');
    print('type : $type');
    print('card_id:  $cardId');
    print('token : ${getValue(SharedPref.authToken)}');

    var response = await dio.post(getBaseURL("orders"),
        data: formData, options: getOptions());
    print(response.data);
    if (response.statusCode == 200) {
      return NormalResponse.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  }

  Future<ProductListData> getSearchedItems(String keyword) async {
    final params = <String, String>{
      'keyword': keyword,
    };
    Response response = await dio.get(getBaseURL("products"),
        queryParameters: params, options: getOptions());
    if (response.statusCode == 200) {
      return ProductListData.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  }

  Future<ProductListData> getSearchFilter(String categoryId, String itemType,
      String sortBy, String priceRange, String keyword, String location) async {
    final Map<String, String> params;
    if (itemType == 'none') {
      params = <String, String>{
        'category_id': categoryId,
        'price_range': priceRange,
        'sort_by': sortBy,
        'keyword': keyword,
        'location': location
      };
    } else {
      params = <String, String>{
        'item_type': itemType,
        'price_range': priceRange,
        'sort_by': sortBy,
        'keyword': keyword,
        'location': location
      };
    }
    Response response = await dio.get(getBaseURL("products"),
        queryParameters: params, options: getOptions());
    if (response.statusCode == 200) {
      return ProductListData.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  }

  Future<NormalResponse> deactivateAcccount() async {
    var formData = FormData.fromMap({});
    var response = await dio.post(getBaseURL("deactivate_account"),
        data: formData, options: getOptions());
    if (response.statusCode == 200) {
      return NormalResponse.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  }

  Future<NormalResponse> deletAccount() async {
    var formData = FormData.fromMap({});
    var response = await dio.post(getBaseURL("delete_account"),
        data: formData, options: getOptions());
    if (response.statusCode == 200) {
      return NormalResponse.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  }

  Future<NormalResponse> checkEmail(String email) async {
    var formData = FormData.fromMap({
      'email': email,
    });
    var response = await dio.post(getBaseURL("check_email"), data: formData);
    if (response.statusCode == 200) {
      return NormalResponse.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  }

  Future<NormalResponse> updatePassword(String email, String password) async {
    var formData = FormData.fromMap({
      'email': email,
      'password': password,
      'confirm_password': password,
    });
    var response =
        await dio.post(getBaseURL("update_password_by_email"), data: formData);
    if (response.statusCode == 200) {
      return NormalResponse.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  }

  Future<ChatListData> getChatList() async {
    Response response =
        await dio.get(getBaseURL("conversation_list"), options: getOptions());
    if (response.statusCode == 200) {
      return ChatListData.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  }

  Future<MessageData> getMessages(String otherUSerId) async {
    Response response = await dio.get(getBaseURL("message_list/$otherUSerId"),
        options: getOptions());
    if (response.statusCode == 200) {
      return MessageData.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  }

  Future<NormalResponse> blockUnblockUser(String otherUSerId) async {
    Response response = await dio.get(getBaseURL("chats/is_block/$otherUSerId"),
        options: getOptions());
    print('Response  ${response.data.toString()}');
    if (response.statusCode == 200) {
      return NormalResponse.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  }

  Future<MessageData> sendMessage(String receverId, String message) async {
    var formData =
        FormData.fromMap({'receiver_id': receverId, 'body': message});
    var response = await dio.post(getBaseURL("chats"),
        data: formData, options: getOptions());
    if (response.statusCode == 200) {
      return MessageData.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  }

  Future<NormalResponse> updateAddress(
      String address, String city, String lat, String lng) async {
    var formData = FormData.fromMap(
        {'address': address, 'city': city, 'lat': lat, 'lng': lng});
    var response = await dio.post(getBaseURL("update_address"),
        data: formData, options: getOptions());
    if (response.statusCode == 200) {
      return NormalResponse.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  }

  Future<NormalResponse> deleteNotification(String notificationId) async {
    var response = await dio.delete(getBaseURL("notifications/$notificationId"),
        options: getOptions());
    if (response.statusCode == 200) {
      return NormalResponse.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  }

  Future<ProductReviewData> getProductReview(String type) async {
    final params = <String, String>{
      'type': type,
    };
    var response = await dio.get(getBaseURL("reviews/user"),
        options: getOptions(), queryParameters: params);
    if (response.statusCode == 200) {
      return ProductReviewData.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  }

  Future<SellerReviewData> getSellerReview(String type) async {
    final params = <String, String>{
      'type': type,
    };
    var response = await dio.get(getBaseURL("reviews/user"),
        options: getOptions(), queryParameters: params);
    if (response.statusCode == 200) {
      return SellerReviewData.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  }

  Future<UserProductsData> getUserProducts() async {
    var response =
        await dio.get(getBaseURL("products/user"), options: getOptions());
    if (response.statusCode == 200) {
      return UserProductsData.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  }

  Future<NormalResponse> deleteProduct(String productId) async {
    var response = await dio.delete(getBaseURL("products/$productId"),
        options: getOptions());
    if (response.statusCode == 200) {
      return NormalResponse.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  }

  Future<NormalResponse> deleteImage(String imageId) async {
    var response = await dio.delete(getBaseURL("products/image/$imageId"),
        options: getOptions());
    if (response.statusCode == 200) {
      return NormalResponse.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  }

  Future<NormalResponse> updateProduct(
      String price,
      String description,
      List<XFile> imageList,
      String categoryId,
      String subCategoryId,
      String prodName,
      String quantity,
      String productId) async {
    var imageFileList = [];

    for (int i = 0; i < imageList.length; i++)
      imageFileList.add(await MultipartFile.fromFile(imageList[i].path,
          filename: imageList[i].name));

    price = price.replaceAll(",", '');

    FormData formData;

    if (imageList.length > 0) {
      formData = FormData.fromMap({
        'name': prodName,
        'price': price,
        'description': description,
        'product_images[]': imageFileList,
        'category_id': categoryId,
        'sub_category_id': subCategoryId,
        'quantity': quantity,
      });
    } else {
      formData = FormData.fromMap({
        'name': prodName,
        'price': price,
        'description': description,
        'category_id': categoryId,
        'sub_category_id': subCategoryId,
        'quantity': quantity,
      });
    }

    var response = await dio.post(getBaseURL("products/update/$productId"),
        data: formData, options: getOptions());
    if (response.statusCode == 200) {
      return NormalResponse.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  }

  Future<DetailReviewData> getDetailReview(String type, String itemId) async {
    final params = <String, String>{
      'type': type,
    };
    var response = await dio.get(getBaseURL("reviews/product/$itemId"),
        options: getOptions(), queryParameters: params);
    if (response.statusCode == 200) {
      return DetailReviewData.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  }
}
