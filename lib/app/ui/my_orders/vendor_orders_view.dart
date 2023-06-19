import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_local_vendor/app/controller/my_orders_controller.dart';
import 'package:my_local_vendor/common/bottom_navigation.dart';
import 'package:my_local_vendor/common/color_constants.dart';
import 'package:my_local_vendor/common/header.dart';
import 'package:my_local_vendor/common/utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class VendorOrdersView extends GetView<MyOrdersController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorConstants.white,
      bottomNavigationBar: AppBottomNavigation(),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: AppHeader(title: 'Vendor Orders'),
              ),
              SizedBox(
                height: 4.h,
              ),
              Expanded(
                  child: Obx(() => controller.isLoading.value ? buildLoader() : ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: controller.vendororderList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                            decoration: BoxDecoration(
                                color: colorConstants.white,
                                borderRadius: getCurvedBorderRadius(),
                                boxShadow: [getDeepBoxShadow()]),
                            child: Stack(
                              children: [
                                Positioned(
                                  right: 0,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 2),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20)),
                                        color: controller.vendororderList[index].status == 0 ? Colors.yellow : Colors.green,
                                    ),
                                    child: addText(
                                        controller.vendororderList[index].status == 0 ? 'Pending' :'Completed',
                                        getSmallTextFontSIze(),
                                        colorConstants.white,
                                        FontWeight.w600),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(20),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 10.h,
                                        height: 10.h,
                                        child: ClipRRect(
                                          borderRadius: getCurvedBorderRadius(),
                                          child: Image.network(
                                              controller.vendororderList[index].product.productImages[0].name,fit: BoxFit.cover,),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          addText(
                                              controller.vendororderList[index].createdAt,
                                              getSmallTextFontSIze() - 1,
                                              colorConstants.greyTextColor,
                                              FontWeight.w600),
                                          SizedBox(
                                            height: 0.5.h,
                                          ),
                                          addText(
                                              controller.vendororderList[index].product.name,
                                              getSmallTextFontSIze(),
                                              colorConstants.black,
                                              FontWeight.w600),
                                          SizedBox(
                                            height: 0.5.h,
                                          ),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              addText(
                                                  '\$'+controller.vendororderList[index].total.toString(),
                                                  getNormalTextFontSIze(),
                                                  colorConstants.black,
                                                  FontWeight.w900),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              SvgPicture.asset(
                                                'assets/images/Pin.svg',
                                                color: colorConstants.greyTextColor,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              SizedBox(
                                                width: 35.w,
                                                child: addText(
                                                    controller.vendororderList[index].address.toString(),
                                                    getSmallTextFontSIze(),
                                                    colorConstants.lightGrey,
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
                                                  colorConstants.black,
                                                  FontWeight.w600),
                                              addText(
                                                  controller.vendororderList[index].status == 0 ? 'Pending' : 'Paid',
                                                  getSmallTextFontSIze(),
                                                  controller.vendororderList[index].status == 0 ? Colors.yellow : Colors.green,
                                                  FontWeight.w600),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ));
                    },
                  )))
            ],
          ),
        ),
      ),
    );
  }
}
