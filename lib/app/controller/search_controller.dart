import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/categories_data.dart';
import '../model/product_list_data.dart';
import '../repository/search_repository.dart';
import 'home_controller.dart';

class SearchController extends GetxController {
  late TextEditingController searchTextController;
  late SearchRepository searchRepository;
  final isProductLoading = false.obs;
  final productList = <ProductListDatum>[].obs;

  final priceValue = 10000.0.obs;
  final sortSelectedPos = 0.obs;
  final List<String> sortList = ['Popularity', 'Rating', 'Price', 'Relevancy'];
  final categortList = <CategoriesDatum>[].obs;
  final List<String> categoryItems = [];
  var categoryId = '';
  String? selectedCategory;

  late TextEditingController locationController;

  SearchController() {
    searchRepository = SearchRepository();
    searchTextController = TextEditingController();
    locationController = TextEditingController();

    categortList.value = Get.find<HomeController>().categoriesList;
    for (int i = 0; i < categortList.length; i++)
      categoryItems.add(categortList[i].name);
  }

  void getProductList(String keyword) async {
    try {
      isProductLoading.value = true;
      ProductListData productListData =
          await searchRepository.getSearchedItems(keyword);
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



  void getFilteredItems(String categoryId,String itemType,String sortBy,String priceRange,String keyword,String location) async {
    try {
      isProductLoading.value = true;
      ProductListData productListData = await searchRepository.getSearchFilter(categoryId, itemType, sortBy, priceRange, keyword,location);
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
