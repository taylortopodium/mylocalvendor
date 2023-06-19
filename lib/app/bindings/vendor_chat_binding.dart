import 'package:get/get.dart';
import 'package:my_local_vendor/app/controller/auth_controller.dart';
import 'package:my_local_vendor/app/controller/splash_controller.dart';
import 'package:my_local_vendor/app/controller/vendor_chat_controller.dart';

class VendorChatBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<VendorChatController>(
          () => VendorChatController(),
    );
  }

}