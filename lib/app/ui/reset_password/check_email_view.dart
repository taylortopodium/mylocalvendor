import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_local_vendor/app/controller/reset_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:my_local_vendor/app/routes/app_routes.dart';
import 'package:my_local_vendor/common/color_constants.dart';
import 'package:my_local_vendor/common/utils.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CheckEmailView extends GetView<ResetPasswordController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorConstants.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 20,),
              Align(alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: ()=>Get.back(),
                  child: Icon(Icons.arrow_back_ios,color: colorConstants.black,),
                )),
              SizedBox(height: 10.h,),
              
              Container(
                height: 15.h,
                width: 15.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(getLargeTextFontSIze()),
                  color: Color(0xFFF1F2F2)
                ), child: Center(child: SvgPicture.asset('assets/images/email_reset.svg',height: 8.h,)),
              ),

              SizedBox(height: 2.h,),

              addText('Check your mail', getHeadingTextFontSIze(), colorConstants.black, FontWeight.bold),
              SizedBox(height: 2.h,),
              addAlignedText('We have sent a password recover instructions to your email.', getNormalTextFontSIze(), colorConstants.black, FontWeight.normal),
              SizedBox(height: 2.h,),
              GestureDetector(
                onTap: (){
                  checkMail(context);
                }, child: getSolidButton(90.w, 'OPEN EMAIL'),
              ),
              SizedBox(height: 2.h,),
              GestureDetector(
                onTap: ()=>Get.toNamed(Routes.CreatePassword),
                child: addAlignedText("Skip, I'll confirm later", getNormalTextFontSIze(), colorConstants.black, FontWeight.normal),
              ),
              Expanded(child: Container()),
              Center(
                child: GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(

                      children: [
                        TextSpan(text: 'Did not receive the email? Check your spam filter\nor ',),
                        TextSpan(
                          text: 'try another email address',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 2.h,),


            ],
          ),
        ),
      ),
    );
  }


  void checkMail(BuildContext context) async {
    var result = await OpenMailApp.openMailApp();

    if (!result.didOpen && !result.canOpen) {
      showNoMailAppsDialog(context);

      // iOS: if multiple mail apps found, show dialog to select.
      // There is no native intent/default app system in iOS so
      // you have to do it yourself.
    } else if (!result.didOpen && result.canOpen) {
      showDialog(
        context: context,
        builder: (_) {
          return MailAppPickerDialog(
            mailApps: result.options,
          );
        },
      );
    }
  }


  void showNoMailAppsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Open Mail App"),
          content: Text("No mail apps installed"),
          actions: <Widget>[
            GestureDetector(
              child: Text("OK"),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

}