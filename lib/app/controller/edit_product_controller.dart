import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_local_vendor/app/controller/my_product_controller.dart';
import 'package:my_local_vendor/app/repository/my_product_repository.dart';
import 'package:my_local_vendor/common/utils.dart';

import '../model/categories_data.dart';
import '../model/normal_response.dart';
import '../model/sub_categories_data.dart';
import '../model/user_products_data.dart';
import '../repository/product_repository.dart';
import 'home_controller.dart';

class EditProductController extends GetxController {

  late MyProductRepository myProductRepository;



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
  final downloadedImageList = <ProductImage>[].obs;

  late UserProductsDatum userProductsDatum;
  late int index;



  EditProductController() {
    myProductRepository = MyProductRepository();


    index = Get.arguments['index'] as int;
    userProductsDatum = Get.arguments['productData'] as UserProductsDatum;
    downloadedImageList.assignAll(userProductsDatum.productImages);
    print(userProductsDatum.id.toString());

    productRepository = ProductRepository();
    priceController = TextEditingController();
    locationController = TextEditingController();
    descriptionController = TextEditingController();
    quantityController = TextEditingController();
    nameController = TextEditingController();

    categortList.value = Get.find<HomeController>().categoriesList;
    for(int i = 0;i<categortList.length;i++)
      categoryItems.add(categortList[i].name);


    nameController.text = userProductsDatum.name.toString();
    priceController.text = userProductsDatum.price.toString();
    quantityController.text = userProductsDatum.quantity.toString();
    descriptionController.text = userProductsDatum.description.toString();


    categoryId = userProductsDatum.categoryId.toString();
    subCategoryId = userProductsDatum.subCategoryId.toString();
    selectedCategory.value = userProductsDatum.category_name.toString();
    getSubCategories(categoryId);

    print('category id $categoryId');
    print('sub category id $subCategoryId');

  }

  @override
  void onInit(){
    super.onInit();

  }



  imgFromGallery() async {
    XFile? image = await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    imageList.add(image!);
  }

  imgFromCamera() async {
    XFile? image = await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    imageList.add(image!);
  }


  void updateProduct(BuildContext context) async {
    try {
      isUploading.value = true;
      print('image list size ${imageList.length}');
      NormalResponse normalResponse = await myProductRepository.updateProduct( priceController.text.trim(),
          descriptionController.text.trim(), imageList,categoryId,subCategoryId,nameController.text.trim(),quantityController.text.trim(),userProductsDatum.id.toString());
      showSnackbar(context, normalResponse.msg);
      isUploading.value = false;
      Get.back();
      Get.find<MyProductController>().getUserProducts();
    } catch (e) {
      isUploading.value = false;
      if (e is DioError) {
        showSnackbar(context, e.response!.data.toString());
        print("Edit product Error "+e.response!.data.toString());
        print("Edit product Code "+e.response!.statusCode.toString());
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

      if(subCategoryItems.contains(userProductsDatum.sub_category_name.toString())) {
        selectedSubCategory.value = userProductsDatum.sub_category_name.toString();
        print('============> ' + userProductsDatum.sub_category_name.toString());
      }

    } catch (e) {
      if (e is DioError)
        Get.snackbar('', e.response!.data['msg']);
      else
        Get.snackbar('', e.toString());
    }
  }


  void deleteAPI(BuildContext context,String imageId,int index) async {
    try{
      NormalResponse normalResponse = await myProductRepository.deleteImage(imageId);
      userProductsDatum.productImages.removeAt(index);
      downloadedImageList.removeAt(index);
      downloadedImageList.refresh();
      // userProductsDatum.productImages.refresh();
    } catch (e) {
      isUploading.value = false;
      if (e is DioError) {
        showSnackbar(context, e.response!.data.toString());
      }
      else
        showSnackbar(context, e.toString());
    }
  }


}
