import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_local_vendor/app/controller/profile_controller.dart';
import 'package:my_local_vendor/common/color_constants.dart';
import 'package:my_local_vendor/common/utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../common/header.dart';

import '../../controller/contact_controller.dart';

class ContactView extends GetView<ContactController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorConstants.white,
      body: SafeArea(
        child: Container(

          child: Column(
            children: [
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: AppHeader(title: 'Contact'),
              ),
              SizedBox(height: 4.h,),
              Expanded(child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [

                    addText('Contact Name', getSmallTextFontSIze(), colorConstants.black, FontWeight.bold),
                    SizedBox(height: 5,),
                    addEditText(controller.nameController, 'Contact Name'),



                    SizedBox(height: 2.h,),
                    addText('Contact Email', getSmallTextFontSIze(), colorConstants.black, FontWeight.bold),
                    SizedBox(height: 5,),
                    addEditText(controller.emailController, 'Contact Email'),





                    SizedBox(height: 2.h,),
                    addText('Contact Phone', getSmallTextFontSIze(), colorConstants.black, FontWeight.bold),
                    SizedBox(height: 5,),
                    addNumberEditText(controller.phoneController, 'Contact Phone'),



                    SizedBox(height: 2.h,),
                    addText('Contact Message', getSmallTextFontSIze(), colorConstants.black, FontWeight.bold),
                    SizedBox(height: 5,),
                    Container(
                      width: 80.w,
                      height: 12.h,
                      decoration: BoxDecoration(
                          color: colorConstants.white,
                          // boxShadow: [getDeepBoxShadow()],
                          border: Border.all(color: colorConstants.lightGrey),
                          borderRadius: getBorderRadius()),
                      child: TextFormField(
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        controller: controller.messageController,
                        textInputAction: TextInputAction.newline,
                        style:  TextStyle(fontSize: getNormalTextFontSIze()),
                        decoration: InputDecoration(
                            hintText: 'Contact Message'.tr,
                            hintStyle:TextStyle(fontSize: getNormalTextFontSIze(),color: colorConstants.greyTextColor),
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 10, 15),
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(height: 2.h,),

                    GestureDetector(
                      onTap: (){

                        if(controller.nameController.text.trim().length == 0)
                          showSnackbar(context, 'Please enter Name');
                        else if(controller.emailController.text.trim().length == 0)
                          showSnackbar(context, 'Please enter Email');
                        else if(!controller.emailController.text.trim().isValidEmail())
                          showSnackbar(context, 'Please enter valid Email');
                        else if(controller.phoneController.text.trim().length == 0)
                          showSnackbar(context, 'Please enter Contact Number');
                        else if(controller.messageController.text.trim().length == 0)
                          showSnackbar(context, 'Please enter message');
                        else controller.contactUsRequest(context);

                      },
                      child: getSolidButton(90.w, 'SUBMIT'),
                    ),
                    SizedBox(height: 2.h,),




                  ],
                ),
              ))







            ],
          ),
        ),
      ),
    );
  }

}