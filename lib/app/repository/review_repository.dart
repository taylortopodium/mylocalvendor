import 'package:get/get.dart';
import 'package:my_local_vendor/app/provider/api_provider.dart';

import '../model/detail_review_data.dart';
import '../model/product_review_data.dart';
import '../model/seller_review_data.dart';

class ReviewRepository {
  late APIProvider _apiProvider;

  ReviewRepository() {
    this._apiProvider = Get.find<APIProvider>();
  }

  Future<ProductReviewData> getProductReviews(String type) async {
    return _apiProvider.getProductReview(type);
  }

  Future<SellerReviewData> getSellerReview(String type) async {
    return _apiProvider.getSellerReview(type);
  }

  Future<DetailReviewData> getDetailReview(String type,String itemId) async {
    return _apiProvider.getDetailReview(type, itemId);
  }


}
