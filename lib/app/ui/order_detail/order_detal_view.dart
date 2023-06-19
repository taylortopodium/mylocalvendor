import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_local_vendor/common/color_constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../common/header.dart';
import '../../../common/utils.dart';
import '../../controller/order_detail_controller.dart';

class OrderDetailView extends GetView<OrderDetailController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorConstants.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Obx(() => controller.isLoading.value ? buildLoader() : SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: AppHeader(title: 'Order Details'),
                ),

                Container(
                  width: 100.w,
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: colorConstants.white,
                      borderRadius: getCurvedBorderRadius(),
                      boxShadow: [getDeepBoxShadow()]
                  ),
                  child: Column(
                    children: [
                      Row(
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
                                controller.orderDetailsData.data.product.productImages[0].name.toString(),
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
                              addText(controller.orderDetailsData.data.createdAt.toString(), getSmallTextFontSIze() - 1, colorConstants.greyTextColor, FontWeight.normal),
                              SizedBox(
                                height: 0.5.h,
                              ),
                              addText(controller.orderDetailsData.data.product.name.toString(), getNormalTextFontSIze()+1, colorConstants.black, FontWeight.bold),
                              SizedBox(
                                height: 0.5.h,
                              ),


                              Row(
                                crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/Pin.svg',
                                    color: colorConstants
                                        .greyTextColor,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  SizedBox(
                                    width: 50.w,
                                    child: addText(controller.orderDetailsData.data.address.toString(),
                                        getSmallTextFontSIze(),
                                        colorConstants
                                            .lightGrey,
                                        FontWeight.w600),
                                  ),
                                ],
                              ),


                              addText('Quantity : 1', getSmallTextFontSIze(), colorConstants.greyTextColor, FontWeight.normal),
                              SizedBox(
                                height: 0.5.h,
                              ),

                            ],
                          )
                        ],
                      ),
                      Divider(height: 3.h),
                      Align(
                        alignment: Alignment.topLeft,
                        child: addText('Price Details', getSubheadingTextFontSIze(), colorConstants.black, FontWeight.bold),
                      ),
                      SizedBox(height: 1.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          addText('Price', getNormalTextFontSIze(), colorConstants.black, FontWeight.normal),
                          addText('\$${controller.orderDetailsData.data.total.toString()}', getNormalTextFontSIze(), colorConstants.black, FontWeight.bold),
                        ],
                      ),
                      SizedBox(height: 1.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          addText('Received Amount', getNormalTextFontSIze(), colorConstants.black, FontWeight.normal),
                          addText('\$${controller.orderDetailsData.data.amountReceived.toString()}', getNormalTextFontSIze(), colorConstants.black, FontWeight.bold),
                        ],
                      ),
                      Divider(height: 3.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          addText('Total', getNormalTextFontSIze(), colorConstants.black, FontWeight.normal),
                          addText('\$${controller.orderDetailsData.data.total.toString()}', getNormalTextFontSIze(), colorConstants.black, FontWeight.bold),
                        ],
                      ),
                      Divider(height: 3.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          addText('Payment Method : ', getSubheadingTextFontSIze(), colorConstants.black, FontWeight.bold),
                          addText(controller.orderDetailsData.data.type != 'full' ? 'Pay Later' : 'Pay Now', getSubheadingTextFontSIze(), colorConstants.buttonColor, FontWeight.bold),
                        ],
                      ),
                      addText('Order Id : #${controller.orderDetailsData.data.id}', getSubheadingTextFontSIze(), colorConstants.black, FontWeight.bold),
                      SizedBox(height: 2.h,),
                      Align(alignment: Alignment.topLeft,child:  addText('Payment', getHeadingTextFontSIze(), colorConstants.black, FontWeight.bold),),
                      SizedBox(height: 2.h,),
                      SizedBox(height: 2.h,),
                      ListView.builder(
                        itemCount: controller.orderDetailsData.data.paymentDetail.length,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              // Get.toNamed(Routes.ProductView, arguments: {
                              //   'title': controller.categoryList[index].name,
                              //   'categoryId': controller.categoryList[index].id.toString(),
                              //   'itemType': 'none'
                              // });
                            },
                            child: buildInstallments(index,context),
                          );
                        },
                      )
                    ],
                  ),
                ),





              ],
            ),
          )),
        ),
      ),
    );
  }

  Widget buildInstallments(int index,BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
          borderRadius: getCurvedBorderRadius(),
          color: colorConstants.white,
          border: Border.all(color:controller.orderDetailsData.data.paymentDetail[index].status == 1 ? Colors.green : Colors.transparent, width: 2),
          boxShadow: [getDeepBoxShadow()]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addText(
                  controller.orderDetailsData.data.paymentDetail[index].value.toString(),
                  getNormalTextFontSIze(),
                  colorConstants.black,
                  FontWeight.bold),
              addText(
                  controller.orderDetailsData.data.paymentDetail[index].dueDate.toString(),
                  getSmallTextFontSIze(),
                  colorConstants.greyTextColor,
                  FontWeight.normal)
            ],
          ),
          addText(
              '\$${controller.orderDetailsData.data.paymentDetail[index].total.toString()}',
              getHeadingTextFontSIze(),
              colorConstants.black,
              FontWeight.w900)
        ],
      ),
    );
  }

}