import 'package:get/get.dart';
import 'package:my_local_vendor/app/controller/auth_controller.dart';
import 'package:my_local_vendor/app/controller/my_product_controller.dart';
import 'package:my_local_vendor/app/controller/review_controller.dart';
import 'package:my_local_vendor/app/controller/splash_controller.dart';

import '../controller/edit_product_controller.dart';

class MyProductBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<MyProductController>(
          () => MyProductController(),
    );
    Get.lazyPut<EditProductController>(
          () => EditProductController(),
    );
  }

}