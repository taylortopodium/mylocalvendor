import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_local_vendor/app/controller/home_controller.dart';
import 'package:my_local_vendor/app/repository/product_repository.dart';

import '../model/categories_data.dart';
import '../model/product_list_data.dart';
import '../model/sub_categories_data.dart';

class ProductController extends GetxController {
  final title = ''.obs;
  var originalTitle = '';
  var originalCatId = '';
  var categoryId = '';
  var itemType = '';
  final List<String> categoryItems = [];
  String? selectedCategory;
  final priceValue = 10000.0.obs;
  final sortSelectedPos = 0.obs;
  final List<String> sortList = ['Popularity', 'Rating', 'Price', 'Relevancy'];
  late ProductRepository productRepository;
  final isProductLoading = true.obs;
  final productList = <ProductListDatum>[].obs;
  final categortList = <CategoriesDatum>[].obs;
  late TextEditingController locationController;
  var currentPage = 1;

  ProductController() {
    productRepository = ProductRepository();
    locationController = TextEditingController();

  categortList.value = Get.find<HomeController>().categoriesList;
    for(int i = 0;i<categortList.length;i++)
      categoryItems.add(categortList[i].name);
  }

  @override
  void onInit() {
    super.onInit();
    title.value = Get.arguments['title'] as String;
    originalTitle = Get.arguments['title'] as String;
    categoryId = Get.arguments['categoryId'] as String;
    originalCatId = Get.arguments['categoryId'] as String;
    itemType = Get.arguments['itemType'] as String;
    getProductList(categoryId,itemType);
  }

  void getProductList(String categoryId,String itemType) async {
    try {
      isProductLoading.value = true;
      ProductListData productListData =
          await productRepository.getProductList(categoryId,itemType,currentPage);
      productList.assignAll(productListData.data.data);
      isProductLoading.value = false;
    } catch (e) {
      isProductLoading.value = false;
      if (e is DioError)
        Get.snackbar('', e.response!.data['msg']);
      else
        Get.snackbar('', e.toString());
    }
  }


  void getFilteredItems(String categoryId,String itemType,String sortBy,String priceRange,String location) async {
    try {
      isProductLoading.value = true;
      ProductListData productListData = await productRepository.getFilteredItems(categoryId, itemType, sortBy.toLowerCase(), priceRange,location);
      productList.assignAll(productListData.data.data);
      isProductLoading.value = false;
    } catch (e) {
      isProductLoading.value = false;
      if (e is DioError)
        Get.snackbar('', e.response!.data['msg']);
      else
        Get.snackbar('', e.toString());
    }
  }





}
