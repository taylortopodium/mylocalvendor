import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_local_vendor/app/controller/my_product_controller.dart';
import 'package:my_local_vendor/common/color_constants.dart';
import 'package:my_local_vendor/common/header.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../common/utils.dart';
import '../../controller/edit_product_controller.dart';
import '../../model/user_products_data.dart';

class EditProductView extends GetView<EditProductController>{



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: colorConstants.white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
          child: Column(
            children: [
              AppHeader(title: 'Edit Product'),
              SizedBox(
                height: 4.h,
              ),
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [



                        SizedBox(
                          height: 2.h,
                        ),
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
                        addText('Edit product photos', getSmallTextFontSIze(),
                            colorConstants.black, FontWeight.bold),
                        SizedBox(
                          height: 2.h,
                        ),


                        Obx(() => GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3, mainAxisExtent: 20.h,crossAxisSpacing: 10,mainAxisSpacing: 10),
                          itemBuilder: (context, index) => ClipRRect(
                            borderRadius: getCurvedBorderRadius(),
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: [getDeepBoxShadow()],
                                  color: colorConstants.white
                              ),
                              child: Stack(
                                children: [
                                  Image.network(controller.downloadedImageList[index].name.toString(),fit: BoxFit.cover,height: 20.h,),
                                  Positioned(
                                      top: 10,
                                      right: 10,
                                      child: GestureDetector(
                                        onTap: (){
                                          controller.deleteAPI(context, controller.downloadedImageList[index].id.toString(), index);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: colorConstants.white,
                                              boxShadow: [getDeepBoxShadow()]
                                          ),child: const Icon(Icons.close,color: colorConstants.black,size: 15,),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ),
                          itemCount: controller.downloadedImageList.length,
                        )),
                        SizedBox(
                          height: 2.h,
                        ),

                        Obx(() => controller.imageList.length > 0 ? GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3, mainAxisExtent: 20.h,crossAxisSpacing: 10,mainAxisSpacing: 10),
                          itemBuilder: (context, index) => ClipRRect(
                            borderRadius: getCurvedBorderRadius(),
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: [getDeepBoxShadow()],
                                  color: colorConstants.white
                              ),
                              child: Stack(
                                children: [
                                  Image.file(File(controller.imageList[index].path),fit: BoxFit.cover,height: 20.h,),
                                  Positioned(
                                      top: 10,
                                      right: 10,
                                      child: GestureDetector(
                                        onTap: (){
                                          controller.imageList.removeAt(index);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: colorConstants.white,
                                              boxShadow: [getDeepBoxShadow()]
                                          ),child: const Icon(Icons.close,color: colorConstants.black,size: 15,),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ),
                          itemCount: controller.imageList.length,
                        ) : Container()),

                        SizedBox(
                          height: 2.h,
                        ),

                        GestureDetector(
                          onTap: () {
                            _showPicker(context);
                          },
                          child: Align(alignment: Alignment.topLeft,
                          child: SvgPicture.asset('assets/images/placeholder.svg', width: 27.w, height: 27.w,),),
                        ),



                        SizedBox(
                          height: 3.h,
                        ),
                        Obx(() => controller.isUploading.value ? Align(alignment: Alignment.center,child: getLoader(),) : GestureDetector(
                          onTap: () {
                            if(controller.priceController.text.length == 0)
                              showSnackbar(context, 'Please enter price');
                            else if(controller.descriptionController.text.length == 0)
                              showSnackbar(context, 'Please enter product description');


                            else if(controller.nameController.text.trim().length == 0)
                              showSnackbar(context, 'Please enter product name');
                            else if(controller.quantityController.text.trim().length== 0)
                              showSnackbar(context, 'Please enter product quantity');
                            else if(controller.categoryId.toString() == '')
                              showSnackbar(context, 'Please enter category');
                            else controller.updateProduct(context);
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
          'Change Category',
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
          'Change Sub-Category',
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


  void _showPicker(context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        ),
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
              child:  Container(
                child: new Wrap(
                  children: <Widget>[
                    const SizedBox(height: 20,),
                    new ListTile(
                        leading: new Icon(Icons.photo_library,color: colorConstants.buttonColor,),
                        title: addText("Photo Library", getNormalTextFontSIze(), colorConstants.greyTextColor, FontWeight.w500),
                        onTap: () {
                          controller.imgFromGallery();
                          Navigator.of(context).pop();
                        }),
                    new ListTile(
                      leading: new Icon(Icons.photo_camera,color: colorConstants.buttonColor),
                      title: addText("Camera", getNormalTextFontSIze(), colorConstants.greyTextColor, FontWeight.w500),
                      onTap: () {
                        controller.imgFromCamera();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              )
          );
        }
    );
  }






}