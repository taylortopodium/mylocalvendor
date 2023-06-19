import 'package:get/get.dart';

import '../model/categories_data.dart';
import '../model/normal_response.dart';
import '../model/product_list_data.dart';
import '../provider/api_provider.dart';

class HomeRepository {
  late APIProvider _apiProvider;

  HomeRepository() {
    this._apiProvider = Get.find<APIProvider>();
  }

  Future<NormalResponse> logoutUser() async {
    return _apiProvider.logoutUser();
  }

  Future<CategoriesData> getCategories() async {
    return _apiProvider.getCategories();
  }

  Future<ProductListData> getProductList(String categoryId,String itemType,int currentPage) async {
    return _apiProvider.getProductList(categoryId,itemType,currentPage);
  }

  Future<NormalResponse> contactUs(
      String name, String email, String mobile, String message) async {
  return _apiProvider.contactUs(name, email, mobile, message);
  }

  Future<NormalResponse> updateAddress(String address,String city,String lat,String lng) async {
    return _apiProvider.updateAddress(address, city, lat, lng);
  }


}
