import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_local_vendor/app/controller/home_controller.dart';
import 'package:my_local_vendor/app/routes/app_routes.dart';
import 'package:my_local_vendor/common/bottom_navigation.dart';
import 'package:my_local_vendor/common/color_constants.dart';
import 'package:my_local_vendor/common/drawer.dart';
import 'package:my_local_vendor/common/utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {

    // if(!HomeController().initialized){
    //   Get.put(HomeController());
    // }

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: colorConstants.white,
        statusBarIconBrightness: Brightness.dark));

    if (controller.categoriesList.isEmpty) {
      controller.getCategories(context);
    }

    controller.getProductList(context, '');

    return Scaffold(
      key: controller.key,
      backgroundColor: colorConstants.white,
      drawer: AppDrawer(),
      bottomNavigationBar: const AppBottomNavigation(),
      body: RefreshIndicator(
        onRefresh: ()async{
          // controller.getCategories(context);
          controller.currentPage = 1;
          // controller.getProductList(context, controller.categoriesList[controller.categorySelectedPos.value].id.toString());
          controller.getProductList(context, '');
        },
        child: WillPopScope(
            onWillPop: () async {
              showConfirmationPopup(context);
              return true;
            },
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.key.currentState!.openDrawer();
                          },
                          child: SvgPicture.asset(
                            'assets/images/menu.svg',
                          ),
                        ),


                        // GestureDetector(
                        //   onTap: () {},
                        //   child: Row(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       SvgPicture.asset('assets/images/Pin.svg'),
                        //       const SizedBox(
                        //         width: 5,
                        //       ),
                        //       Container(
                        //         constraints: BoxConstraints(maxWidth: 60.w),
                        //         // width: 60.w,
                        //         child:GestureDetector(
                        //           onTap: ()=>controller.getCurrentAddress(),
                        //           child:  Obx(() => controller.isLocationLoading.value ? const SizedBox(
                        //             height: 20.0,
                        //             width: 20.0,
                        //             child: CircularProgressIndicator(),
                        //           ) : addText(controller.currentAddress.value, getSmallTextFontSIze(), colorConstants.black, FontWeight.w600)),
                        //         ),)
                        //     ],
                        //   ),
                        // ),


                        addText('My Local Vendor', getNormalTextFontSIze(), colorConstants.black, FontWeight.w600),


                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.NotificationView);
                          },
                          child:
                          SvgPicture.asset('assets/images/notification.svg'),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(Routes.Search);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                          border: Border.all(color: colorConstants.lightGrey),
                          borderRadius: getBorderRadiusCircular()),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/images/search.svg'),
                          const SizedBox(
                            width: 10,
                          ),
                          addText('Search', getNormalTextFontSIze(),
                              colorConstants.lightGrey, FontWeight.normal)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  // buildCategories(),
                  // SizedBox(
                  //   height: 1.h,
                  // ),
                  Obx(() => controller.productList.isNotEmpty
                      ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        addText(
                            'Fresh Recommendations',
                            getNormalTextFontSIze(),
                            colorConstants.black,
                            FontWeight.bold),
                        GestureDetector(
                          onTap: () {

                            Get.toNamed(Routes.ProductView, arguments: {
                              'title': controller.categoriesList[controller.categorySelectedPos.value].name,
                              'categoryId': controller.categoriesList[controller.categorySelectedPos.value].id.toString(),
                              'itemType' : 'none'
                            });

                          },
                          child: addText('See All', getSmallTextFontSIze(),
                              colorConstants.white, FontWeight.bold),
                        )
                      ],
                    ),
                  )
                      : Container()),
                  SizedBox(
                    height: 2.h,
                  ),
                  Expanded(
                      child: Obx(() => controller.isProductLoading.value ? buildProductLoader() : controller.productList.isEmpty
                          ? Center(child: addText('No Item Found', getHeadingTextFontSIze(), colorConstants.black, FontWeight.bold),) : buildGrids()))
                ],
              ),
            )),
      ),
    );
  }

  Widget buildCategories() {
    return SizedBox(
      height: 55,
      child: Obx(() => controller.isLoading.value
          ? buildShimmer()
          : ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: controller.categoriesList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    controller.currentPage = 1;
                    // controller.getProductList(context, controller.categoriesList[index].id.toString());
                    controller.getProductList(context, '');
                    controller.categorySelectedPos.value = index;
                  },
                  child: Obx(() => Container(
                        margin:
                            const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        padding:
                            const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                        decoration: BoxDecoration(
                            borderRadius: getBorderRadiusCircular(),
                            // color: selectedPos == int ? colorConstants.notificationBgColor : colorConstants.notificationBgColorLight
                            color: controller.categorySelectedPos.value == index
                                ? colorConstants.black
                                : colorConstants.white,
                            boxShadow: [getDeepBoxShadow()]),
                        child: Center(
                          child: addText(
                              controller.categoriesList[index].name.toString(),
                              getNormalTextFontSIze() - 1,
                              controller.categorySelectedPos.value == index
                                  ? colorConstants.white
                                  : colorConstants.black,
                              FontWeight.normal),
                        ),
                      )),
                );
              },
            )),
    );
  }

  Widget buildSoldOutIcon() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: colorConstants.black.withOpacity(0.4),
          borderRadius: getBorderRadiusCircular()),
      child: addAlignedText('SOLD OUT', 10, colorConstants.white, FontWeight.bold),
    );
  }

  Widget buildShimmer() {
    return SizedBox(
      width: 100.w,
      height: 55,
      child: Shimmer.fromColors(
        baseColor: colorConstants.lightGrey,
        highlightColor: colorConstants.shimmerColor,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, __) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: 30.w,
                  height: 45,
                  decoration: BoxDecoration(
                      color: colorConstants.white,
                      borderRadius: getBorderRadiusCircular()),
                ),
              ],
            ),
          ),
          itemCount: 6,
        ),
      ),
    );
  }

  Widget buildGrids() {
    return GridView.builder(
      shrinkWrap: true,
      controller: controller.scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
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
          ? const EdgeInsets.only(right: 20, left: 10, bottom: 20)
          : const EdgeInsets.only(left: 20, right: 10, bottom: 20),
      decoration: BoxDecoration(
          boxShadow: [getDeepBoxShadow()],
          color: colorConstants.white,
          borderRadius: getCurvedBorderRadius()),
      child: ClipRRect(
        borderRadius: getCurvedBorderRadius(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Stack(
              children: [
                controller.productList[index].productImages.isNotEmpty ?
                Image.network(
                  controller.productList[index].productImages[0].name,
                  fit: BoxFit.cover,
                  height: 16.h,
                  width: double.infinity,
                )
                    : SizedBox(height: 16.h,child: Center(child: addText('No Image', getSmallTextFontSIze(), colorConstants.black, FontWeight.w800),),),

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
                  controller.productList[index].name,
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
                      '\$${controller.productList[index].price}',
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

  void showConfirmationPopup(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctxt) => AlertDialog(
              title: Container(),
              content: SizedBox(
                  height: 20.h,
                  width: 90.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      addAlignedText(
                          "Are you sure you want to quit?",
                          getHeadingTextFontSIze(),
                          colorConstants.black,
                          FontWeight.bold),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              exit(0);
                            },
                            child: getSolidButton(30.w, "Quit"),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          GestureDetector(
                            onTap: () {Get.back();},
                            child: addText("Cancel", getNormalTextFontSIze(), Colors.red, FontWeight.bold),)
                        ],
                      )
                    ],
                  )),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
            ));
  }

}
