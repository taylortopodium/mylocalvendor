import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_local_vendor/app/controller/add_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:my_local_vendor/app/routes/app_routes.dart';
import 'package:my_local_vendor/common/color_constants.dart';
import 'package:my_local_vendor/common/utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../common/header.dart';

import '../../controller/contact_controller.dart';

class AddProductView extends GetView<AddProductController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorConstants.white,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: AppHeader(title: 'Add Product'),
              ),
              SizedBox(
                height: 4.h,
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [

                    addText('Name', getSmallTextFontSIze(),
                        colorConstants.black, FontWeight.bold),
                    const SizedBox(
                      height: 5,
                    ),
                    addEditText(controller.nameController, 'Product Name'),


                    SizedBox(
                      height: 2.h,
                    ),
                    addText('Price', getSmallTextFontSIze(),
                        colorConstants.black, FontWeight.bold),
                    const SizedBox(
                      height: 5,
                    ),
                    addNumberLimitEditText(controller.priceController, '500',10),


                    SizedBox(
                      height: 2.h,
                    ),
                    addText('Category', getSmallTextFontSIze(),
                        colorConstants.black, FontWeight.bold),
                    const SizedBox(
                      height: 5,
                    ),
                    buildDropDown(),

                    SizedBox(
                      height: 2.h,
                    ),
                    addText('Sub-Category', getSmallTextFontSIze(),
                        colorConstants.black, FontWeight.bold),
                    const SizedBox(
                      height: 5,
                    ),
                    buildSubCatDropDown(),

                    SizedBox(
                      height: 2.h,
                    ),
                    addText('Quantity', getSmallTextFontSIze(),
                        colorConstants.black, FontWeight.bold),
                    const SizedBox(
                      height: 5,
                    ),
                    addNumberEditText(
                        controller.quantityController, 'Quantity'),

                    SizedBox(
                      height: 2.h,
                    ),
                    // addText('Location', getSmallTextFontSIze(),
                    //     colorConstants.black, FontWeight.bold),
                    // SizedBox(
                    //   height: 5,
                    // ),
                    // addEditText(
                    //     controller.locationController, 'Location'),
                    // SizedBox(
                    //   height: 2.h,
                    // ),
                    addText('Description', getSmallTextFontSIze(),
                        colorConstants.black, FontWeight.bold),
                    const SizedBox(
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
                        controller: controller.descriptionController,
                        textInputAction: TextInputAction.newline,
                        style: TextStyle(fontSize: getNormalTextFontSIze()),
                        decoration: InputDecoration(
                            hintText: 'Description'.tr,
                            hintStyle: TextStyle(
                                fontSize: getNormalTextFontSIze(),
                                color: colorConstants.greyTextColor),
                            contentPadding: const EdgeInsets.fromLTRB(20, 15, 10, 15),
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    addText('Add product photos', getSmallTextFontSIze(),
                        colorConstants.black, FontWeight.bold),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showPicker(context, 0);
                          },
                          child: Obx(() => controller.imageList.length>0 ? Image.file(File(controller.imageList[0].path), width: 27.w, height: 27.w,)
                              : SvgPicture.asset('assets/images/placeholder.svg', width: 27.w, height: 27.w,)),
                        ),
                        GestureDetector(
                          onTap: () {
                            _showPicker(context, 1);
                          },
                          child: Obx(() => controller.imageList.length>1 ? Image.file(File(controller.imageList[1].path), width: 27.w, height: 27.w,)
                              : SvgPicture.asset('assets/images/placeholder.svg', width: 27.w, height: 27.w,)),
                        ),
                        GestureDetector(
                          onTap: () {
                            _showPicker(context, 2);
                          },
                          child: Obx(() => controller.imageList.length>2 ? Image.file(File(controller.imageList[2].path), width: 27.w, height: 27.w,)
                              : SvgPicture.asset('assets/images/placeholder.svg', width: 27.w, height: 27.w,)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Obx(() => controller.isUploading.value ? Align(alignment: Alignment.center,child: getLoader(),) : GestureDetector(
                      onTap: () {

                       if(controller.priceController.text.length == 0)
                          showSnackbar(context, 'Please enter price');
                        // else if(controller.locationController.text.length == 0)
                        //   showSnackbar(context, 'Please enter location');
                        else if(controller.descriptionController.text.length == 0)
                          showSnackbar(context, 'Please enter product description');
                        else if(controller.imageList.length == 0)
                          showSnackbar(context, 'Please select at least one image');


                        else if(controller.nameController.text.trim().length == 0)
                          showSnackbar(context, 'Please enter product name');
                        else if(controller.quantityController.text.trim().length== 0)
                          showSnackbar(context, 'Please enter product quantity');
                        else if(controller.categoryId.toString() == '')
                          showSnackbar(context, 'Please enter category');
                        else controller.addProduct(context);




                      },
                      child: getSolidButton(90.w, 'SUBMIT'),
                    )),
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

  Widget buildDropDown() {
    return DropdownButtonHideUnderline(
      child: Obx(() => DropdownButton2(
        buttonPadding: const EdgeInsets.symmetric(horizontal: 20),
        hint: Text(
          'Select Category',
          style: TextStyle(
              fontSize: getNormalTextFontSIze(), color: colorConstants.black),
        ),
        items: controller.categoryItems
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
        value: controller.selectedCategory.value.isNotEmpty ? controller.selectedCategory.value : null,
        onChanged: (value) {

          controller.selectedCategory.value = value as String;
          for (int i = 0; i < controller.categortList.length; i++) {
            if (controller.selectedCategory ==
                controller.categortList[i].name)
              controller.categoryId = controller.categortList[i].id.toString();
          }
          controller.selectedSubCategory.value = '';
          controller.subCategoryId = '0';
          controller.getSubCategories(controller.categoryId.toString());

        },
        buttonDecoration: BoxDecoration(
            border: Border.all(color: colorConstants.lightGrey),
            borderRadius: getBorderRadiusCircular()),
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


  Widget buildSubCatDropDown() {
    return DropdownButtonHideUnderline(
      child: Obx(() => DropdownButton2(
        buttonPadding: const EdgeInsets.symmetric(horizontal: 20),
        hint: Text(
          'Select Sub-Category',
          style: TextStyle(
              fontSize: getNormalTextFontSIze(), color: colorConstants.black),
        ),
        items: controller.subCategoryItems
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
        value: controller.selectedSubCategory.value.isNotEmpty ? controller.selectedSubCategory.value : null,
        onChanged: (value) {

          controller.selectedSubCategory.value = value as String;
          for (int i = 0; i < controller.subCategoriesList.length; i++) {
            if (controller.selectedSubCategory ==
                controller.subCategoriesList[i].name)
              controller.subCategoryId = controller.subCategoriesList[i].id.toString();
          }

          print('SubCategory : ${controller.subCategoryId.toString()}');
          print('Category : ${controller.categoryId.toString()}');

        },
        buttonDecoration: BoxDecoration(
            border: Border.all(color: colorConstants.lightGrey),
            borderRadius: getBorderRadiusCircular()),
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


  void _showPicker(context,int pos) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        ),
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
              child:  Wrap(
                children: <Widget>[
                  const SizedBox(height: 20,),
                   ListTile(
                      leading:  const Icon(Icons.photo_library,color: colorConstants.buttonColor,),
                      title: addText("Photo Library", getNormalTextFontSIze(), colorConstants.greyTextColor, FontWeight.w500),
                      onTap: () {
                        controller.imgFromGallery(pos);
                        Navigator.of(context).pop();
                      }),
                   ListTile(
                    leading:  const Icon(Icons.photo_camera,color: colorConstants.buttonColor),
                    title: addText("Camera", getNormalTextFontSIze(), colorConstants.greyTextColor, FontWeight.w500),
                    onTap: () {
                      controller.imgFromCamera(pos);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              )
          );
        }
    );
  }



}
