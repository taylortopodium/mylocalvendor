import 'package:get/get.dart';
import 'package:my_local_vendor/app/provider/api_provider.dart';

import '../model/orders_data.dart';
import '../model/product_list_data.dart';
import '../model/wishlist_data.dart';

class SearchRepository{

  late APIProvider _apiProvider;

  SearchRepository(){
    this._apiProvider = Get.find<APIProvider>();
  }


  Future<ProductListData> getSearchedItems(String keyword) async {
    return _apiProvider.getSearchedItems(keyword);
  }


  Future<ProductListData> getSearchFilter(String categoryId, String itemType,
      String sortBy, String priceRange,String keyword,String location) async {
    return _apiProvider.getSearchFilter(categoryId, itemType, sortBy, priceRange, keyword,location);
  }


}