import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_local_vendor/app/controller/home_controller.dart';
import 'package:my_local_vendor/app/model/categories_data.dart';
import 'package:my_local_vendor/common/utils.dart';

import '../repository/home_repository.dart';

class CategoryController extends GetxController {
  final categoryList = <CategoriesDatum>[].obs;
  final isLoading = false.obs;
  late HomeRepository homeRepository;

  CategoryController() {
    homeRepository =HomeRepository();
  }


  void getCategories(BuildContext context) async {
    try {
      isLoading.value = true;
      CategoriesData categoriesData = await homeRepository.getCategories();
      categoryList.assignAll(categoriesData.data);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      if (e is DioError) showSnackbar(context, e.response!.data['msg']);
      else showSnackbar(context, e.toString());
    }
  }

}
