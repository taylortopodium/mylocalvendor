import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_local_vendor/app/controller/pay_later_controller.dart';
import 'package:my_local_vendor/common/color_constants.dart';
import 'package:my_local_vendor/common/header.dart';
import 'package:my_local_vendor/common/utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../common/bottom_navigation.dart';
import '../../routes/app_routes.dart';

class PayLaterView extends GetView<PayLaterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorConstants.white,
      bottomNavigationBar: const AppBottomNavigation(),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Obx(() => controller.isLoading.value
            ? buildLoader()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  AppHeader(title: 'Pay Later'),
                  Expanded(
                      child: ListView(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: getCurvedBorderRadius(),
                            child: SvgPicture.asset(
                              'assets/images/paylaterbg.svg',
                              width: 100.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                              left: 1,
                              right: 1,
                              bottom: 1,
                              top: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  addText(
                                      'Total Amount',
                                      getNormalTextFontSIze(),
                                      colorConstants.white,
                                      FontWeight.normal),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  addText(
                                      '\$${controller.payLaterInnerData.amount}',
                                      getLargeTextFontSIze() * 1.2,
                                      colorConstants.white,
                                      FontWeight.bold),
                                ],
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      addAlignedText(
                          'Choose Installments',
                          getNormalTextFontSIze(),
                          colorConstants.black,
                          FontWeight.bold),
                      const SizedBox(
                        height: 20,
                      ),
                      buildInstallments(),
                      const SizedBox(
                        height: 20,
                      ),
                      buildPaymentList(),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.PaymentView,
                              arguments: {'payLater': true,'isPayingEmi' : false});
                        },
                        child: getSolidButton(90.w, 'Pay'),
                      )
                    ],
                  ))
                ],
              )),
      )),
    );
  }

  Widget buildInstallments() {
    return SizedBox(
      height: 55,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: controller.payLaterInnerData.emiDetails.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              controller.installmentSelectedPos.value = index;
              controller.changeEmiListValues();
            },
            child: Obx(() => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 4),
                  decoration: BoxDecoration(
                      borderRadius: getBorderRadiusCircular(),
                      // color: selectedPos == int ? colorConstants.notificationBgColor : colorConstants.notificationBgColorLight
                      color: controller.installmentSelectedPos.value == index
                          ? colorConstants.black
                          : colorConstants.white,
                      boxShadow: [getDeepBoxShadow()]),
                  child: Center(
                    child: addText(
                        '${controller.payLaterInnerData.emiDetails[index].emiOption.toString()}',
                        getNormalTextFontSIze() - 1,
                        controller.installmentSelectedPos.value == index
                            ? colorConstants.white
                            : colorConstants.black,
                        FontWeight.normal),
                  ),
                )),
          );
        },
      ),
    );
  }

  Widget buildPaymentList() {
    return Obx(() => ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: controller.emiList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // controller.paymentSelectedPos.value = index;
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                    borderRadius: getCurvedBorderRadius(),
                    // color: selectedPos == int ? colorConstants.notificationBgColor : colorConstants.notificationBgColorLight
                    color: colorConstants.white,
                    border: Border.all(
                        color: controller.paymentSelectedPos.value == index
                            ? colorConstants.black
                            : colorConstants.white,
                        width: 2),
                    boxShadow: [getDeepBoxShadow()]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => addText(
                            controller.emiList[index].key,
                            getNormalTextFontSIze(),
                            colorConstants.black,
                            FontWeight.bold)),
                        Row(
                          children: [
                            Obx(() => addText(
                                controller.emiList[index].date,
                                getSmallTextFontSIze(),
                                colorConstants.greyTextColor,
                                FontWeight.normal)),
                            const SizedBox(width: 10,),
                            if(index != 0)
                            GestureDetector(
                              onTap: (){
                                DateTime dateTime =DateTime.parse(controller.emiList[index].date.toString());
                                controller.selectDate(context, index,dateTime);
                              },
                              child: const Icon(Icons.calendar_month_rounded,color: colorConstants.buttonColor,),
                            )
                          ],
                        )
                      ],
                    ),
                    addText(
                        '\$${controller.emiList[index].amount}',
                        getHeadingTextFontSIze(),
                        colorConstants.black,
                        FontWeight.w900)
                  ],
                ),
              ),
            );
          },
        ));
  }





}
