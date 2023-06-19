import 'package:get/get.dart';
import 'package:my_local_vendor/app/controller/auth_controller.dart';
import 'package:my_local_vendor/app/controller/check_credit_controller.dart';
import 'package:my_local_vendor/app/controller/splash_controller.dart';

class CreditBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<CheckCreditController>(
          () => CheckCreditController(),
    );
  }

}