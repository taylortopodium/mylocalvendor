import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:my_local_vendor/app/controller/review_controller.dart';
import 'package:my_local_vendor/app/ui/review/product_reviews.dart';
import 'package:my_local_vendor/app/ui/review/seller_reviews.dart';
import 'package:my_local_vendor/common/color_constants.dart';
import 'package:my_local_vendor/common/header.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../common/utils.dart';

class MyReviewView extends GetView<ReviewController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorConstants.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: AppHeader(title: 'Reviews'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: buildTabBar(),
            ),
            Expanded(child: Container(
              height: 50.h,
              child: TabBarView(
                controller: controller.controller,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  ProductReview(),
                  SellerReview()
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }


  Widget buildTabBar() {
    return Container(
      height: 7.5.h,
      child: Obx(() => ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: controller.categoriesList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              controller.categorySelectedPos.value =index;
              controller.controller.index = index;
            },
            child: Obx(() => Container(
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 0),
              decoration: BoxDecoration(
                  borderRadius: getBorderRadiusCircular(),
                  color: controller.categorySelectedPos.value == index
                      ? colorConstants.black
                      : colorConstants.white,
                  boxShadow: [getDeepBoxShadow()]),
              child: Center(
                child: addText(
                    controller.categoriesList[index],
                    getNormalTextFontSIze(),
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

}