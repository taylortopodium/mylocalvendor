import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_local_vendor/app/routes/app_routes.dart';
import 'package:my_local_vendor/common/color_constants.dart';
import 'package:my_local_vendor/common/utils.dart';

class FavouriteAppHeader extends StatefulWidget {

  String title;
  bool isFavourite = false;

   FavouriteAppHeader({Key? key,required this.title,required this.isFavourite}) : super(key: key);

  @override
  State<FavouriteAppHeader> createState() => _FavouriteAppHeaderState();
}

class _FavouriteAppHeaderState extends State<FavouriteAppHeader> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
       Row(
         children: [ GestureDetector(
           onTap: () {
             Get.back();
           },
           child: Icon(Icons.arrow_back_ios),
         ),
           GestureDetector(
             onTap: () {
               Get.back();
             },
             child: Icon(Icons.arrow_back_ios,color: colorConstants.white,),
           ),
         ],
       ),
        addText(widget.title, getHeadingTextFontSIze(),
            colorConstants.black, FontWeight.w600),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.WishlistView);
              },
              child: SvgPicture.asset('assets/images/non_favourite.svg'),
            ),
            SizedBox(width: 10,),
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
}
