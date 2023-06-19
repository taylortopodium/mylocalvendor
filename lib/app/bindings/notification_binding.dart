import 'package:get/get.dart';
import 'package:my_local_vendor/app/controller/add_product_controller.dart';
import 'package:my_local_vendor/app/controller/auth_controller.dart';
import 'package:my_local_vendor/app/controller/notification_controller.dart';
import 'package:my_local_vendor/app/controller/splash_controller.dart';

class NotificationBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<NotificationController>(
          () => NotificationController(),
    );
  }

}