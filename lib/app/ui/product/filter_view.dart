import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:my_local_vendor/app/controller/product_controller.dart';
import 'package:my_local_vendor/common/color_constants.dart';
import 'package:my_local_vendor/common/utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class FilterView extends StatefulWidget {
  const FilterView({Key? key}) : super(key: key);

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  var controller = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Container(
                width: 30.w,
                height: 5,
                decoration: BoxDecoration(
                    color: colorConstants.lightGrey,
                    borderRadius: getBorderRadiusCircular()),
              ),
              SizedBox(
                height: 20,
              ),
              Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: addText('Filter', getHeadingTextFontSIze(),
                        colorConstants.black, FontWeight.bold),
                  ),
                  Positioned(
                      right: 10,
                      child: GestureDetector(
                        onTap: () => Get.back(),
                        child: Icon(
                          Icons.close,
                          color: colorConstants.lightGrey,
                          size: getLargeTextFontSIze() * 1.2,
                        ),
                      ))
                ],
              ),
              Divider(
                height: 5.h,
                thickness: 1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildDropDown(),
                    SizedBox(
                      height: 2.h,
                    ),


                    // Container(
                    //   width: 100.w,
                    //   padding:
                    //       EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    //   decoration: BoxDecoration(
                    //       borderRadius: getBorderRadiusCircular(),
                    //       border: Border.all(color: colorConstants.lightGrey)),
                    //   child: addText('Select Location', getNormalTextFontSIze(),
                    //       colorConstants.black, FontWeight.normal),
                    // ),


                    addEditText(controller.locationController, 'Location'),
                    SizedBox(
                      height: 2.h,
                    ),
                    Obx(() => addText('Price Range (\$${controller.priceValue.value})', getNormalTextFontSIze(),
                        colorConstants.black, FontWeight.bold)),
                    Obx(
                      () => SfSlider(
                        min: 0.0,
                        max: 20000.0,
                        value: controller.priceValue.value,
                        interval: 5000,
                        showTicks: true,
                        showLabels: true,
                        numberFormat: NumberFormat("\$"),
                        enableTooltip: true,
                        tooltipShape: SfPaddleTooltipShape(),
                        stepSize: 5,
                        minorTicksPerInterval: 1,
                        activeColor: colorConstants.black,
                        inactiveColor: colorConstants.lightGrey,
                        onChanged: (dynamic value) {
                          controller.priceValue.value = value;
                        },
                      ),
                    ),

                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 20),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       addText('0', getSmallTextFontSIze(), colorConstants.greyTextColor, FontWeight.normal),
                    //       addText('20k', getSmallTextFontSIze(), colorConstants.greyTextColor, FontWeight.normal),
                    //     ],
                    //   ),
                    // ),

                    SizedBox(
                      height: 2.h,
                    ),
                    addText('Sort by', getNormalTextFontSIze(),
                        colorConstants.black, FontWeight.bold),
                    buildSortBy(),
                    SizedBox(
                      height: 2.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        // controller.title.value = controller.selectedCategory!;
                        controller.getFilteredItems(
                            controller.categoryId==null ? controller.originalCatId : controller.categoryId,
                            controller.itemType,
                            controller
                                .sortList[controller.sortSelectedPos.value],
                            controller.priceValue.value.toString(),
                        controller.locationController.text.trim());
                      },
                      child: getSolidButton(100.w, 'Apply Filter'),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                          controller.title.value = controller.originalTitle;
                          controller.categoryId = controller.originalCatId;
                          controller.getProductList(controller.categoryId, controller.itemType);
                        },
                        child: addText('CLEAR', getNormalTextFontSIze(),
                            colorConstants.black, FontWeight.bold),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget buildDropDown() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        buttonPadding: EdgeInsets.symmetric(horizontal: 20),
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
        value: controller.selectedCategory,
        onChanged: (value) {
          setState(() {
            controller.selectedCategory = value as String;
            for (int i = 0; i < controller.categortList.length; i++) {
              if (controller.selectedCategory == controller.categortList[i].name)
                controller.categoryId = controller.categortList[i].id.toString();
            }
          });
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
      ),
    );
  }

  Widget buildSortBy() {
    return GridView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          setState(() {
            controller.sortSelectedPos.value = index;
          });
        },
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: getBorderRadius(),
          ),
          child: Row(
            children: [
              Stack(
                children: [
                  if (controller.sortSelectedPos != index)
                    Container(
                      width: 30,
                      height: 20,
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFB7B7B7)),
                          shape: BoxShape.circle),
                    ),
                  if (controller.sortSelectedPos == index)
                    SvgPicture.asset(
                      'assets/images/radio_icon.svg',
                      width: 30,
                      height: 30,
                    )
                ],
              ),
              SizedBox(
                width: 20,
              ),
              addText(controller.sortList[index], getNormalTextFontSIze() - 1,
                  colorConstants.black, FontWeight.bold)
            ],
          ),
        ),
      ),
      // itemCount: subCategoryList.length,
      itemCount: 4,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisExtent: 5.h),
    );
  }
}
