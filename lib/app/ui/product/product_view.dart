import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_local_vendor/app/controller/product_controller.dart';
import 'package:my_local_vendor/app/routes/app_routes.dart';
import 'package:my_local_vendor/app/ui/product/filter_view.dart';
import 'package:my_local_vendor/common/color_constants.dart';
import 'package:my_local_vendor/common/header.dart';
import 'package:my_local_vendor/common/utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../common/bottom_navigation.dart';

class ProductView extends GetView<ProductController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorConstants.white,
      bottomNavigationBar: AppBottomNavigation(),
      body: RefreshIndicator(
        onRefresh: ()async{
          controller.getProductList(controller.categoryId,controller.itemType);
        },
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(Icons.arrow_back_ios),
                      ),
                      // Obx(() => addText(controller.title.value, getHeadingTextFontSIze(),
                       addText('Products', getHeadingTextFontSIze(),
                          colorConstants.black, FontWeight.w600),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.NotificationView);
                        },
                        child: SvgPicture.asset('assets/images/notification.svg'),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: GestureDetector(
                        onTap: (){
                          Get.toNamed(Routes.Search);
                        }, child: Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(
                            border: Border.all(color: colorConstants.lightGrey),
                            borderRadius: getBorderRadiusCircular()),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SvgPicture.asset('assets/images/search.svg'),
                            SizedBox(
                              width: 10,
                            ),
                            addText('Search', getNormalTextFontSIze(),
                                colorConstants.lightGrey, FontWeight.normal)
                          ],
                        ),
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
                    ],
                  ),
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

           Stack(
             children: [
               controller.productList[index].productImages.length>0 ? Image.network(
                 controller.productList[index].productImages[0].name,
                 fit: BoxFit.cover,
                 height: 16.h,
                 width: double.infinity,
               )
                   : Container(height: 16.h,child: Center(child: addText('No Image', getSmallTextFontSIze(), colorConstants.black, FontWeight.w800),),),

                if(controller.productList[index].quantity == 0)
                Positioned(
                 top: 8.h,
                  left: 20,
                  right: 20,
                  child: buildSoldOutIcon(),
                )
              ],
           ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: addSingleLineText(
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

  Widget buildSoldOutIcon() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: colorConstants.black.withOpacity(0.4),
          borderRadius: getBorderRadiusCircular()),
      child: addAlignedText('SOLD OUT', 10, colorConstants.white, FontWeight.bold),
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
          return FilterView();
        });
  }
}
