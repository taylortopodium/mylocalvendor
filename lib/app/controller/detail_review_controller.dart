import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../model/detail_review_data.dart';
import '../repository/review_repository.dart';

class DetailReviewController extends GetxController{

  late ReviewRepository reviewRepository;
  final isLoading = false.obs;
  late DetailReviewData detailReviewData;

  DetailReviewController(){
    reviewRepository = ReviewRepository();
  }


  @override
  void onInit(){
    super.onInit();
    var type = Get.arguments['type'] as String;
    var id = Get.arguments['id'] as String;
    getReview(type,id);
  }

  void getReview(String type,String itemId) async {
    try {
      isLoading.value = true;
      detailReviewData = await reviewRepository.getDetailReview(type,itemId);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      if (e is DioError) {
        print(e.response!.data.toString());
        Get.snackbar('', e.response!.data['msg']);
      } else {
        Get.snackbar('', e.toString());
        print(e.toString());
      }
    } finally {
      isLoading.value = false;
    }
  }

}