import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_local_vendor/app/routes/app_routes.dart';
import 'package:my_local_vendor/common/color_constants.dart';
import 'package:my_local_vendor/common/utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../app/controller/product_detail_controller.dart';

class AppBottomNavigation extends StatefulWidget {
  const AppBottomNavigation({Key? key}) : super(key: key);

  @override
  State<AppBottomNavigation> createState() => _AppBottomNavigationState();
}

class _AppBottomNavigationState extends State<AppBottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      height: 8.h,
      decoration: BoxDecoration(
        borderRadius: getBorderRadiusCircular(),
        color: colorConstants.bottomNavigationColor
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: (){
              if(Get.currentRoute != Routes.Home){
                // Get.toNamed(Routes.Home);
                Get.offAllNamed(Routes.Home);
              }
            }, child: SvgPicture.asset('assets/images/ic_home.svg'),
          ),

          GestureDetector(
            onTap: (){
              if(Get.currentRoute != Routes.Category){
                Get.toNamed(Routes.Category);
              }
            }, child: SvgPicture.asset('assets/images/ic_category.svg'),
          ),

          GestureDetector(
            onTap: (){
              Get.toNamed(Routes.AddProductView);
            }, child: Container(
            height: 6.5.h,
            width: 6.5.h,
            padding: EdgeInsets.all(2.2.h),
            decoration: const BoxDecoration(
              color: colorConstants.white,
              shape: BoxShape.circle
            ), child: SvgPicture.asset('assets/images/ic_add.svg'),
          ),
          ),

          GestureDetector(
            onTap: (){
              if(Get.currentRoute == Routes.ProductDetail)
                Get.toNamed(Routes.ChatView, arguments: {
                  'id' : Get.find<ProductDetailController>().productDetailData.data.vendor.id.toString(),
                  'name' : Get.find<ProductDetailController>().productDetailData.data.vendor.name.toString(),
                  'image' : Get.find<ProductDetailController>().productDetailData.data.vendor.image.toString(),
                });
              else
                showSnackbar(context, 'Please go to product page to chat with seller/buyer.');
            }, child: SvgPicture.asset('assets/images/ic_chat.svg'),
          ),

          GestureDetector(
            onTap: (){
              Get.toNamed(Routes.ProfileView);
            }, child: SvgPicture.asset('assets/images/ic_profile.svg'),
          ),

        ],
      ),
    );
  }
}
