import 'package:get/get.dart';
import 'package:my_local_vendor/app/controller/auth_controller.dart';
import 'package:my_local_vendor/app/controller/splash_controller.dart';
import 'package:my_local_vendor/app/controller/wishlist_controller.dart';

class WishlistBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<WishlistController>(
          () => WishlistController(),
    );
  }

}