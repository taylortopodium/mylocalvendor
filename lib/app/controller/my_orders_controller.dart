import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_local_vendor/app/model/orders_data.dart';

import '../../common/utils.dart';
import '../model/normal_response.dart';
import '../repository/order_repository.dart';

class MyOrdersController extends GetxController {
  late OrderRepository orderRepository;
  final isLoading = false.obs;
  final orderList = <Datum>[].obs;
  final vendororderList = <Datum>[].obs;

  var productRating = '5';
  late TextEditingController reviewtextController;

  MyOrdersController() {
    orderRepository = OrderRepository();
    reviewtextController = TextEditingController();
  }

  @override
  void onInit() {
    super.onInit();
    getOrders();
    getVendorOrders();
  }

  void getOrders() async {
    try {
      isLoading.value = true;
      OrdersData ordersData = await orderRepository.getOrders();
      orderList.assignAll(ordersData.data);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      if (e is DioError) {
        // Get.snackbar('', e.response!.data['msg']);
        print('Upper ===  ' + e.response!.data);
      } else {
        Get.snackbar('', e.toString());
        print('Lower ===  ' + e.toString());
      }
    }
  }



  void getVendorOrders() async {
    try {
      isLoading.value = true;
      OrdersData ordersData = await orderRepository.getVendorOrders();
      vendororderList.assignAll(ordersData.data);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      if (e is DioError) {
        // Get.snackbar('', e.response!.data['msg']);
        print('Upper ===  ' + e.response!.data);
      } else {
        Get.snackbar('', e.toString());
        print('Lower ===  ' + e.toString());
      }
    }
  }


  void addReview(String productID, String rating, String review, bool isVendor,
      BuildContext context) async {
    try {
      NormalResponse normalResponse = await orderRepository.addReview(productID, rating, review, isVendor);
      Get.back();
    } catch (e) {
      if (e is DioError) {
        showSnackbar(context, e.response!.data['msg']);
      } else {
        showSnackbar(context, e.toString());
      }
    }
  }

}
