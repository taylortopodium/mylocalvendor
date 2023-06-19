import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_local_vendor/app/model/seller_review_data.dart';

import '../model/product_review_data.dart';
import '../repository/review_repository.dart';

class ReviewController extends GetxController with GetSingleTickerProviderStateMixin{

  late TabController controller;
  final categoriesList = [
    'Product',
    'Seller'
  ].obs;
  final categorySelectedPos = 0.obs;
  final isProductLoading = false.obs;
  final isSellerLoading = false.obs;
  late ProductReviewData productReviewData;
  late SellerReviewData sellerReviewData;
  late ReviewRepository reviewRepository;

  ReviewController(){
    reviewRepository = ReviewRepository();
    controller = TabController(vsync: this, length: 2);
  }

  @override
  void onInit() {
    super.onInit();
    getProductReview();
    getSellerReview();
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }

  void getProductReview() async {
    try {
      isProductLoading.value = true;
      productReviewData = await reviewRepository.getProductReviews('product');
      isProductLoading.value = false;
    } catch (e) {
      isProductLoading.value = false;
      if (e is DioError) {
        print(e.response!.data.toString());
        Get.snackbar('', e.response!.data['msg']);
      } else {
        Get.snackbar('', e.toString());
        print(e.toString());
      }
    } finally {
      isProductLoading.value = false;
    }
  }


  void getSellerReview() async {
    try {
      isSellerLoading.value = true;
      sellerReviewData = await reviewRepository.getSellerReview('seller');
      isSellerLoading.value = false;
    } catch (e) {
      isSellerLoading.value = false;
      if (e is DioError) {
        print(e.response!.data.toString());
        Get.snackbar('', e.response!.data['msg']);
      } else {
        Get.snackbar('', e.toString());
        print(e.toString());
      }
    } finally {
      isSellerLoading.value = false;
    }
  }

}