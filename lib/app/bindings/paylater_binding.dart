import 'package:get/get.dart';
import '../controller/pay_later_controller.dart';

class PayLaterBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<PayLaterController>(
          () => PayLaterController(),
    );
  }

}