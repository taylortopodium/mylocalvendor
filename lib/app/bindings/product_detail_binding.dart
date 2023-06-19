import 'package:get/get.dart';
import 'package:my_local_vendor/app/controller/auth_controller.dart';
import 'package:my_local_vendor/app/controller/product_controller.dart';
import 'package:my_local_vendor/app/controller/product_detail_controller.dart';
import 'package:my_local_vendor/app/controller/splash_controller.dart';

class ProductDetailBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ProductDetailController>(
          () => ProductDetailController(),
    );
  }

}