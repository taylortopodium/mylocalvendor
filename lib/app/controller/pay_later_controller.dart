import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_local_vendor/app/controller/product_detail_controller.dart';
import 'package:my_local_vendor/app/model/pay_later_data.dart';

import '../repository/payment_repository.dart';

class PayLaterController extends GetxController{

  final installmentSelectedPos = 0.obs;
  final listSize = 5.obs;
  final paymentSelectedPos = 0.obs;
  late PaymentRepository paymentRepository;
  final isLoading = false.obs;
  late Data payLaterInnerData;
  final emiList = <EmiDatum>[].obs;

  PayLaterController(){
    paymentRepository = PaymentRepository();
  }


  @override
  void onInit(){
    super.onInit();
    getPayLaterData();
  }


  void getPayLaterData() async {
    try {
      isLoading.value = true;
      PayLaterData payLaterData = await paymentRepository.getPayLaterData(Get.find<ProductDetailController>().productId);
      payLaterInnerData = payLaterData.data;
      changeEmiListValues();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      if (e is DioError) {
        print('Upper ===  ' + e.response!.data);
      } else {
        print('Lower ===  ' + e.toString());
      }
    }
  }

  void changeEmiListValues(){
    emiList.clear();
    emiList.addAll(payLaterInnerData.emiDetails[installmentSelectedPos.value].emiData);
  }


  Future<void> selectDate(BuildContext context,int index,DateTime initialDate) async {
    DateTime selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime.now(),
        lastDate: initialDate.add(Duration(days: 30))
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      updateDate(selectedDate, index);
    }
  }

  updateDate(DateTime date,int index) {
    print("Date " + date.toString());
    emiList[index].date = DateFormat('yyyy-MM-dd').format(date);;
    emiList.refresh();
  }


}