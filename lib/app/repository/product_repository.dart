import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../model/normal_response.dart';
import '../model/product_detail_data.dart';
import '../model/product_list_data.dart';
import '../model/sub_categories_data.dart';
import '../provider/api_provider.dart';

class ProductRepository {
  late APIProvider _apiProvider;

  ProductRepository() {
    this._apiProvider = Get.find<APIProvider>();
  }

  Future<ProductListData> getProductList(String categoryId,String itemType,int currentPage) async {
    return _apiProvider.getProductList(categoryId,itemType,currentPage);
  }

  Future<ProductDetailData> getProductDetails(String productId) async {
    return _apiProvider.getProductDetails(productId);
  }

  Future<NormalResponse> addReview(String productID,String rating,String review,bool isVendor) async {
    return _apiProvider.addReview(productID, rating, review, isVendor);
  }

  Future<NormalResponse> addProduct(String price, String description, List<XFile> imageList,String categoryId,String subCategoryId,String name,String quantity) async {
    return _apiProvider.addProduct(price, description, imageList, categoryId, subCategoryId, name, quantity);
  }

  Future<NormalResponse> addToWishlist(String productId) async {
    return _apiProvider.addToWishlist(productId);
  }

  Future<ProductListData> getFilteredItems(String categoryId,String itemType,String sortBy,String priceRange,String location) async {
    return _apiProvider.getFilteredItems(categoryId, itemType, sortBy, priceRange,location);
  }

  Future<SubCategoriesData> getSubCategories(String categoryId) async {
    return _apiProvider.getSubCategories(categoryId);
  }


}
