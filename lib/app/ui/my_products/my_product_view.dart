import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:my_local_vendor/common/color_constants.dart';
import 'package:my_local_vendor/common/header.dart';
import 'package:my_local_vendor/common/utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../controller/my_product_controller.dart';
import '../../routes/app_routes.dart';

class MyProductView extends GetView<MyProductController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorConstants.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(padding: const EdgeInsets.all(20),
            child: AppHeader(title: 'My Products'),
            ),

            Expanded(child: Obx(() => controller.isLoading.value ? buildProductLoader() : controller.userProductsData.data.length == 0 ? Center(child:
            addText('No Products Added', getNormalTextFontSIze(), colorConstants.black, FontWeight.bold)) : buildGrids(context)))


          ],
        ),
      ),
    );
  }


  Widget buildGrids(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisExtent: 27.h),
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {


        },
        child: buildItem(index,context),
      ),
      itemCount: controller.userProductsData.data.length,
    );
  }

  Widget buildItem(int index,BuildContext context) {
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
                controller.userProductsData.data[index].productImages.length>0 ?
                Image.network(
                  controller.userProductsData.data[index].productImages[0].name,
                  fit: BoxFit.cover,
                  height: 16.h,
                  width: double.infinity,
                )
                    : SizedBox(height: 16.h,child: Center(child: addText('No Image', getSmallTextFontSIze(), colorConstants.black, FontWeight.w800),),),

                // if(controller.userProductsData.data[index].quantity == 0)
                //   Positioned(
                //     top: 8.h,
                //     left: 20,
                //     right: 20,
                //     child: buildSoldOutIcon(),
                //   )



                Positioned(
                    right: 10,
                    top: 10,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: (){
                            Get.toNamed(Routes.EditProductView, arguments: {
                              'index': index,
                              'productData': controller.userProductsData.data[index]
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: colorConstants.white,
                                boxShadow: [getDeepBoxShadow()],
                                shape: BoxShape.circle,
                                border: Border.all(color: colorConstants.black,width: 0.5)
                            ), child: const Icon(Icons.edit,size: 18,),
                          ),
                        ),
                        const SizedBox(height: 10,),
                        GestureDetector(
                          onTap: (){
                            showConfirmationPopup(context,index);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: colorConstants.white,
                                boxShadow: [getDeepBoxShadow()],
                                shape: BoxShape.circle,
                              border: Border.all(color: colorConstants.black,width: 0.5)
                            ), child: const Icon(Icons.delete_rounded,size: 18,color: Colors.red,),
                          ),
                        )
                      ],
                    )),



              ],
            ),


            Padding(
              padding: const EdgeInsets.all(8.0),
              child: addSingleLineText(
                  controller.userProductsData.data[index].name,
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
                      '\$${controller.userProductsData.data[index].price}',
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
                          controller.userProductsData.data[index].rating.toString(),
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


  void showConfirmationPopup(BuildContext context,int index) {
    showDialog(
        context: context,
        builder: (ctxt) =>  AlertDialog(
          title: Container(),
          content: SizedBox(
              height: 20.h,
              width: 90.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  addAlignedText(
                      "Are you sure you want to delete this product?",
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
                          Get.back();
                        },
                        child: getSolidButton(30.w, "Cancel"),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                          controller.deleteProduct(context, controller.userProductsData.data[index].id.toString(), index);
                        },
                        child: addText("Delete", getNormalTextFontSIze(), Colors.red, FontWeight.bold),)
                    ],
                  )
                ],
              )),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30)),
        ));
  }



}