import 'package:get/get.dart';
import 'package:my_local_vendor/app/controller/auth_controller.dart';
import 'package:my_local_vendor/app/controller/search_controller.dart';
import 'package:my_local_vendor/app/controller/splash_controller.dart';

class SearchBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SearchController>(
          () => SearchController(),
    );
  }

}