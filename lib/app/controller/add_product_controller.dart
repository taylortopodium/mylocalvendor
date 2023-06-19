import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_local_vendor/common/utils.dart';

import '../model/categories_data.dart';
import '../model/normal_response.dart';
import '../model/sub_categories_data.dart';
import '../repository/product_repository.dart';
import '../routes/app_routes.dart';
import 'home_controller.dart';

class AddProductController extends GetxController{


  // late TextEditingController titleController;
  late TextEditingController priceController;
  late TextEditingController locationController;
  late TextEditingController descriptionController;
  late TextEditingController quantityController;
  late TextEditingController nameController;
  final picker = ImagePicker();
  final imageList = <XFile>[].obs;
  late ProductRepository productRepository;
  final isUploading = false.obs;

  final List<String> categoryItems = [];
  final  subCategoryItems = <String>[].obs;
  final categortList = <CategoriesDatum>[].obs;
  final subCategoriesList = <SubCategoriesDatum>[].obs;
  final selectedCategory = ''.obs;
  final selectedSubCategory = ''.obs;
  var categoryId = '';
  var subCategoryId = '0';


  AddProductController(){
    productRepository = ProductRepository();
    // titleController = TextEditingController();
    priceController = TextEditingController();
    locationController = TextEditingController();
    descriptionController = TextEditingController();
    quantityController = TextEditingController();
    nameController = TextEditingController();

    categortList.value = Get.find<HomeController>().categoriesList;
    for(int i = 0;i<categortList.length;i++)
      categoryItems.add(categortList[i].name);

  }

  imgFromGallery(int pos) async {
    XFile? image = await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    imageList.add(image!);
  }

  imgFromCamera(int pos) async {
    XFile? image = await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    imageList.add(image!);
  }


  void addProduct(BuildContext context) async {
    try {
      isUploading.value = true;
      NormalResponse normalResponse = await productRepository.addProduct(priceController.text.trim(),
           descriptionController.text.trim(), imageList,categoryId,subCategoryId,nameController.text.trim(),quantityController.text.trim());
      showSnackbar(context, normalResponse.msg);
      imageList.clear();
      isUploading.value = false;
      Get.offAllNamed(Routes.Home);
    } catch (e) {
      isUploading.value = false;
      if (e is DioError) {
        showSnackbar(context, e.response!.data.toString());
        print("Add product Error "+e.response!.data.toString());
        print("Add product Code "+e.response!.statusCode.toString());
      }
      else
        showSnackbar(context, e.toString());
    }
  }

  void getSubCategories(String categoryId) async {
    subCategoryItems.clear();
    try {
      SubCategoriesData subCategoriesData = await productRepository.getSubCategories(categoryId);
      subCategoriesList.assignAll(subCategoriesData.data);
      for(int i = 0;i<subCategoriesList.length;i++)
        subCategoryItems.add(subCategoriesList[i].name);
    } catch (e) {
      if (e is DioError)
        Get.snackbar('', e.response!.data['msg']);
      else
        Get.snackbar('', e.toString());
    }
  }


}