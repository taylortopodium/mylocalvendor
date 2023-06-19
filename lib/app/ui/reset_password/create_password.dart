import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:my_local_vendor/app/controller/reset_password_controller.dart';
import 'package:my_local_vendor/app/routes/app_routes.dart';
import 'package:my_local_vendor/common/color_constants.dart';
import 'package:my_local_vendor/common/utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CreatePasswordView extends GetView<ResetPasswordController>{
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
                  child: addText('Create New Password', getLargeTextFontSIze(), colorConstants.black, FontWeight.bold)),
              SizedBox(height: 1.h,),
              Align(alignment: Alignment.topLeft,
                  child: addText("Your new password must be different from previous used passwords.", getNormalTextFontSIze(), colorConstants.black, FontWeight.normal)),
              SizedBox(height: 4.h,),
              addEditText(controller.passwordController, 'Password'),
              SizedBox(height: 2.h,),
              addEditText(controller.confirmPasswordController, 'Confirm Password'),
              SizedBox(height: 0.5.h,),
              addText('Both passwords must match', getSmallTextFontSIze(), colorConstants.greyTextColor, FontWeight.normal),
              SizedBox(height: 2.h,),
              Obx(() => controller.isLoading.value ? getLoader() : GestureDetector(
                onTap: (){
                  if(!validateStructure(controller.passwordController.text.trim())){
                    showSnackbar(context, 'Password must contain one upper case, one lower case, one letter and one symbol');
                  } else if(!validateStructure(controller.confirmPasswordController.text.trim())) {
                    showSnackbar(context, 'Confirm Password must contain one upper case, one lower case, one letter and one symbol');
                  } else if (controller.passwordController.text.trim() != controller.confirmPasswordController.text.trim()){
                    showSnackbar(context, 'Passwords should match');
                  } else controller.updatePassword(context);
                }, child: getSolidButton(90.w, 'SEND'),
              ))


            ],
          ),
        ),
      ),
    );
  }

}