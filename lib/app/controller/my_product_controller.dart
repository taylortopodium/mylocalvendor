import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_local_vendor/app/repository/my_product_repository.dart';
import 'package:my_local_vendor/common/utils.dart';

import '../model/categories_data.dart';
import '../model/normal_response.dart';
import '../model/sub_categories_data.dart';
import '../model/user_products_data.dart';
import '../repository/product_repository.dart';
import 'home_controller.dart';

class MyProductController extends GetxController {
  late MyProductRepository myProductRepository;
  late UserProductsData userProductsData;
  final isLoading = false.obs;

  MyProductController() {
    myProductRepository = MyProductRepository();
  }

  @override
  void onInit() {
    super.onInit();
    getUserProducts();
  }

  void getUserProducts() async {
    print('Fetching Products');
    try {
      isLoading.value = true;
      userProductsData = await myProductRepository.getUserProducts();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      if (e is DioError) {
        Get.snackbar('', e.response!.data['msg']);
        print('Upper ===  ' + e.response!.data);
      } else {
        Get.snackbar('', e.toString());
        print('Lower ===  ' + e.toString());
      }
    }
  }

  void deleteProduct(BuildContext context, String productId, int index) async {
    try {
      isLoading.value = true;
      NormalResponse normalResponse =
          await myProductRepository.deleteProduct(productId);
      userProductsData.data.clear();
      getUserProducts();
    } catch (e) {
      isLoading.value = false;
      if (e is DioError) {
        showSnackbar(context, e.response!.data.toString());
      } else
        showSnackbar(context, e.toString());
    }
  }
}
