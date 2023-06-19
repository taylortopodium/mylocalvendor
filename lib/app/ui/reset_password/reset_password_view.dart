import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:my_local_vendor/app/controller/reset_password_controller.dart';
import 'package:my_local_vendor/app/routes/app_routes.dart';
import 'package:my_local_vendor/common/color_constants.dart';
import 'package:my_local_vendor/common/utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ResetPasswordView extends GetView<ResetPasswordController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorConstants.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 20,),
              Align(alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: ()=>Get.back(),
                    child: Icon(Icons.arrow_back_ios,color: colorConstants.black,),
                  )),
              SizedBox(height: 10.h,),
              Align(alignment: Alignment.topLeft,
                child: addText('Reset Password', getLargeTextFontSIze(), colorConstants.black, FontWeight.bold)),
              SizedBox(height: 1.h,),
              Align(alignment: Alignment.topLeft,
                  child: addText("Enter the email associated with your account and we'll send an email with instruction to reset your password.", getNormalTextFontSIze(), colorConstants.black, FontWeight.normal)),
              SizedBox(height: 4.h,),
              addEditText(controller.emailUsernameController, 'Email'),
              SizedBox(height: 2.h,),
              Obx(() => controller.isLoading.value ? getLoader() : GestureDetector(
                onTap: (){
                  if(!controller.emailUsernameController.text.trim().isValidEmail()){
                    showSnackbar(context, 'Please enter valid email');
                  } else controller.checkEmail(context);
                }, child: getSolidButton(90.w, 'SEND'),
              ))


            ],
          ),
        ),
      ),
    );
  }

}