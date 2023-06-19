import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_local_vendor/app/controller/splash_controller.dart';
import 'package:my_local_vendor/app/routes/app_routes.dart';
import 'package:my_local_vendor/common/color_constants.dart';
import 'package:my_local_vendor/common/utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:slider_button/slider_button.dart';

class SplashView extends GetView<SplashController>{
  @override
  Widget build(BuildContext context) {


    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: colorConstants.black,
        statusBarIconBrightness: Brightness.light));

    return Scaffold(
      backgroundColor: colorConstants.black,
      body: Container(
        width: 100.w,
        height: 100.h,
        child: Column(
          children: [

            SizedBox(height: 10.h,),

            Image.asset('assets/images/splash_bg.png',width: 100.w,),

            Expanded(child: Container()),

            addAlignedText('Ready to unlock\nunlimited possibilities', getLargeTextFontSIze(), colorConstants.white, FontWeight.normal),

            Expanded(child: Container()),

            Center(child: SliderButton(
              backgroundColor: colorConstants.white,
              width: 80.w,
              height: 60,
              alignLabel: Alignment.center,
              action: () {
                Get.offAllNamed(Routes.Login);
                // Get.offAllNamed(Routes.Root);
              },
              label: addAlignedText('Get Started', getHeadingTextFontSIze(), colorConstants.black, FontWeight.w700),
              icon: Container(
                margin: EdgeInsets.all(5),
                child: SvgPicture.asset('assets/images/ic_slider.svg',height: double.infinity,),
              ),


            )),

            Expanded(child: Container())



          ],
        ),
      ),
    );
  }

}