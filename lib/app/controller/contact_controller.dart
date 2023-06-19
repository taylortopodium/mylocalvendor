import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_local_vendor/app/model/normal_response.dart';
import 'package:my_local_vendor/common/utils.dart';

import '../repository/home_repository.dart';

class ContactController extends GetxController{

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController messageController;
  late HomeRepository homeRepository;
  final isLoading = false.obs;

  ContactController(){
    homeRepository = HomeRepository();
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    messageController = TextEditingController();
  }

  void contactUsRequest(BuildContext context) async {
    try {
      isLoading.value = true;
      NormalResponse normalResponse = await homeRepository.contactUs(nameController.text.tr, emailController.text.trim(), phoneController.text.trim(), messageController.text.trim());
      isLoading.value = false;
      showSnackbar(context, normalResponse.msg.toString());
      Get.back();
    } catch (e) {
      isLoading.value = false;
      if (e is DioError) {
        showSnackbar(context, e.response!.data['msg']);
        print(e.response!.data);
      }
      else{
        showSnackbar(context, e.toString());
        print(e.toString());
      }
    }
  }






}