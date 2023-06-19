import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_local_vendor/app/controller/home_controller.dart';
import 'package:my_local_vendor/app/controller/payment_controller.dart';
import 'package:my_local_vendor/app/controller/product_detail_controller.dart';
import 'package:my_local_vendor/common/color_constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../common/header.dart';
import '../../../common/utils.dart';
import '../../controller/pay_later_controller.dart';

class SummaryView extends GetView<PaymentCOntroller>{

  var productData = Get.find<ProductDetailController>().productDetailData.data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorConstants.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: AppHeader(title: 'Order Overview'),
                ),

                Container(
                  width: 100.w,
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(20),
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
                                productData.productImages[0].name,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              addText(controller.getTodaysDate(), getSmallTextFontSIze() - 1, colorConstants.greyTextColor, FontWeight.normal),
                              SizedBox(
                                height: 0.5.h,
                              ),
                              addText(productData.name.toString(), getNormalTextFontSIze()+1, colorConstants.black, FontWeight.bold),
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
                                  SizedBox(
                                    width: 5,
                                  ),
                                  SizedBox(
                                    width: 50.w,
                                    child: addText(Get.find<HomeController>().currentAddress.value,
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
                          addText(controller.isPayLater.value ? '\$'+Get.find<PayLaterController>().emiList[0].amount : '\$'+productData.price.toString(), getNormalTextFontSIze(), colorConstants.black, FontWeight.bold),
                        ],
                      ),
                      SizedBox(height: 1.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          addText('Tax', getNormalTextFontSIze(), colorConstants.black, FontWeight.normal),
                          addText('\$'+'0', getNormalTextFontSIze(), colorConstants.black, FontWeight.bold),
                        ],
                      ),
                      Divider(height: 3.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          addText('Total', getNormalTextFontSIze(), colorConstants.black, FontWeight.normal),
                          addText(controller.isPayLater.value ? '\$'+Get.find<PayLaterController>().emiList[0].amount : '\$'+productData.price.toString(), getNormalTextFontSIze(), colorConstants.black, FontWeight.bold),
                        ],
                      ),
                      Divider(height: 3.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          addText('Payment Method : ', getSubheadingTextFontSIze(), colorConstants.black, FontWeight.bold),
                          addText(controller.isPayLater.value ? 'Pay Later' : 'Pay Now', getSubheadingTextFontSIze(), colorConstants.buttonColor, FontWeight.bold),
                        ],
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: addText('Confirmation Email', getSubheadingTextFontSIze(), colorConstants.black, FontWeight.bold),
                  ),
                ),
                addEditText(controller.confirmationEmailController, 'Email'),
                SizedBox(height: 2.h,),
                Obx(() => controller.isPaymentLoading.value ? getLoader() : GestureDetector(
                  onTap: (){
                    if(controller.confirmationEmailController.text.trim().length == 0)
                      showSnackbar(context, 'Please enter confirmation email');
                    else if(!controller.confirmationEmailController.text.trim().isValidEmail())
                      showSnackbar(context, 'Please enter valid email');
                    else controller.proceedPaymentAPI(context);
                  },
                  child: getSolidButton(90.w, 'Pay'),
                ))


              ],
            ),
          ),
        ),
      ),
    );
  }




}
