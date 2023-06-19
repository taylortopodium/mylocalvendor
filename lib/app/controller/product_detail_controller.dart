import 'package:carousel_slider/carousel_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_local_vendor/app/model/normal_response.dart';
import 'package:my_local_vendor/common/utils.dart';

import '../model/product_detail_data.dart';
import '../repository/product_repository.dart';

class ProductDetailController extends GetxController {
  final isFavourite = true.obs;
  final showCaseImageUrl = 'https://picsum.photos/300/200?random1'.obs;

  late TextEditingController reviewtextController;
  late ProductDetailData productDetailData;
  final isLoading = true.obs;
  final isAdding = false.obs;
  late ProductRepository productRepository;
  var title, productId = '';
  var vendorRating = '5';
  late CarouselController buttonCarouselController;

  ProductDetailController() {
    reviewtextController = TextEditingController();
    productRepository = ProductRepository();
    buttonCarouselController = CarouselController();
  }

  @override
  void onInit() {
    super.onInit();
    title = Get.arguments['title'] as String;
    productId = Get.arguments['productId'] as String;
    print('Product Id = $productId');
    getProductDetails(productId);
  }


   onPageChanged(){

  }

  void getProductDetails(String productId) async {
    try {
      isLoading.value = true;
      ProductDetailData productDetailData2 = await productRepository.getProductDetails(productId);
      this.productDetailData = productDetailData2;
      showCaseImageUrl.value = productDetailData2.data.productImages[0].name;
      isFavourite.value = productDetailData.data.is_wishlisted;
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      if (e is DioError)
        {
          // Get.snackbar('', e.response!.data['msg']);
          print('Upper ===  '+e.response!.data);
        }
      else{
        Get.snackbar('', e.toString());
        print('Lower ===  '+e.toString());
      }

    }
  }

  void addReview(String productID, String rating, String review, bool isVendor,
      BuildContext context) async {
    try {
      NormalResponse normalResponse = await productRepository.addReview(
          productID, rating, review, isVendor);
      showSnackbar(context, normalResponse.msg);
      Get.back();
      getProductDetails(productId);
    } catch (e) {
      if (e is DioError)
        showSnackbar(context, e.response!.data['msg']);
      else
        showSnackbar(context, e.toString());
    }
  }


  void addToWishList(BuildContext context,String productID) async {
    try {
      isAdding.value = true;
      NormalResponse normalResponse = await productRepository.addToWishlist(productId);
      // showSnackbar(context, normalResponse.msg);
      isFavourite.value = !isFavourite.value;
      isAdding.value = false;
    } catch (e) {
      isAdding.value = false;
      if (e is DioError)
        showSnackbar(context, e.response!.data['msg']);
      else
        showSnackbar(context, e.toString());
    }
  }

}
