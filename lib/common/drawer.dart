import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_local_vendor/app/controller/home_controller.dart';
import 'package:my_local_vendor/app/routes/app_routes.dart';
import 'package:my_local_vendor/common/color_constants.dart';
import 'package:my_local_vendor/common/utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppDrawer extends GetView<HomeController>{
  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorConstants.white,
      width: 60.w,
      height: 100.h,
      child: SafeArea(
        child: Stack(
          children: [
            ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.h,),
                Align(alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Image.asset('assets/images/app_logo.png',height: 10.h,),
                  ),),
                Divider(
                  height: 6.h,
                ),


                GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: buildItems('menu_home.svg', 'Home'),
                ),

                GestureDetector(
                  onTap: (){
                    Get.back();
                    Get.toNamed(Routes.Category);
                  },
                  child: buildItems('menu_category.svg', 'Category'),
                ),


                GestureDetector(
                  onTap: (){
                    Get.back();
                    Get.toNamed(Routes.ProductView, arguments: {
                      'title': 'Latest Items',
                      'categoryId': '10000',
                      'itemType' : 'latest'
                    });
                  },
                  child: buildItems('menu_latest.svg', 'Latest Items'),
                ),


                GestureDetector(
                  onTap: (){
                    Get.back();
                    Get.toNamed(Routes.ProductView, arguments: {
                      'title': 'Popular Items',
                      'categoryId': '10000',
                      'itemType' : 'popularity'
                    });
                  },
                  child: buildItems('menu_popular.svg', 'Popular Items'),
                ),


                GestureDetector(
                  onTap: (){
                    Get.back();
                    Get.toNamed(Routes.ProductView, arguments: {
                      'title': 'Featured Items',
                      'categoryId': '10000',
                      'itemType' : 'featured'
                    });
                  },
                  child: buildItems('menu_featured.svg', 'Featured Items'),
                ),



                GestureDetector(
                  onTap: (){
                    Get.back();
                    Get.toNamed(Routes.MyReviewView);
                  },
                  child: buildItems('review.svg', 'Reviews'),
                ),


                Divider(
                  height: 3.h,
                ),


                Padding(
                  padding: const EdgeInsets.only(left: 20,top: 10),
                  child: addText('User Info', getSmallTextFontSIze(), colorConstants.black, FontWeight.bold),
                ),

                SizedBox(height: 20,),

                GestureDetector(
                  onTap: (){
                    Get.back();
                    Get.toNamed(Routes.ProfileView);
                  },
                  child: buildItems('menu_profile.svg', 'Profile'),
                ),

                GestureDetector(
                  onTap: (){
                    Get.back();
                    Get.toNamed(Routes.MyOrderView);
                  },
                  child: buildItems('ic_productorderInfo.svg', 'My Orders'),
                ),

                GestureDetector(
                  onTap: (){
                    Get.back();
                    Get.toNamed(Routes.WishlistView);
                  },
                  child: buildItems('non_favourite.svg', 'Wishlist'),
                ),


                GestureDetector(
                  onTap: (){
                    Get.back();
                    Get.toNamed(Routes.VendorChats);
                  },
                  child: buildItems('ic_chat.svg', 'Vendor Chats'),
                ),

                GestureDetector(
                  onTap: (){
                    Get.back();
                    Get.toNamed(Routes.VendorOrderView);
                  },
                  child: buildItems('ic_productorderInfo.svg', 'Vendor Orders'),
                ),

                Divider(
                  height: 3.h,
                ),


                Padding(
                  padding: const EdgeInsets.only(left: 20,top: 10),
                  child: addText('App', getSmallTextFontSIze(), colorConstants.black, FontWeight.bold),
                ),


                SizedBox(height: 20,),
                // GestureDetector(
                //   onTap: (){},
                //   child: buildItems('menu_language.svg', 'Language'),
                // ),




                GestureDetector(
                  onTap: (){
                    Get.back();
                    Get.toNamed(Routes.ContactView);
                  },
                  child: buildItems('menu_contact.svg', 'Contact us'),
                ),



                GestureDetector(
                  onTap: (){},
                  child: buildItems('menu_setting.svg', 'Setting'),
                ),

               GestureDetector(
                 onTap: (){
                   controller.logoutUser(context);
                 },
                 child:  Column(
                   children: [
                     Row(
                       children: [
                         SizedBox(width: 20,),
                         Icon(Icons.logout,color: colorConstants.black,size: 20,),
                         SizedBox(width: 20,),
                         addText('Log Out', getNormalTextFontSIze()-1, colorConstants.black, FontWeight.bold)
                       ],
                     ),
                     SizedBox(height: 2.5.h,)
                   ],
                 ),
               )

              ],
            ),
            Positioned(
              top: 10,
                right: 10,
                child: GestureDetector(
              onTap: ()=>Get.back(),
              child: Icon(Icons.close,color: colorConstants.lightGrey,size: getLargeTextFontSIze()*1.2,),
            ))
          ],
        ),
      ),
    );
  }

  Widget buildItems(String image,String title){
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 20,),
            SvgPicture.asset('assets/images/$image',width: 20,color: colorConstants.black,),
            SizedBox(width: 20,),
            addText(title, getNormalTextFontSIze()-1, colorConstants.black, FontWeight.bold)
          ],
        ),
        SizedBox(height: 2.5.h,)
      ],
    );
  }

}