import 'package:get/get.dart';
import 'package:my_local_vendor/app/controller/auth_controller.dart';
import 'package:my_local_vendor/app/controller/contact_controller.dart';
import 'package:my_local_vendor/app/controller/splash_controller.dart';

class ContactBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ContactController>(
          () => ContactController(),
    );
  }

}