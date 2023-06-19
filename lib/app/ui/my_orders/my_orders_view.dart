import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_local_vendor/app/controller/my_orders_controller.dart';
import 'package:my_local_vendor/app/routes/app_routes.dart';
import 'package:my_local_vendor/common/bottom_navigation.dart';
import 'package:my_local_vendor/common/color_constants.dart';
import 'package:my_local_vendor/common/header.dart';
import 'package:my_local_vendor/common/utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyOrdersView extends GetView<MyOrdersController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorConstants.white,
      bottomNavigationBar: const AppBottomNavigation(),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AppHeader(title: 'My Orders'),
            ),
            SizedBox(
              height: 4.h,
            ),
            Expanded(
                child: Obx(() => controller.isLoading.value
                    ? buildLoader()
                    : controller.orderList.isEmpty
                        ? Center(
                            child: addText(
                                "You haven't ordered anything yet",
                                getHeadingTextFontSIze(),
                                colorConstants.black,
                                FontWeight.w500))
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: controller.orderList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () {
                                    Get.toNamed(Routes.OrderDetailView,arguments: {'orderId' : controller.orderList[index].id.toString()});
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 20),
                                    decoration: BoxDecoration(
                                        color: colorConstants.white,
                                        borderRadius: getCurvedBorderRadius(),
                                        boxShadow: [getDeepBoxShadow()]),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          right: 0,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [

                                              Container(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 2),
                                              decoration: BoxDecoration(
                                                borderRadius: const BorderRadius.only(
                                                    topRight:
                                                    Radius.circular(20)),
                                                color: controller
                                                    .orderList[index]
                                                    .status ==
                                                    0
                                                    ? Colors.yellow
                                                    : Colors.green,
                                              ),
                                              child: addText(
                                                  controller.orderList[index]
                                                      .status ==
                                                      0
                                                      ? 'Pending'
                                                      : 'Completed',
                                                  getSmallTextFontSIze(),
                                                  controller
                                                      .orderList[index]
                                                      .status ==
                                                      0
                                                      ? Colors.black
                                                      : Colors.white,
                                                  FontWeight.w600),
                                            ),

                                              GestureDetector(
                                                onTap: (){
                                                  if(controller.orderList[index].product.vendor == null){
                                                    showSnackbar(context, 'No Vendor Found for this product');
                                                  } else {
                                                    Get.toNamed(Routes.ChatView,
                                                        arguments: {
                                                          'id' : controller.orderList[index].product.vendor['id'].toString(),
                                                          'name' : controller.orderList[index].product.vendor['name'].toString(),
                                                          'image' :controller.orderList[index].product.vendor['image'].toString(),
                                                        }
                                                    );
                                                  }
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets.only(right: 10,top: 10),
                                                  child: SvgPicture.asset('assets/images/ic_chat.svg',color: colorConstants.black,),
                                                ),
                                              )
                                            ],
                                          )

                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(20),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 10.h,
                                                height: 10.h,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      getCurvedBorderRadius(),
                                                  child: Image.network(
                                                    controller
                                                        .orderList[index]
                                                        .product
                                                        .productImages[0]
                                                        .name,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  addText(
                                                      controller
                                                          .orderList[index]
                                                          .createdAt,
                                                      getSmallTextFontSIze() -
                                                          1,
                                                      colorConstants
                                                          .greyTextColor,
                                                      FontWeight.w600),
                                                  SizedBox(
                                                    height: 0.5.h,
                                                  ),
                                                  addText(
                                                      controller
                                                          .orderList[index]
                                                          .product
                                                          .name,
                                                      getSmallTextFontSIze(),
                                                      colorConstants.black,
                                                      FontWeight.w600),
                                                  SizedBox(
                                                    height: 0.5.h,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      addText('\$${controller.orderList[index].total}',
                                                          getNormalTextFontSIze(),
                                                          colorConstants
                                                              .black,
                                                          FontWeight.w900),
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      SvgPicture.asset(
                                                        'assets/images/Pin.svg',
                                                        color: colorConstants
                                                            .greyTextColor,
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      SizedBox(
                                                        width: 35.w,
                                                        child: addText(
                                                            controller
                                                                .orderList[
                                                                    index]
                                                                .address
                                                                .toString(),
                                                            getSmallTextFontSIze(),
                                                            colorConstants
                                                                .lightGrey,
                                                            FontWeight.w600),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 0.5.h,
                                                  ),
                                                  Row(
                                                    children: [
                                                      addText(
                                                          'Payment: ',
                                                          getSmallTextFontSIze(),
                                                          colorConstants
                                                              .black,
                                                          FontWeight.w600),
                                                      addText(
                                                          controller
                                                                      .orderList[
                                                                          index]
                                                                      .status ==
                                                                  0
                                                              ? 'Pending'
                                                              : 'Paid',
                                                          getSmallTextFontSIze(),
                                                          controller
                                                                      .orderList[
                                                                          index]
                                                                      .status ==
                                                                  0
                                                              ? Colors.yellow
                                                              : Colors.green,
                                                          FontWeight.w600),

                                                      const SizedBox(width: 5,),



                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),

                                        Positioned(
                                          right: 0,
                                          bottom: 0,
                                          child: GestureDetector(
                                            onTap: (){
                                              showReviewDialog(context,index);
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 2),
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    bottomRight:
                                                    Radius.circular(20)),
                                                color:colorConstants.black,
                                              ),
                                              child: addText('Add Review',
                                                  getSmallTextFontSIze(),
                                                  colorConstants.white,
                                                  FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ));
                            },
                          )))
          ],
        ),
      ),
    );
  }

  void showReviewDialog(BuildContext context,int index) {
    print('{Product Id ${controller.orderList[index].productId.toString()}');
    controller.reviewtextController.clear();
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          content: Builder(
            builder: (context) {
              return Container(
                width: 90.w,
                height: 45.h,
                decoration: BoxDecoration(
                    borderRadius: getCurvedBorderRadius(),
                    color: colorConstants.white),
                child: ClipRRect(
                    borderRadius: getCurvedBorderRadius(),
                    child: Scaffold(
                      backgroundColor: colorConstants.white,
                      body: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: GestureDetector(
                                  onTap: () => Get.back(),
                                  child: const Icon(
                                    Icons.close,
                                    color: colorConstants.black,
                                    size: 25,
                                  ),
                                ),
                              ),
                            ),
                            addText(
                                'Write your experience with the product',
                                getNormalTextFontSIze(),
                                colorConstants.black,
                                FontWeight.bold),
                            SizedBox(
                              height: 2.h,
                            ),
                            RatingBar.builder(
                              initialRating: 5,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              tapOnlyMode: false,
                              itemCount: 5,
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: colorConstants.buttonColor,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                                controller.productRating = rating.toString();
                              },
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Container(
                              width: 80.w,
                              height: 12.h,
                              decoration: BoxDecoration(
                                  color: colorConstants.white,
                                  border: Border.all(
                                      color: colorConstants.lightGrey),
                                  borderRadius: getBorderRadius()),
                              child: TextFormField(
                                maxLines: 3,
                                keyboardType: TextInputType.multiline,
                                controller: controller.reviewtextController,
                                textInputAction: TextInputAction.newline,
                                style: TextStyle(
                                    fontSize: getNormalTextFontSIze()),
                                decoration: InputDecoration(
                                    hintText: 'Comment'.tr,
                                    hintStyle: TextStyle(
                                        fontSize: getNormalTextFontSIze(),
                                        color:
                                        colorConstants.greyTextColor),
                                    contentPadding:
                                    const EdgeInsets.fromLTRB(20, 15, 10, 15),
                                    border: InputBorder.none),
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.addReview(
                                    controller.orderList[index].productId.toString(),
                                    controller.productRating.toString(),
                                    controller.reviewtextController.text,
                                    false,
                                    context);
                              },
                              child: getSolidButton(80.w, 'Submit'),
                            )
                          ],
                        ),
                      ),
                    )),
              );
            },
          ),
        ));
  }


}
