import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_local_vendor/app/controller/wishlist_controller.dart';
import 'package:my_local_vendor/common/color_constants.dart';
import 'package:my_local_vendor/common/utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../common/bottom_navigation.dart';
import '../../../common/header.dart';
import '../../routes/app_routes.dart';

class WishlistView extends GetView<WishlistController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorConstants.white,
      bottomNavigationBar: AppBottomNavigation(),
      body: RefreshIndicator(
        onRefresh: ()async{
          controller.getWishList();
        },
        child: SafeArea(
          child: Container(

            child: Column(
              children: [
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: AppHeader(title: 'Wishlist'),
                ),
                SizedBox(height: 4.h,),
                Expanded(child: buildGrids())
              ],
            ),
          ),
        ),
      ),
    );
  }



  Widget buildGrids(){
    return Obx(() => controller.isLoading.value ? buildProductLoader() :  controller.wishList.length == 0 ?
    Center(child: addText('No item found', getNormalTextFontSIze(), colorConstants.black, FontWeight.bold),): GridView.builder(
      shrinkWrap: true,
      physics: AlwaysScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          // crossAxisSpacing: 20,
          // mainAxisSpacing: 20,
          mainAxisExtent: 27.h
      ),
      itemBuilder: (context, index) => GestureDetector(
        onTap: (){
          Get.toNamed(Routes.ProductDetail, arguments: {
            'title': controller.wishList[index].product!.name,
            'productId': controller.wishList[index].product!.id.toString()
          });
        },
        child: buildItem(index),
      ),
      itemCount:controller.wishList.length,
    ));
  }


  Widget buildItem(int index){
    return Stack(
      children: [
        Container(
          margin: index.isOdd ? EdgeInsets.only(right: 20,left: 10,bottom: 20) : EdgeInsets.only(left: 20,right: 10,bottom: 20),
          decoration: BoxDecoration(
              boxShadow: [getDeepBoxShadow()],
              color: colorConstants.white,
              borderRadius: getCurvedBorderRadius()
          ),child: ClipRRect(
          borderRadius: getCurvedBorderRadius(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.network(
                    controller.wishList[index].product!.productImages[0].name,
                    fit: BoxFit.cover,
                    height: 16.h,
                    width: double.infinity,
                  ),
                  // if(index%3 ==0)
                  //   Align(
                  //     heightFactor:5 ,
                  //     alignment: Alignment.bottomCenter,
                  //     child: buildSoldOutIcon(),)
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: addSingleLineText(controller.wishList[index].product!.name, getSmallTextFontSIze(), colorConstants.black, FontWeight.normal),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    addText('\$'+controller.wishList[index].product!.price.toString(), getSmallTextFontSIze()-1, colorConstants.black, FontWeight.w800),
                    verticalDivider(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(Icons.star,color: colorConstants.buttonColor,size: getHeadingTextFontSIze(),),
                        addText(controller.wishList[index].product!.rating.toString(), getSmallTextFontSIze(), colorConstants.black, FontWeight.w800),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        ),
       Positioned(
         top: 10,
           right: index.isOdd ? 30:20,
           child:  SvgPicture.asset('assets/images/favourite.svg',width: getLargeTextFontSIze(),))
      ],
    );
  }

  Widget buildSoldOutIcon() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: colorConstants.black.withOpacity(0.4),
          borderRadius: getBorderRadiusCircular()),
      child: addAlignedText('SOLD OUT', 10, colorConstants.white, FontWeight.bold),
    );
  }

}