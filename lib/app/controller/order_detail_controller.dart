import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_local_vendor/app/model/order_Details_data.dart';
import 'package:my_local_vendor/app/model/orders_data.dart';

import '../../common/utils.dart';
import '../model/normal_response.dart';
import '../repository/order_repository.dart';

class OrderDetailController extends GetxController {

  final isLoading = true.obs;
  late OrderDetailsData orderDetailsData;
  late OrderRepository orderRepository;


  OrderDetailController() {
    orderRepository = OrderRepository();
  }

  @override
  void onInit() {
    super.onInit();
    var orderId = Get.arguments['orderId'] as String;
    getOrderDetails(orderId);
  }

  void getOrderDetails(String orderId) async {
    try {
      isLoading.value = true;
      OrderDetailsData ordersData = await orderRepository.getOrderDetails(orderId);
      orderDetailsData = ordersData;
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      if (e is DioError) {
        print('Upper ===  ${e.response!.data}');
      } else {
        Get.snackbar('', e.toString());
        print('Lower ===  $e');
      }
    }
  }


}
