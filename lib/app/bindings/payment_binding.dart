import 'package:get/get.dart';
import 'package:my_local_vendor/app/controller/payment_controller.dart';

class PaymentBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<PaymentCOntroller>(
          () => PaymentCOntroller(),
    );
  }

}