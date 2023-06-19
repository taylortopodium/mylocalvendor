import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_local_vendor/app/routes/app_routes.dart';
import 'package:my_local_vendor/common/color_constants.dart';
import 'package:my_local_vendor/common/utils.dart';

class AppHeader extends StatefulWidget {

  String title;

   AppHeader({Key? key,required this.title}) : super(key: key);

  @override
  State<AppHeader> createState() => _AppHeaderState();
}

class _AppHeaderState extends State<AppHeader> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios),
        ),
        addText(widget.title, getHeadingTextFontSIze(),
            colorConstants.black, FontWeight.w600),
        GestureDetector(
          onTap: () {
            Get.toNamed(Routes.NotificationView);
          },
          child: SvgPicture.asset('assets/images/notification.svg'),
        )
      ],
    );
  }
}
