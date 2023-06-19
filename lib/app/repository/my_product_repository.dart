import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_local_vendor/app/provider/api_provider.dart';

import '../model/normal_response.dart';
import '../model/user_products_data.dart';


class MyProductRepository{

  late APIProvider _apiProvider;

  MyProductRepository(){
    this._apiProvider = Get.find<APIProvider>();
  }


  Future<UserProductsData> getUserProducts() async {
    return _apiProvider.getUserProducts();
  }

  Future<NormalResponse> deleteImage(String imageId) async {
    return _apiProvider.deleteImage(imageId);
  }

  Future<NormalResponse> deleteProduct(String productId) async {
    return _apiProvider.deleteProduct(productId);
  }


  Future<NormalResponse> updateProduct(
      String price,
      String description,
      List<XFile> imageList,
      String categoryId,
      String subCategoryId,
      String prodName,
      String quantity,
      String productId) async {
    return _apiProvider.updateProduct(price, description, imageList, categoryId, subCategoryId, prodName, quantity, productId);
  }



}