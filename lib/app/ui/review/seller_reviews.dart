import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:my_local_vendor/app/controller/review_controller.dart';
import 'package:my_local_vendor/common/color_constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../common/utils.dart';

class SellerReview extends GetView<ReviewController>{
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: colorConstants.white,
      body: Obx(() => controller.isSellerLoading.value ? buildLoader() : Column(
        children: [
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.star,color: colorConstants.buttonColor,size: getLargeTextFontSIze(),),
                      addText(controller.sellerReviewData.data.overallRating.toString(), getLargeTextFontSIze(), colorConstants.black, FontWeight.bold)
                    ],
                  ),
                  addText('Overall rating', getSmallTextFontSIze(), colorConstants.black, FontWeight.normal)
                ],
              ),


              Column(
                children: [
                  addText(controller.sellerReviewData.data.totalReviews.toString(), getLargeTextFontSIze(), colorConstants.black, FontWeight.bold),
                  addText('Total Reviews', getSmallTextFontSIze(), colorConstants.black, FontWeight.normal)
                ],
              ),

              Column(
                children: [
                  addText(controller.sellerReviewData.data.fiveStarReviews.toString(), getLargeTextFontSIze(), colorConstants.black, FontWeight.bold),
                  addText('5 Star Reviews', getSmallTextFontSIze(), colorConstants.black, FontWeight.normal)
                ],
              )


            ],
          ),
          SizedBox(height: 20,),
          Expanded(child: ListView.builder(
            itemCount: controller.sellerReviewData.data.reviews.length,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                  padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                  decoration: BoxDecoration(
                      boxShadow: [getDeepBoxShadow()],
                      color: colorConstants.white,
                      borderRadius: getCurvedBorderRadius()
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                              borderRadius: getBorderRadiusCircular(),
                              child : Image.network(controller.sellerReviewData.data.reviews[index].vendor.image,width: 10.w,height: 10.w,fit: BoxFit.cover,)
                          ),
                          SizedBox(width: 20,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              addText(controller.sellerReviewData.data.reviews[index].vendor.name, getNormalTextFontSIze(), colorConstants.black, FontWeight.bold),
                              RatingBar.builder(
                                itemSize: 15,
                                initialRating: controller.sellerReviewData.data.reviews[index].rating.toDouble(),
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                tapOnlyMode: false,
                                ignoreGestures: true,
                                itemCount: 5,
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: colorConstants.buttonColor,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 20,),
                      addText(controller.sellerReviewData.data.reviews[index].review.toString(), getNormalTextFontSIze(), colorConstants.black, FontWeight.bold),
                    ],
                  ),
                ),
              );
            },
          ))
        ],
      )),
    );
  }

}