import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_local_vendor/app/controller/search_controller.dart';
import 'package:my_local_vendor/app/ui/search/search_filter_view.dart';
import 'package:my_local_vendor/common/color_constants.dart';
import 'package:my_local_vendor/common/header.dart';
import 'package:my_local_vendor/common/utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../routes/app_routes.dart';

class SearchView extends GetView<SearchController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorConstants.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AppHeader(title: 'Search'),
            ),
            SizedBox(
              height: 20,
            ),
            Row(

              children: [

               Expanded(child:  Container(
                 margin: EdgeInsets.symmetric(horizontal: 20),
                 padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                 decoration: BoxDecoration(
                     border: Border.all(color: colorConstants.lightGrey),
                     borderRadius: getBorderRadiusCircular()),
                 child: Row(
                   children: [
                     SvgPicture.asset('assets/images/search.svg'),
                     SizedBox(
                       width: 10,
                     ),
                     Container(
                       width: 50.w,
                       child: TextFormField(
                         // inputFormatters: [CapitalCaseTextFormatter()],
                         keyboardType: TextInputType.text,
                         controller: controller.searchTextController,
                         textInputAction: TextInputAction.search,
                         onFieldSubmitted: (value){
                           controller.getProductList(value);
                         },
                         autofocus: true,
                         style: TextStyle(fontSize: getNormalTextFontSIze()),
                         decoration: InputDecoration(
                             hintText: 'Search',
                             hintStyle: TextStyle(
                                 fontSize: getNormalTextFontSIze(),
                                 color: colorConstants.greyTextColor),
                             contentPadding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                             border: InputBorder.none),
                       ),
                     ),


                   ],
                 ),
               )),

                GestureDetector(
                  onTap: () {
                    _modalBottomSheetMenu(context);
                  },
                  child: Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    decoration: BoxDecoration(
                        border: Border.all(color: colorConstants.lightGrey),
                        shape: BoxShape.circle),
                    child: SvgPicture.asset('assets/images/filter.svg'),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),

              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: Container(
              // margin: const EdgeInsets.symmetric(horizontal: 0),
              // padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Obx(() => controller.isProductLoading.value
                  ? buildProductLoader()
                  : controller.productList.length == 0
                      ? Center(
                          child: addText(
                              'No Item Found',
                              getHeadingTextFontSIze(),
                              colorConstants.black,
                              FontWeight.bold),
                        )
                      : buildGrids()),
            ))
          ],
        ),
      ),
    );
  }

  Widget buildGrids() {
    return GridView.builder(
      shrinkWrap: true,
      physics: AlwaysScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisExtent: 27.h),
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          Get.toNamed(Routes.ProductDetail, arguments: {
            'title': controller.productList[index].name,
            'productId': controller.productList[index].id.toString()
          });
        },
        child: buildItem(index),
      ),
      itemCount: controller.productList.length,
    );
  }

  Widget buildItem(int index) {
    return Container(
      margin: index.isOdd
          ? EdgeInsets.only(right: 20, left: 10, bottom: 20)
          : EdgeInsets.only(left: 20, right: 10, bottom: 20),
      decoration: BoxDecoration(
          boxShadow: [getDeepBoxShadow()],
          color: colorConstants.white,
          borderRadius: getCurvedBorderRadius()),
      child: ClipRRect(
        borderRadius: getCurvedBorderRadius(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image.network(
            //   controller.productList[index].productImages[0].name,
            //   fit: BoxFit.cover,
            //   height: 16.h,
            //   width: double.infinity,
            // ),

            controller.productList[index].productImages.length > 0
                ? Image.network(
                    controller.productList[index].productImages[0].name,
                    fit: BoxFit.cover,
                    height: 16.h,
                    width: double.infinity,
                  )
                : Container(
                    height: 16.h,
                    child: Center(
                      child: addText('No Image', getSmallTextFontSIze(),
                          colorConstants.black, FontWeight.w800),
                    ),
                  ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: addText(
                  controller.productList[index].name.toString(),
                  getSmallTextFontSIze(),
                  colorConstants.black,
                  FontWeight.normal),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  addText(
                      '\$' + controller.productList[index].price.toString(),
                      getSmallTextFontSIze() - 1,
                      colorConstants.black,
                      FontWeight.w800),
                  verticalDivider(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.star,
                        color: colorConstants.buttonColor,
                        size: getHeadingTextFontSIze(),
                      ),
                      addText(
                          controller.productList[index].rating.toString(),
                          getSmallTextFontSIze(),
                          colorConstants.black,
                          FontWeight.w800),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }




  void _modalBottomSheetMenu(BuildContext context) {
    showModalBottomSheet<dynamic>(
        backgroundColor: colorConstants.white,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        ),
        context: context,
        builder: (BuildContext bc) {
          return SearchFilterView();
        });
  }




}
