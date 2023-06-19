import 'package:get/get.dart';
import 'package:my_local_vendor/app/controller/splash_controller.dart';

class SplashBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(
          () => SplashController(),
    );
  }

}