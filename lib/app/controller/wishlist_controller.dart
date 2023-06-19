import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../model/wishlist_data.dart';
import '../repository/wishlist_repository.dart';

class WishlistController extends GetxController{

  late WishListRepository wishListRepository;
  final isLoading = false.obs;
  final wishList = <Datum>[].obs;

  WishlistController(){
    wishListRepository = WishListRepository();
  }

  @override
  void onInit(){
    super.onInit();
    getWishList();
  }



  void getWishList() async {
    try {
      isLoading.value = true;
      WishListData wishListData = await wishListRepository.getWishList();
      wishList.assignAll(wishListData.data);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      if (e is DioError)
      {
        // Get.snackbar('', e.response!.data['msg']);
        print('Upper ===  '+e.response!.data);
      }
      else{
        Get.snackbar('', e.toString());
        print('Lower ===  '+e.toString());
      }

    }
  }







}