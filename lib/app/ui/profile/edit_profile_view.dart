import 'dart:io';

import 'package:country_calling_code_picker/functions.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_local_vendor/app/controller/profile_controller.dart';
import 'package:my_local_vendor/app/routes/app_routes.dart';
import 'package:my_local_vendor/common/color_constants.dart';
import 'package:my_local_vendor/common/utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../common/header.dart';

class EditProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorConstants.white,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: AppHeader(title: 'Profile'),
              ),
              SizedBox(
                height: 4.h,
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    Center(
                      child: SizedBox(
                        height: 15.h,
                        width: 15.h,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: getBorderRadiusCircular(),
                              child: Obx(() => Image.network(
                                  controller.imageUrl.value,
                                  fit: BoxFit.cover,
                                  height: 15.h,
                                  width: 15.h)),
                            ),
                            Obx(() => controller.imagePicked.value
                                ? ClipRRect(
                                    borderRadius: getBorderRadiusCircular(),
                                    child: Obx(() => Image.file(
                                          File(
                                              controller.pickedFile.value.path),
                                          height: 15.h,
                                          width: 15.h,
                                          fit: BoxFit.cover,
                                        )),
                                  )
                                : Container()),
                            Positioned(
                                bottom: 5,
                                right: 5,
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      color: colorConstants.white,
                                      boxShadow: [getDeepBoxShadow()],
                                      shape: BoxShape.circle),
                                  child: GestureDetector(
                                    onTap: () {
                                      _showPicker(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgPicture.asset(
                                          'assets/images/ic_edt.svg'),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    addText('User Name', getSmallTextFontSIze(),
                        colorConstants.black, FontWeight.bold),
                    SizedBox(
                      height: 5,
                    ),
                    addEditText(controller.nameController, ''),
                    SizedBox(
                      height: 2.h,
                    ),
                    addText('Email', getSmallTextFontSIze(),
                        colorConstants.black, FontWeight.bold),
                    SizedBox(
                      height: 5,
                    ),
                    addEditText(controller.emailController, ''),
                    SizedBox(
                      height: 2.h,
                    ),
                    addText('Phone', getSmallTextFontSIze(),
                        colorConstants.black, FontWeight.bold),
                    SizedBox(
                      height: 5,
                    ),



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
                            )),
                          Container(
                            width: 60.w,
                            child: TextFormField(
                              // inputFormatters: [CapitalCaseTextFormatter()],
                              keyboardType: TextInputType.number,
                              controller: controller.phoneController,
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










                    // addEditText(controller.phoneController, ''),
                    SizedBox(
                      height: 2.h,
                    ),
                    addText('Address', getSmallTextFontSIze(),
                        colorConstants.black, FontWeight.bold),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 90.w,
                      decoration: BoxDecoration(
                          color: colorConstants.white,
                          // boxShadow: [getDeepBoxShadow()],
                          border: Border.all(color: colorConstants.lightGrey),
                          borderRadius: getBorderRadiusCircular()),
                      child: TextFormField(
                        // inputFormatters: [CapitalCaseTextFormatter()],
                        focusNode: controller.focusNode,
                        keyboardType: TextInputType.multiline,
                        controller: controller.addressController,
                        textInputAction: TextInputAction.search,
                        style: TextStyle(fontSize: getNormalTextFontSIze()),
                        onChanged: (value) {
                          controller.canshowSuggestions.value = true;
                        },
                        decoration: InputDecoration(
                            hintText: 'Address'.tr,
                            hintStyle: TextStyle(
                                fontSize: getNormalTextFontSIze(),
                                color: colorConstants.greyTextColor),
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 10, 15),
                            border: InputBorder.none),
                      ),
                    ),
                    Obx(() => controller.canshowSuggestions.value
                        ? ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.placeList.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: GestureDetector(
                                  onTap: () {
                                    controller.addressController.text =
                                        controller.placeList[index]
                                                ['description']
                                            .toString();
                                    controller.placeList.clear();
                                    controller.focusNode.unfocus();
                                    controller.canshowSuggestions.value = false;
                                  },
                                  child: Text(controller.placeList[index]
                                      ['description']),
                                ),
                              );
                            },
                          )
                        : Container()),
                    SizedBox(
                      height: 2.h,
                    ),
                    addText('City', getSmallTextFontSIze(),
                        colorConstants.black, FontWeight.bold),
                    SizedBox(
                      height: 5,
                    ),
                    addEditText(controller.cityController, ''),
                    SizedBox(
                      height: 2.h,
                    ),
                    addText('About Me', getSmallTextFontSIze(),
                        colorConstants.black, FontWeight.bold),
                    SizedBox(
                      height: 5,
                    ),
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
                        controller: controller.aboutMeController,
                        textInputAction: TextInputAction.newline,
                        style: TextStyle(fontSize: getNormalTextFontSIze()),
                        decoration: InputDecoration(
                            hintText: 'Comment'.tr,
                            hintStyle: TextStyle(
                                fontSize: getNormalTextFontSIze(),
                                color: colorConstants.greyTextColor),
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 10, 15),
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    // Obx(() => CheckboxListTile(
                    //       controlAffinity: ListTileControlAffinity.leading,
                    //       contentPadding: EdgeInsets.zero,
                    //       activeColor: colorConstants.black,
                    //       dense: true,
                    //       checkboxShape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(3)),
                    //       side: BorderSide(color: colorConstants.greyTextColor),
                    //       title: addText(
                    //           'Show Email to Other User',
                    //           GetPlatform.isIOS
                    //               ? getNormalTextFontSIze()
                    //               : getSmallTextFontSIze(),
                    //           colorConstants.black,
                    //           FontWeight.bold),
                    //       value: controller.showEmail.value,
                    //       onChanged: (value) {
                    //         controller.showEmail.value = value!;
                    //       },
                    //     )),
                    // Obx(() => CheckboxListTile(
                    //       controlAffinity: ListTileControlAffinity.leading,
                    //       contentPadding: EdgeInsets.zero,
                    //       activeColor: colorConstants.black,
                    //       dense: true,
                    //       checkboxShape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(3)),
                    //       side: BorderSide(color: colorConstants.greyTextColor),
                    //       title: addText(
                    //           'Show Phone Number to Other User',
                    //           GetPlatform.isIOS
                    //               ? getNormalTextFontSIze()
                    //               : getSmallTextFontSIze(),
                    //           colorConstants.black,
                    //           FontWeight.bold),
                    //       value: controller.showPhone.value,
                    //       onChanged: (value) {
                    //         controller.showPhone.value = value!;
                    //       },
                    //     )),
                    SizedBox(
                      height: 2.h,
                    ),
                    Obx(
                      () => controller.isUpdating.value
                          ? Align(
                              alignment: Alignment.center,
                              child: getLoader(),
                            )
                          : GestureDetector(
                              onTap: () {
                                if (controller.nameController.text
                                        .trim()
                                        .length ==
                                    0)
                                  showSnackbar(context, 'Please enter name');
                                else if (controller.emailController.text
                                        .trim()
                                        .length ==
                                    0)
                                  showSnackbar(context, 'Please enter email');
                                else if (controller.phoneController.text
                                        .trim()
                                        .length ==
                                    0)
                                  showSnackbar(context, 'Please enter phone');
                                else if (controller.addressController.text
                                        .trim()
                                        .length ==
                                    0)
                                  showSnackbar(context, 'Please enter address');
                                else if (controller.cityController.text
                                        .trim()
                                        .length ==
                                    0)
                                  showSnackbar(context, 'Please enter city');
                                // else if (controller.aboutMeController.text.trim().length ==0)
                                //   showSnackbar(context, 'Please enter about yourself');
                                else
                                  controller.updateProfile(context);
                              },
                              child: getSolidButton(90.w, 'SAVE'),
                            ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     Get.toNamed(Routes.ResetPassword);
                    //   },
                    //   child: getSolidButton(90.w, 'PASSWORD CHANGE'),
                    // ),
                    SizedBox(
                      height: 2.h,
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        ),
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
              child: Container(
            child: new Wrap(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                new ListTile(
                    leading: new Icon(
                      Icons.photo_library,
                      color: colorConstants.buttonColor,
                    ),
                    title: addText("Photo Library", getNormalTextFontSIze(),
                        colorConstants.greyTextColor, FontWeight.w500),
                    onTap: () {
                      controller.imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera,
                      color: colorConstants.buttonColor),
                  title: addText("Camera", getNormalTextFontSIze(),
                      colorConstants.greyTextColor, FontWeight.w500),
                  onTap: () {
                    controller.imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ));
        });
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
