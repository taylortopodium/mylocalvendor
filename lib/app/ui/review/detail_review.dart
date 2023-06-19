import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:my_local_vendor/common/color_constants.dart';
import 'package:my_local_vendor/common/header.dart';
import 'package:my_local_vendor/common/utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../controller/detail_review_controller.dart';

class DetailReview extends GetView<DetailReviewController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorConstants.white,
      body: SafeArea(child: Column(
        children: [
          Padding(padding: EdgeInsets.all(20),
            child: AppHeader(title: 'Reviews'),
          ),

          Expanded(child: Obx(() => controller.isLoading.value ? buildLoader() : buildGrids()))

        ],
      )),
    );
  }

  Widget buildGrids(){
    return Column(
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
                    addText(controller.detailReviewData.data.overallRating.toString(), getLargeTextFontSIze(), colorConstants.black, FontWeight.bold)
                  ],
                ),
                addText('Overall rating', getSmallTextFontSIze(), colorConstants.black, FontWeight.normal)
              ],
            ),


            Column(
              children: [
                addText(controller.detailReviewData.data.totalReviews.toString(), getLargeTextFontSIze(), colorConstants.black, FontWeight.bold),
                addText('Total Reviews', getSmallTextFontSIze(), colorConstants.black, FontWeight.normal)
              ],
            ),

            Column(
              children: [
                addText(controller.detailReviewData.data.fiveStarReviews.toString(), getLargeTextFontSIze(), colorConstants.black, FontWeight.bold),
                addText('5 Star Reviews', getSmallTextFontSIze(), colorConstants.black, FontWeight.normal)
              ],
            )


          ],
        ),
        SizedBox(height: 20,),
        Expanded(child: ListView.builder(
          itemCount: controller.detailReviewData.data.reviews.length,
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
                            child : Image.network(controller.detailReviewData.data.reviews[index].buyer.image.toString(),width: 10.w,height: 10.w,fit: BoxFit.cover,)
                        ),
                        SizedBox(width: 20,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            addText(controller.detailReviewData.data.reviews[index].buyer.name, getNormalTextFontSIze(), colorConstants.black, FontWeight.bold),
                            RatingBar.builder(
                              itemSize: 15,
                              initialRating: controller.detailReviewData.data.reviews[index].rating.toDouble(),
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
                    addText(controller.detailReviewData.data.reviews[index].review.toString(), getNormalTextFontSIze(), colorConstants.black, FontWeight.bold),
                  ],
                ),
              ),
            );
          },
        ))
      ],
    );
  }

}