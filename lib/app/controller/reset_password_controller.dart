import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_local_vendor/app/routes/app_routes.dart';
import 'package:my_local_vendor/common/utils.dart';

import '../model/normal_response.dart';
import '../repository/reset_password_repository.dart';

class ResetPasswordController extends GetxController{

  late TextEditingController emailUsernameController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  final isLoading = false.obs;
  late ResetPasswordRepository resetPasswordRepository;

  ResetPasswordController(){
    resetPasswordRepository = ResetPasswordRepository();
    emailUsernameController =TextEditingController();
    passwordController =TextEditingController();
    confirmPasswordController =TextEditingController();
  }



  void checkEmail(BuildContext context) async {
    try {
      isLoading.value = true;
      NormalResponse normalResponse = await resetPasswordRepository.checkEmail(emailUsernameController.text.trim());
      Get.toNamed(Routes.CreatePassword);
      showSnackbar(context, normalResponse.msg);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      if (e is DioError)
        showSnackbar(context, e.response!.data['msg']);
      else
        showSnackbar(context, e.toString());
    }
  }


  void updatePassword(BuildContext context) async {
    try {
      isLoading.value = true;
      NormalResponse normalResponse = await resetPasswordRepository.updatePassword(emailUsernameController.text.trim(),confirmPasswordController.text.trim());
      Get.offAllNamed(Routes.Login);
      showSnackbar(context, normalResponse.msg);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      if (e is DioError)
        showSnackbar(context, e.response!.data['msg']);
      else
        showSnackbar(context, e.toString());
    }
  }






}