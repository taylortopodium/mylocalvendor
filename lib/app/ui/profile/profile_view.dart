import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_local_vendor/app/controller/profile_controller.dart';
import 'package:my_local_vendor/app/routes/app_routes.dart';
import 'package:my_local_vendor/common/color_constants.dart';
import 'package:my_local_vendor/common/utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

import '../../../common/header.dart';

class ProfileView extends GetView<ProfileController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorConstants.white,
      body: SafeArea(
        child: Container(

          child: Obx(() => controller.isLoading.value ? buildLoader() : Column(
            children: [
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: AppHeader(title: 'Profile'),
              ),
              SizedBox(height: 4.h,),
              SizedBox(height: 15.h,
                width: 15.h,
                child: ClipRRect(
                  borderRadius: getBorderRadiusCircular(),
                  child: Image.network(controller.profileDatum.image.toString(),fit: BoxFit.cover,),
                ),),
              SizedBox(height: 2.h,),
              addText(controller.profileDatum.name.toString(), getHeadingTextFontSIze(), colorConstants.black, FontWeight.bold),
              SizedBox(height: 0.5.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  addText(controller.profileDatum.rating.toString(), getSmallTextFontSIze(), colorConstants.black, FontWeight.bold),
                  SizedBox(width: 5,),

                  RatingBar.builder(
                    itemSize: 15,
                    initialRating: controller.profileDatum.rating.toDouble() == null ? 0.0 : controller.profileDatum.rating.toDouble(),
                    // initialRating: 0.0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    tapOnlyMode: false,
                    itemCount: 5,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: colorConstants.buttonColor,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  SizedBox(width: 5,),

                  addText('(${controller.profileDatum.totalReviews.toString()})', getSmallTextFontSIze(), colorConstants.black, FontWeight.bold),
                ],
              ),
              SizedBox(height: 0.5.h,),
              addText(controller.profileDatum.mobileNo.toString() == 'null' ? '' : controller.profileDatum.country_code.toString()+controller.profileDatum.mobileNo.toString(),  getNormalTextFontSIze()-1, colorConstants.black, FontWeight.normal),
              SizedBox(height: 2.h,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: addAlignedText(controller.profileDatum.about.toString() == 'null' ? '' : controller.profileDatum.about.toString(), getSmallTextFontSIze(), colorConstants.black, FontWeight.normal),
              ),
              SizedBox(height: 4.h,),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: colorConstants.lightGrey,width: 0.3)
                ), child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: ()=>Get.toNamed(Routes.EditProfileView),
                    child: addText('Edit', getSmallTextFontSIze(), colorConstants.black, FontWeight.bold),
                  ),
                  Container(
                    height: 6.h,
                    child: VerticalDivider(),
                  ),
                  addText('Followers (0)', getSmallTextFontSIze(), colorConstants.black, FontWeight.bold),
                  Container(
                    height: 6.h,
                    child: VerticalDivider(),
                  ),
                  addText('Following (0)', getSmallTextFontSIze(), colorConstants.black, FontWeight.bold),
                ],
              ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: colorConstants.lightGrey,width: 0.3)
                ), child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: ()=>Get.toNamed(Routes.WishlistView),
                    child:  Row(
                      children: [
                        SvgPicture.asset('assets/images/favourite.svg'),
                        SizedBox(width: 5,),
                        addText('Favorites', getNormalTextFontSIze()-1, colorConstants.black, FontWeight.bold),
                      ],
                    ),
                  ),

                  Container(
                    height: 6.h,
                    child: VerticalDivider(),
                  ),
                  GestureDetector(
                    onTap: ()=>Get.toNamed(Routes.MyProductsView),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/images/ic_productorderInfo.svg'),
                        SizedBox(width: 5,),
                        addText('My Products', getNormalTextFontSIze()-1, colorConstants.black, FontWeight.bold),
                      ],
                    ),
                  ),
                ],
              ),
              ),
              SizedBox(height: 2.h,),
              Align(alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: addText('Joined On : ${getTime(controller.profileDatum.createdAt.toString())}', getSmallTextFontSIze(), colorConstants.black, FontWeight.bold),
                ),),
              Align(alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: controller.profileDatum.emailVerifiedAt.toString() == 'null' ?
                        addText('Verified', getSmallTextFontSIze(), colorConstants.black, FontWeight.bold) :
                        addText('Verified: ${controller.profileDatum.emailVerifiedAt.toString()}', getSmallTextFontSIze(), colorConstants.black, FontWeight.bold)
                  )),
              Expanded(child: Container()),
              GestureDetector(
                onTap: (){
                  showConfirmationPopup(context,false);
                },
                child: addText('Deactivate Account', getNormalTextFontSIze(), colorConstants.black, FontWeight.bold),
              ),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: (){
                  showConfirmationPopup(context,true);
                },
                child: addText('Delete Account', getNormalTextFontSIze(), Colors.red, FontWeight.bold),
              ),
              SizedBox(height: 2.h,),


            ],
          )),
        ),
      ),
    );
  }

  Widget buildLoader(){
    return Shimmer.fromColors(
      baseColor: colorConstants.lightGrey,
      highlightColor: colorConstants.shimmerColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          SizedBox(height: 10.h,),
          Center(
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: [getDeepBoxShadow()],
                  color: colorConstants.white,
                  borderRadius: getBorderRadiusCircular()),
              child: ClipRRect(
                borderRadius: getBorderRadiusCircular(),
                child: Container(
                  width: 30.w,
                  height: 30.w,
                ),
              ),
            ),
          ),
          SizedBox(height: 20,),
          Container(
            decoration: BoxDecoration(
                boxShadow: [getDeepBoxShadow()],
                color: colorConstants.white,
                borderRadius: getCurvedBorderRadius()),
            child: ClipRRect(
              borderRadius: getBorderRadiusCircular(),
              child: Container(
                width: 90.w,
                height: 30.w,
              ),
            ),
          ),
          SizedBox(height: 20,),
          Container(
            decoration: BoxDecoration(
                boxShadow: [getDeepBoxShadow()],
                color: colorConstants.white,
                borderRadius: getCurvedBorderRadius()),
            child: ClipRRect(
              borderRadius: getBorderRadiusCircular(),
              child: Container(
                width: 90.w,
                height: 30.w,
              ),
            ),
          ),
          SizedBox(height: 20,),
          Container(
            decoration: BoxDecoration(
                boxShadow: [getDeepBoxShadow()],
                color: colorConstants.white,
                borderRadius: getCurvedBorderRadius()),
            child: ClipRRect(
              borderRadius: getBorderRadiusCircular(),
              child: Container(
                width: 90.w,
                height: 30.w,
              ),
            ),
          ),



        ],
      ),
    );
  }

  void showConfirmationPopup(BuildContext context,bool isDelete) {
    showDialog(
        context: context,
        builder: (ctxt) => new AlertDialog(
          title: Container(),
          content: Container(
              height: 20.h,
              width: 90.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  addAlignedText(
                      "Are you sure ?",
                      getHeadingTextFontSIze(),
                      colorConstants.black,
                      FontWeight.bold),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: getSolidButton(30.w, "Cancel"),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          if(isDelete) controller.deletAccount(context);
                          else controller.deactivateAccount(context);
                        },
                        child: addText("Confirm", getNormalTextFontSIze(),
                            Colors.red, FontWeight.bold),
                      )
                    ],
                  )
                ],
              )),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30)),
        ));
  }

}