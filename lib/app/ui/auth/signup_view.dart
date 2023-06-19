import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_local_vendor/app/controller/auth_controller.dart';
import 'package:my_local_vendor/app/routes/app_routes.dart';
import 'package:my_local_vendor/common/color_constants.dart';
import 'package:my_local_vendor/common/utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:country_calling_code_picker/picker.dart';

class SignUpView extends GetView<AuthController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorConstants.white,
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: colorConstants.white,
      //   iconTheme: IconThemeData(color: colorConstants.black),
      // ),
      body: SafeArea(
        child: Stack(
          children: [
            Center(child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Image.asset('assets/images/app_logo.png',height: 12.h,width: 100.w,),
                  SizedBox(height: 4.h,),
                  addText("Register", getLargeTextFontSIze(), colorConstants.black, FontWeight.w600),
                  SizedBox(height: 2.h,),
                  addText("Please enter the details below to continue.", getNormalTextFontSIze()-2, colorConstants.greyTextColor, FontWeight.w600),
                  SizedBox(height: 4.h,),
                  addEditText(controller.registerName, 'Name'),
                  SizedBox(height: 1.5.h,),
                  addEditText(controller.registerEmail, 'Email'),
                  SizedBox(height: 1.5.h,),
                  // addEditText(controller.registerMobile, 'Mobile Number'),

                  Container(
                    width: 90.w,
                    decoration: BoxDecoration(
                        color: colorConstants.white,
                        // boxShadow: [getDeepBoxShadow()],
                        border: Border.all(color: colorConstants.lightGrey),
                        borderRadius: getBorderRadiusCircular()),
                    child: Row(
                      children: [
                        Container(width: 25.w,
                        // child: buildDropDown(),
                          child: GestureDetector(
                            onTap: (){
                              _showCountryPicker(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Obx(() => addText(controller.selectedCode.value, getNormalTextFontSIze(), colorConstants.black, FontWeight.normal)),
                                Icon(Icons.keyboard_arrow_down_rounded)
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 60.w,
                          child: TextFormField(
                            // inputFormatters: [CapitalCaseTextFormatter()],
                            keyboardType: TextInputType.number,
                            controller: controller.registerMobile,
                            textInputAction: TextInputAction.next,
                            style: TextStyle(fontSize: getNormalTextFontSIze()),
                            decoration: InputDecoration(
                                hintText: 'Mobile Number'.tr,
                                hintStyle: TextStyle(
                                    fontSize: getNormalTextFontSIze(),
                                    color: colorConstants.greyTextColor),
                                contentPadding: EdgeInsets.fromLTRB(20, 15, 10, 15),
                                border: InputBorder.none),
                          ),
                        )
                      ],
                    ),
                  ),


                  SizedBox(height: 1.5.h,),
                  // addEditText(controller.registerPassword, 'Password'),
                  Container(
                    width: 90.w,
                    decoration: BoxDecoration(
                        color: colorConstants.white,
                        // boxShadow: [getDeepBoxShadow()],
                        border: Border.all(color: colorConstants.lightGrey),
                        borderRadius: getBorderRadiusCircular()),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(width: 70.w,
                            child: Obx(() => TextFormField(
                              // inputFormatters: [CapitalCaseTextFormatter()],
                              keyboardType: TextInputType.text,
                              controller: controller.registerPassword,
                              textInputAction: TextInputAction.next,
                              obscureText: controller.hideSignUpPassword.value,
                              style: TextStyle(fontSize: getNormalTextFontSIze()),
                              decoration: InputDecoration(
                                  hintText: 'Password'.tr,
                                  hintStyle: TextStyle(
                                      fontSize: getNormalTextFontSIze(),
                                      color: colorConstants.greyTextColor),
                                  contentPadding: EdgeInsets.fromLTRB(20, 15, 10, 15),
                                  border: InputBorder.none),
                            ))),

                        Container(
                          margin: EdgeInsets.only(right: 20),
                          child: GestureDetector(

                              onTap: (){
                                controller.hideSignUpPassword.value = !controller.hideSignUpPassword.value;
                              },child: Obx(() => controller.hideSignUpPassword.value ? Image.asset('assets/images/hide.png',height: 30,color: colorConstants.lightGrey,) : Image.asset('assets/images/show.png',height: 30,color: colorConstants.lightGrey))
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 1.5.h,),
                  Container(
                    width: 90.w,
                    decoration: BoxDecoration(
                        color: colorConstants.white,
                        // boxShadow: [getDeepBoxShadow()],
                        border: Border.all(color: colorConstants.lightGrey),
                        borderRadius: getBorderRadiusCircular()),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(width: 70.w,
                            child: Obx(() => TextFormField(
                              // inputFormatters: [CapitalCaseTextFormatter()],
                              keyboardType: TextInputType.text,
                              controller: controller.registerConfrmPassword,
                              textInputAction: TextInputAction.next,
                              obscureText: controller.hideSignUpCPassword.value,
                              style: TextStyle(fontSize: getNormalTextFontSIze()),
                              decoration: InputDecoration(
                                  hintText: 'Confirm Password'.tr,
                                  hintStyle: TextStyle(
                                      fontSize: getNormalTextFontSIze(),
                                      color: colorConstants.greyTextColor),
                                  contentPadding: EdgeInsets.fromLTRB(20, 15, 10, 15),
                                  border: InputBorder.none),
                            ))),

                        Container(
                          margin: EdgeInsets.only(right: 20),
                          child: GestureDetector(

                              onTap: (){
                                controller.hideSignUpCPassword.value = !controller.hideSignUpCPassword.value;
                              },child: Obx(() => controller.hideSignUpCPassword.value ? Image.asset('assets/images/hide.png',height: 30,color: colorConstants.lightGrey,) : Image.asset('assets/images/show.png',height: 30,color: colorConstants.lightGrey))
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h,),
                  Obx(() => controller.isLoading.value ? getLoader() :
                  InkWell(
                    onTap: (){
                      if(controller.registerName.text.trim().length == 0)
                        showSnackbar(context, 'Please enter name');
                      else if(!controller.registerEmail.text.isValidEmail())
                        showSnackbar(context, 'Please enter valid email');
                      else if(controller.registerMobile.text.trim().length == 0)
                        showSnackbar(context, 'Please enter Mobile Number');
                      else if(controller.registerPassword.text.trim().length < 8)
                        showSnackbar(context, 'Password length should be minimum 8 digits');
                      else if(controller.registerConfrmPassword.text.trim().length < 8)
                        showSnackbar(context, 'Confirm Password length should be minimum 8 digits');
                      else if(controller.registerPassword.text != controller.registerConfrmPassword.text)
                        showSnackbar(context, "Password should match");
                      else if(!validateStructure(controller.registerConfrmPassword.text.trim()))
                        showSnackbar(context, 'Password must contain one upper case, one lower case, one letter and one symbol');
                      else
                        controller.registerUser(context);
                    },
                    child: getSolidButton(90.w, 'Register'),
                  )),

                ],
              ),
            ),),

            Positioned(
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: ()=>Get.back(),
                  child: Icon(Icons.arrow_back_rounded,color: colorConstants.black,),
                ))

          ],
        ),
      ),
    );
  }



  Widget buildDropDown() {
    return DropdownButtonHideUnderline(
      child: Obx(() => DropdownButton2(
        buttonPadding: EdgeInsets.symmetric(horizontal: 20),
        hint: Text(
          '+91',
          style: TextStyle(
              fontSize: getNormalTextFontSIze(), color: colorConstants.black),
        ),
        items: controller.coountryCodes
            .map((item) => DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: TextStyle(
              fontSize: getNormalTextFontSIze(),
            ),
          ),
        ))
            .toList(),
        // value: controller.selectedCode,
        value: controller.selectedCode.value.isNotEmpty ? controller.selectedCode.value : null,
        onChanged: (value) {
          controller.selectedCode.value = value as String;
        },
        // buttonDecoration: BoxDecoration(
        //     border: Border.all(color: colorConstants.lightGrey),
        //     borderRadius: getBorderRadiusCircular()),
        iconSize: 10,
        icon: SvgPicture.asset('assets/images/down_arrow.svg'),
        buttonWidth: 100.w,
        dropdownElevation: 1,
        dropdownDecoration: BoxDecoration(
          color: colorConstants.white,
          boxShadow: [getDeepBoxShadow()],
        ),
      )),
    );
  }

  void _showCountryPicker(BuildContext context) async{
    final country = await showCountryPickerDialog(context);
    if (country != null) {
      controller.selectedCode.value = country.callingCode.toString();
    }
  }


}