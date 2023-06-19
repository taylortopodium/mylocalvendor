import 'package:get/get.dart';

import '../controller/my_orders_controller.dart';
import '../controller/order_detail_controller.dart';

class MyOrdersBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<MyOrdersController>(
          () => MyOrdersController(),
    );

    Get.lazyPut<OrderDetailController>(
          () => OrderDetailController(),
    );
  }



}