import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_local_vendor/app/model/normal_response.dart';
import 'package:my_local_vendor/app/model/product_list_data.dart';
import 'package:my_local_vendor/app/routes/app_routes.dart';
import 'package:my_local_vendor/common/preferences.dart';
import 'package:my_local_vendor/common/utils.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../model/categories_data.dart';
import '../repository/home_repository.dart';

class HomeController extends GetxController{

  final GlobalKey<ScaffoldState> key = GlobalKey();
  final categorySelectedPos = 0.obs;
  final listSize = 15.obs;
  final isLoading = false.obs;
  final isProductLoading = true.obs;
  late HomeRepository homeRepository;
  final categoriesList = <CategoriesDatum>[].obs;
  final productList = <ProductListDatum>[].obs;
  final currentAddress= ''.obs;
  var currentPage = 1;
  ScrollController scrollController = ScrollController();
  final isLoadMore = false.obs;
  final isLocationLoading = false.obs;

  HomeController(){
    homeRepository = HomeRepository();
    print('Auth Token=> ${getValue(SharedPref.authToken)}');
  }

  @override
  void onInit(){
    super.onInit();

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.position.pixels) {
        if (!isLoadMore.value) {
          isLoadMore.value = !isLoadMore.value;
          // Perform event when user reach at the end of list (e.g. do Api call)
          print('=====================> Bottom Reached');
          currentPage+=1;
          getLoadMore('');
        }

      }
    });


    currentAddress.value = getValue(SharedPref.address);
    if(currentAddress.value == 'null') getCurrentAddress();
  }

  void getCurrentAddress() async {
    managePermissions();
  }

  void managePermissions() async{
    if (await Permission.location.request().isGranted) {
      isLocationLoading.value = true;
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      print(placemarks[0].locality);
      Placemark placemark = placemarks[0];
      currentAddress.value = '${placemark.street}, ${placemark.subAdministrativeArea}, ${placemark.administrativeArea}, ${placemark.country}';
      storeValue(SharedPref.address, currentAddress.value);
      updateAddress(currentAddress.value, placemark.administrativeArea.toString(), position.latitude.toString(), position.longitude.toString());
      isLocationLoading.value = false;
    } else if (await Permission.location.request().isPermanentlyDenied && GetPlatform.isAndroid) {
      openAppSettings();
    } else {
      Get.snackbar('Permissions Required', 'Please allow location permissions.');
    }
  }

  void logoutUser(BuildContext context) async {
    try {
      NormalResponse normalResponse = await homeRepository.logoutUser();
      GetStorage().remove(SharedPref.isLogin);
      GetStorage().remove(SharedPref.authToken);
      GetStorage().remove(SharedPref.userId);
      Get.offAllNamed(Routes.Login);
    } catch (e) {
      if (e is DioError) {
        print(e.response!.data['msg']);
        showSnackbar(context, e.response!.data['msg']);
      } else {
        showSnackbar(context, e.toString());
      }
      print(e.toString());
    }
  }


  void getCategories(BuildContext context) async {
    try {
      isLoading.value = true;
      isProductLoading.value = true;
      CategoriesData categoriesData = await homeRepository.getCategories();
      categoriesList.assignAll(categoriesData.data);
      // getProductList(context, categoriesData.data[0].id.toString());
      // getProductList(context, '');
      categorySelectedPos.value = 0;
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      if (e is DioError) showSnackbar(context, e.response!.data['msg']);
       else showSnackbar(context, e.toString());
    }
  }


  void getProductList(BuildContext context,String categoryId) async {
    try {
      isProductLoading.value = true;
      ProductListData productListData = await homeRepository.getProductList(categoryId,'none',currentPage);
      if(currentPage == 1) {
        productList.assignAll(productListData.data.data);
      } else {
        productList.addAll(productListData.data.data);
      }
      isProductLoading.value = false;
    } catch (e) {
      isProductLoading.value = false;
      if (e is DioError) {
        showSnackbar(context, e.response!.data['msg']);
      } else {
        showSnackbar(context, e.toString());
      }
    }
  }


  void getLoadMore(String categoryId) async {
    try {
      isLoadMore.value = true;
      ProductListData productListData = await homeRepository.getProductList(categoryId,'none',currentPage);
      productList.addAll(productListData.data.data);
      isLoadMore.value = false;
    } catch (e) {
      isLoadMore.value = false;
      if (e is DioError)
       Get.snackbar("", e.response!.data['msg']);
      else
        Get.snackbar("", e.toString());
    }
  }


  void updateAddress(String address,String city,String lat,String lng) async {
    try {
      NormalResponse normalResponse = await homeRepository.updateAddress(address, city, lat, lng);
    } catch (e) {
      if (e is DioError) Get.snackbar('', e.response!.data['msg']);
      else Get.snackbar('', e.toString());
    }
  }



}