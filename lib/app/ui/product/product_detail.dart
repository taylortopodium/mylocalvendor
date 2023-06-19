import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_local_vendor/app/controller/product_detail_controller.dart';
import 'package:my_local_vendor/common/bottom_navigation.dart';
import 'package:my_local_vendor/common/color_constants.dart';
import 'package:my_local_vendor/common/preferences.dart';
import 'package:my_local_vendor/common/utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

import '../../../common/favourite_header.dart';
import '../../routes/app_routes.dart';

class ProductDetail extends GetView<ProductDetailController> {
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
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    buildAppBar(context),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                        child: ListView(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      children: [


                        CarouselSlider.builder(
                          carouselController:
                              controller.buttonCarouselController,
                          itemCount: controller
                              .productDetailData.data.productImages.length,
                          itemBuilder: (BuildContext context, int itemIndex,
                                  int pageViewIndex) =>
                              Container(
                            child: ClipRRect(
                              borderRadius: getCurvedBorderRadius(),
                              child: Image.network(
                                controller.productDetailData.data
                                    .productImages[itemIndex].name,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          options: CarouselOptions(
                            height: 66.w,
                            // aspectRatio: 16/9,
                            viewportFraction: 1,
                            initialPage: 0,
                            enableInfiniteScroll: false,
                            reverse: false,
                            autoPlay: false,
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            onPageChanged: controller.onPageChanged(),
                            scrollDirection: Axis.horizontal,
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 13.w,
                          child: buildHorizontalImages(),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                addText(
                                    controller.productDetailData.data.name,
                                    getLargeTextFontSIze(),
                                    colorConstants.black,
                                    FontWeight.bold),
                                const SizedBox(
                                  height: 20,
                                ),
                                buildInfo(
                                    'ic_productTime',
                                    controller
                                        .productDetailData.data.timeToCreated),
                                const SizedBox(
                                  height: 20,
                                ),
                                buildBoldInfo(
                                    'ic_productPrice',
                                    '\$' +
                                        controller.productDetailData.data.price
                                            .toString()),
                                const SizedBox(
                                  height: 20,
                                ),
                                buildInfo(
                                    'ic_productCat',
                                    controller
                                        .productDetailData.data.category.name),
                                const SizedBox(
                                  height: 20,
                                ),
                                buildInfo('ic_productorderInfo',
                                    "${controller
                                        .productDetailData.data.quantity.toString()} items left"),
                              ],
                            ),
                            Positioned(
                                right: 1,
                                child: GestureDetector(
                                  onTap: () => Get.toNamed(Routes.DetailReview,
                                      arguments: {
                                        'type': 'product',
                                        'id': controller
                                            .productDetailData.data.id
                                            .toString()
                                      }),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: getBorderRadius(),
                                        boxShadow: [getDeepBoxShadow()],
                                        color: colorConstants.white),
                                    child: Column(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: colorConstants.buttonColor,
                                        ),
                                        addText(
                                            controller
                                                .productDetailData.data.rating
                                                .toString(),
                                            getSmallTextFontSIze(),
                                            colorConstants.black,
                                            FontWeight.normal)
                                      ],
                                    ),
                                  ),
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        if (controller.productDetailData.data.quantity > 0)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (getValue(SharedPref.userId) ==
                                      controller
                                          .productDetailData.data.vendor.id
                                          .toString()) {
                                    showSnackbar(context,
                                        "You can't buy your own product!");
                                  } else {
                                    Get.toNamed(Routes.CheckCreditView);
                                  }
                                },
                                child: getBorderButton(42.w, 'Pay Later'),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (getValue(SharedPref.userId) ==
                                      controller
                                          .productDetailData.data.vendor.id
                                          .toString()) {
                                    showSnackbar(context,
                                        "You can't buy your own product!");
                                  } else {
                                    Get.toNamed(Routes.PaymentView,
                                        arguments: {'payLater': false,'isPayingEmi' : false});
                                  }
                                },
                                child: getSolidButton(42.w, 'Pay Now'),
                              )
                            ],
                          ),

                        if (controller.productDetailData.data.quantity == 0)
                          getDisabledButton(90.w, 'SOLD OUT'),

                        const SizedBox(
                          height: 20,
                        ),
                        addText('Product Description', getNormalTextFontSIze(),
                            colorConstants.black, FontWeight.bold),
                        const SizedBox(
                          height: 10,
                        ),
                        addText(
                            controller.productDetailData.data.description
                                .toString(),
                            getSmallTextFontSIze(),
                            colorConstants.black,
                            FontWeight.normal),
                        const SizedBox(
                          height: 20,
                        ),
                        buildSellerSection(context),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ))
                  ],
                )),
        ),
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(Icons.arrow_back_ios),
            ),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: colorConstants.white,
              ),
            ),
          ],
        ),
        SizedBox(
          width: 50.w,
          child: addSingleLineText(controller.productDetailData.data.name.toString(),
              getHeadingTextFontSIze(), colorConstants.black, FontWeight.w600),
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                controller.addToWishList(
                    context, controller.productDetailData.data.id.toString());
              },
              child: Obx(() => controller.isAdding.value
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: getLoader(),
                    )
                  : controller.isFavourite.value
                      ? SvgPicture.asset(
                          'assets/images/favourite.svg',
                          height: 20,
                        )
                      : SvgPicture.asset(
                          'assets/images/non_favourite.svg',
                          height: 20,
                        )),
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.NotificationView);
              },
              child: SvgPicture.asset('assets/images/notification.svg'),
            )
          ],
        )
      ],
    );
  }

  Widget buildHorizontalImages() {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          // controller.showCaseImageUrl.value = controller.productDetailData.data.productImages[index].name;
          controller.buttonCarouselController.jumpToPage(index);
        },
        child: Container(
          margin: const EdgeInsets.all(3),
          width: 13.w,
          height: 13.w,
          child: ClipRRect(
            borderRadius: getBorderRadius(),
            child: Image.network(
                controller.productDetailData.data.productImages[index].name,
                fit: BoxFit.cover),
          ),
        ),
      ),
      // itemCount: subCategoryList.length,
      itemCount: controller.productDetailData.data.productImages.length,
    );
  }

  Widget buildInfo(String image, String information) {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/images/$image.svg',
          width: 18,
        ),
        const SizedBox(
          width: 10,
        ),
        addText(information, getSmallTextFontSIze(), colorConstants.black,
            FontWeight.bold)
      ],
    );
  }

  Widget buildBoldInfo(String image, String information) {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/images/$image.svg',
          width: 18,
        ),
        const SizedBox(
          width: 10,
        ),
        addText(information, getSmallTextFontSIze(), colorConstants.black,
            FontWeight.w900)
      ],
    );
  }

  Widget buildSellerSection(BuildContext context) {
    return Container(
      width: 100.w,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          boxShadow: [getDeepBoxShadow()],
          color: colorConstants.white,
          borderRadius: getCurvedBorderRadius()),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              addText('Meet the seller', getNormalTextFontSIze() - 1,
                  colorConstants.black, FontWeight.bold),
              GestureDetector(
                onTap: () {
                  if (controller.productDetailData.data.can_reviewed) {
                    showReviewDialog(context);
                  } else {
                    showErrorDialog(context);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                  decoration: BoxDecoration(
                      color: colorConstants.black,
                      borderRadius: getCurvedBorderRadius()),
                  child: addText('Add Review', getSmallTextFontSIze(),
                      colorConstants.white, FontWeight.normal),
                ),
              )
            ],
          ),
          Divider(
            height: 4.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: getBorderRadiusCircular(),
                child: Image.network(
                  controller.productDetailData.data.vendor.image,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  addText(
                      controller.productDetailData.data.vendor.name,
                      getSmallTextFontSIze(),
                      colorConstants.black,
                      FontWeight.bold),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      addText(
                          controller.productDetailData.data.vendor.rating
                              .toString(),
                          getSmallTextFontSIze(),
                          colorConstants.black,
                          FontWeight.bold),
                      const SizedBox(
                        width: 5,
                      ),
                      RatingBar.builder(
                        itemSize: 15,
                        initialRating: controller
                            .productDetailData.data.vendor.rating
                            .toDouble(),
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: colorConstants.buttonColor,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                      GestureDetector(
                        // onTap: ()=>Get.toNamed(Routes.DetailReview,arguments: {'type' : 'seller','id': controller.productDetailData.data.vendor.id.toString()}),
                        onTap: () =>
                            Get.toNamed(Routes.DetailReview, arguments: {
                          'type': 'seller',
                          'id': controller.productDetailData.data.id.toString()
                        }),
                        child: addText(
                            '  (${controller.productDetailData.data.vendor.review.length})  ',
                            getSmallTextFontSIze(),
                            colorConstants.black,
                            FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  addText(
                      getTime(
                          controller.productDetailData.data.vendor.createdAt),
                      getSmallTextFontSIze() - 1,
                      colorConstants.greyTextColor,
                      FontWeight.bold),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  void showReviewDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) =>  AlertDialog(
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
                                    'Write your experience with the seller',
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
                                    controller.vendorRating = rating.toString();
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
                                      // boxShadow: [getDeepBoxShadow()],
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
                                    // if (controller.reviewtextController.text.length == 0)
                                    //   showSnackbar(context, 'Please enter review');
                                    // else
                                    controller.addReview(
                                        controller
                                            .productDetailData.data.vendor.id
                                            .toString(),
                                        controller.vendorRating.toString(),
                                        controller.reviewtextController.text,
                                        true,
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

  void showErrorDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) =>  AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              content: Builder(
                builder: (context) {
                  return Container(
                    width: 90.w,
                    height: 30.h,
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
                                SizedBox(
                                  height: 2.h,
                                ),
                                addAlignedText(
                                    "Haven't purchased this product?",
                                    getNormalTextFontSIze() + 2,
                                    colorConstants.black,
                                    FontWeight.bold),
                                SizedBox(
                                  height: 2.h,
                                ),
                                addAlignedText(
                                    "Sorry! You are not allowed to review this product since you haven't bought in on the local vendor store.",
                                    getNormalTextFontSIze(),
                                    colorConstants.black,
                                    FontWeight.normal),
                                SizedBox(
                                  height: 2.h,
                                ),
                                GestureDetector(
                                  onTap: () => Get.back(),
                                  child:
                                      getSolidButton(80.w, 'Continue Shopping'),
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

  Widget buildLoader() {
    return Shimmer.fromColors(
      baseColor: colorConstants.lightGrey,
      highlightColor: colorConstants.shimmerColor,
      child: Column(
        children: [
          Container(
            height: 30.h,
            width: 100.w,
            decoration: BoxDecoration(
                borderRadius: getCurvedBorderRadius(),
                color: colorConstants.white),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: Container(
            width: 100.w,
            height: double.infinity,
            decoration: BoxDecoration(
                borderRadius: getCurvedBorderRadius(),
                color: colorConstants.white),
          ))
        ],
      ),
    );
  }
}
