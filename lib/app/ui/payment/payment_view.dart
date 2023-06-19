import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_local_vendor/app/controller/payment_controller.dart';
import 'package:my_local_vendor/app/model/card_list_data.dart';
import 'package:my_local_vendor/app/routes/app_routes.dart';
import 'package:my_local_vendor/common/bottom_navigation.dart';
import 'package:my_local_vendor/common/color_constants.dart';
import 'package:my_local_vendor/common/header.dart';
import 'package:my_local_vendor/common/utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;

class PaymentView extends GetView<PaymentCOntroller> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorConstants.white,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              showForm(context);
            },
            child: getSolidButton(90.w, 'Add New Card'),
          ),
          SizedBox(
            height: 2.h,
          ),
          Obx(() => controller.isPaymentLoading.value
              ? getLoader()
              : GestureDetector(
                  onTap: () {
                    if (controller.cardList.isNotEmpty) {
                      Get.toNamed(Routes.SummaryView);
                    } else {
                      showSnackbar(context, 'Please add Card');
                    }
                  },
                  child: getSolidButton(90.w, 'Pay Now'),
                )),
          const SizedBox(
            height: 0,
          ),
          const AppBottomNavigation()
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              AppHeader(title: 'Payment'),
              SizedBox(
                height: 4.h,
              ),
              Obx(
                () => controller.cardList.isEmpty
                    ? Container()
                    : Align(
                        alignment: Alignment.topLeft,
                        child: addText('Added Card', getNormalTextFontSIze(),
                            colorConstants.black, FontWeight.bold),
                      ),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(() => controller.isLoading.value
                  ? Expanded(
                      child: Center(
                        child: buildLoader(),
                      ),
                    )
                  : controller.cardList.isEmpty
                      ? Container(
                          margin: EdgeInsets.only(top: 30.h),
                          child: addText(
                              'No cards added',
                              getHeadingTextFontSIze(),
                              colorConstants.black,
                              FontWeight.w700),
                        )
                      : buildAddedCreditCards())
            ],
          ),
        ),
      ),
    );
  }

  Future<Map<String, dynamic>?> createPaymentIntent(
      String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        // amount charged will be specified when the method is called
        'currency': currency,
        // the currency
        'payment_method_types[]': 'card'
        //card
      };
      var response = await http.post(
          Uri.parse(controller.paymentApiUrl), //api url
          body: body, //request body
          headers: controller
              .headers //headers of the request specified in the base class
          );
      return jsonDecode(response.body); //decode the response to json
    } catch (error) {
      print('Error occured : ${error.toString()}');
    }
    return null;
  }

  Widget buildAddedCreditCards() {
    return Expanded(
        child: Obx(() => ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: controller.cardList.length,
              itemBuilder: (context, index) {
                return Slidable(
                  key: const ValueKey(0),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (BuildContext context) {
                          controller.removeCard(context,
                              controller.cardList[index].id.toString());
                        },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete_forever,
                        label: 'Delete',
                        borderRadius: getCurvedBorderRadius(),
                      ),
                    ],
                  ),
                  child: GestureDetector(
                      onTap: () {
                        controller.cardSelectedPos.value = index;
                        controller.cardId.value =
                            controller.cardList[index].id.toString();
                      },
                      child: Container(
                        height: 15.h,
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        decoration: const BoxDecoration(),
                        child: Stack(
                          children: [
                            Obx(() => Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: getCurvedBorderRadius(),
                                      border:
                                          controller.cardSelectedPos.value ==
                                                  index
                                              ? Border.all(
                                                  color: Colors.green, width: 2)
                                              : null),
                                  child: ClipRRect(
                                    borderRadius: getCurvedBorderRadius(),
                                    child: SvgPicture.asset(
                                      'assets/images/paylaterbg.svg',
                                      width: 100.w,
                                      fit: BoxFit.cover,
                                      // color: controller.cardSelectedPos.value == index ? Colors.white.withOpacity(0.1) : null,
                                    ),
                                  ),
                                )),
                            Container(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      addText(
                                          controller.cardList[index].name,
                                          getNormalTextFontSIze(),
                                          colorConstants.white,
                                          FontWeight.normal),
                                      GestureDetector(
                                        onTap: () {
                                          showEditForm(context,
                                              controller.cardList[index]);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 3),
                                          decoration: BoxDecoration(
                                            color: colorConstants.buttonColor,
                                            borderRadius:
                                                getCurvedBorderRadius(),
                                          ),
                                          child: Center(
                                            child: addText(
                                                'Edit',
                                                getSmallTextFontSIze() + 1,
                                                colorConstants.white,
                                                FontWeight.normal),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/images/maestro.svg'),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          addText(
                                              '**** ${controller.cardList[index].cardNumber.substring(controller.cardList[index].cardNumber.length - 4)}',
                                              getNormalTextFontSIze(),
                                              colorConstants.white,
                                              FontWeight.normal),
                                        ],
                                      ),
                                      addText(
                                          controller.cardList[index].expiryDate
                                              .toString(),
                                          getNormalTextFontSIze(),
                                          colorConstants.white,
                                          FontWeight.normal),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )),
                );
              },
            )));
  }

  Widget buildLoader() {
    return Shimmer.fromColors(
      baseColor: colorConstants.lightGrey,
      highlightColor: colorConstants.shimmerColor,
      enabled: true,
      child: ListView.builder(
        itemBuilder: (_, __) => Container(
          height: 15.h,
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            borderRadius: getCurvedBorderRadius(),
            color: colorConstants.white,
          ),
          child: Container(),
        ),
        itemCount: 6,
      ),
    );
  }

  void showForm(BuildContext context) {
    controller.cardNoController.clear();
    controller.cardNameController.clear();
    controller.expiryController.clear();
    controller.cvvController.clear();
    // Get.dialog(Center(
    //   child: ,
    // ));

    showDialog(
        context: context,
        builder: (ctxt) => AlertDialog(
              insetPadding: EdgeInsets.zero,
              contentPadding: EdgeInsets.zero,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              title: Container(),
              content: Container(
                width: 90.w,
                height: 50.h,
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                decoration: BoxDecoration(
                    borderRadius: getCurvedBorderRadius(),
                    color: colorConstants.white),
                child: ClipRRect(
                    borderRadius: getCurvedBorderRadius(),
                    child: Scaffold(
                      backgroundColor: colorConstants.white,
                      body: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20),
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
                            addText('Add New Card', getHeadingTextFontSIze(),
                                colorConstants.black, FontWeight.bold),
                            const SizedBox(
                              height: 10,
                            ),
                            addEditText(
                                controller.cardNameController, 'Name on Card'),
                            const SizedBox(
                              height: 10,
                            ),
                            addPatternEditText(controller.cardNoController,
                                'Card Number', '#### #### #### ####'),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 40.w,
                                  child: addPatternEditText(
                                      controller.expiryController,
                                      'mm/yy',
                                      '##/##'),
                                ),
                                SizedBox(
                                  width: 40.w,
                                  child: addNumberLimitEditText(
                                      controller.cvvController,
                                      'Security Code',
                                      4),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                // Get.back();
                                // controller.cardListLength.value++;
                                if (int.parse(controller.expiryController.text
                                        .substring(0, 2)) >
                                    12) {
                                  showSnackbar(context,
                                      'Please enter valid Expiry Date');
                                } else {
                                  if (controller
                                      .validateCardNumWithLuhnAlgorithm(
                                          controller.cardNoController.text,
                                          context)) controller.addCard(context);
                                }
                              },
                              child: getSolidButton(80.w, 'Submit'),
                            )
                          ],
                        ),
                      ),
                    )),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
            ));
  }

  void showEditForm(BuildContext context, CardListDatum cardListDatum) {
    controller.cardNoController.text = cardListDatum.cardNumber.toString();
    controller.cardNameController.text = cardListDatum.name.toString();
    controller.expiryController.text = cardListDatum.expiryDate.toString();
    controller.cvvController.text = cardListDatum.securityCode.toString();

    showDialog(
        context: context,
        builder: (ctxt) => AlertDialog(
              insetPadding: EdgeInsets.zero,
              contentPadding: EdgeInsets.zero,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              title: Container(),
              content: Container(
                width: 90.w,
                height: 50.h,
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                decoration: BoxDecoration(
                    borderRadius: getCurvedBorderRadius(),
                    color: colorConstants.white),
                child: ClipRRect(
                    borderRadius: getCurvedBorderRadius(),
                    child: Scaffold(
                      backgroundColor: colorConstants.white,
                      body: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20),
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
                            addText('Edit Card', getHeadingTextFontSIze(),
                                colorConstants.black, FontWeight.bold),
                            const SizedBox(
                              height: 10,
                            ),
                            addEditText(
                                controller.cardNameController, 'Name on Card'),
                            const SizedBox(
                              height: 10,
                            ),
                            addNumberEditText(
                                controller.cardNoController, 'Card Number'),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 40.w,
                                  child: addPatternEditText(
                                      controller.expiryController,
                                      'Expiry Date',
                                      '##/##'),
                                ),
                                SizedBox(
                                  width: 40.w,
                                  child: addNumberEditText(
                                      controller.cvvController,
                                      'Security Code'),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.back();
                                // controller.cardListLength.value++;
                                if (int.parse(controller.expiryController.text
                                        .substring(0, 2)) >
                                    12) {
                                  showSnackbar(context,
                                      'Please enter valid Expiry Date');
                                } else {
                                  if (controller
                                      .validateCardNumWithLuhnAlgorithm(
                                          controller.cardNoController.text,
                                          context)) {
                                    controller.editCard(context, cardListDatum);
                                  }
                                  // controller.addCard(context);

                                }
                              },
                              child: getSolidButton(80.w, 'Submit'),
                            )
                          ],
                        ),
                      ),
                    )),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
            ));
  }

  void showProductSummary(BuildContext context) {
    // controller.proceedPaymentAPI(context);
    // Get.dialog();
  }
}
