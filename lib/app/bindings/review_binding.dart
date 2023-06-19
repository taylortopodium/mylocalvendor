import 'package:get/get.dart';
import 'package:my_local_vendor/app/controller/auth_controller.dart';
import 'package:my_local_vendor/app/controller/review_controller.dart';
import 'package:my_local_vendor/app/controller/splash_controller.dart';

import '../controller/detail_review_controller.dart';

class ReviewBindng extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ReviewController>(
          () => ReviewController(),
    );
    Get.lazyPut<DetailReviewController>(
          () => DetailReviewController(),
    );
  }

}