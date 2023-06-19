import 'package:get/get.dart';
import 'package:my_local_vendor/app/provider/api_provider.dart';

import '../model/wishlist_data.dart';

class WishListRepository{

  late APIProvider _apiProvider;

  WishListRepository(){
    this._apiProvider = Get.find<APIProvider>();
  }


  Future<WishListData> getWishList() async {
    return _apiProvider.getWishList();
  }


}