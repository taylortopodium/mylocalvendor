import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_local_vendor/app/controller/auth_controller.dart';
import 'package:my_local_vendor/app/routes/app_routes.dart';
import 'package:my_local_vendor/common/color_constants.dart';
import 'package:my_local_vendor/common/utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginView extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: colorConstants.white,
        statusBarIconBrightness: Brightness.dark));

    return Scaffold(
      backgroundColor: colorConstants.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/app_logo.png',
                  height: 12.h,
                  width: 100.w,
                ),
                SizedBox(
                  height: 4.h,
                ),
                addText("Login", getLargeTextFontSIze(), colorConstants.black,
                    FontWeight.w600),
                SizedBox(
                  height: 2.h,
                ),
                addText(
                    "Please enter the details below to continue.",
                    getNormalTextFontSIze() - 2,
                    colorConstants.greyTextColor,
                    FontWeight.w600),
                SizedBox(
                  height: 4.h,
                ),
                addEditText(controller.emailController, 'Email'),
                SizedBox(
                  height: 1.5.h,
                ),
                Container(
                  width: 90.w,
                  decoration: BoxDecoration(
                      color: colorConstants.white,
                      // boxShadow: [getDeepBoxShadow()],
                      border: Border.all(color: colorConstants.lightGrey),
                      borderRadius: getBorderRadiusCircular()),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: 70.w,
                          child: Obx(() => TextFormField(
                                // inputFormatters: [CapitalCaseTextFormatter()],
                                keyboardType: TextInputType.text,
                                controller: controller.passwordController,
                                textInputAction: TextInputAction.next,
                                obscureText: controller.hideLoginPassword.value,
                                style: TextStyle(
                                    fontSize: getNormalTextFontSIze()),
                                decoration: InputDecoration(
                                    hintText: 'Password'.tr,
                                    hintStyle: TextStyle(
                                        fontSize: getNormalTextFontSIze(),
                                        color: colorConstants.greyTextColor),
                                    contentPadding:
                                        EdgeInsets.fromLTRB(20, 15, 10, 15),
                                    border: InputBorder.none),
                              ))),
                      Container(
                        margin: EdgeInsets.only(right: 20),
                        child: GestureDetector(
                            onTap: () {
                              controller.hideLoginPassword.value =
                                  !controller.hideLoginPassword.value;
                            },
                            child: Obx(() => controller.hideLoginPassword.value
                                ? Image.asset(
                                    'assets/images/hide.png',
                                    height: 30,
                                    color: colorConstants.lightGrey,
                                  )
                                : Image.asset('assets/images/show.png',
                                    height: 30,
                                    color: colorConstants.lightGrey))),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Obx(() => controller.isLoading.value
                    ? getLoader()
                    : InkWell(
                        onTap: () {
                          if (!controller.emailController.text
                              .trim()
                              .isValidEmail())
                            showSnackbar(context, 'Please enter valid email');
                          else if (controller.passwordController.text
                                  .trim()
                                  .length ==
                              0)
                            showSnackbar(context, 'Please enter password');
                          else
                            controller.loginUser(
                                context,
                                controller.emailController.text.trim(),
                                controller.passwordController.text.trim(),
                                '201',
                                '',
                                '');
                        },
                        child: getSolidButton(90.w, 'Log In'),
                      )),
                SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(Routes.Signup);
                  },
                  child: Center(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: "Don't have an account? ".tr,
                              style: TextStyle(
                                  color: colorConstants.black,
                                  fontSize: getSmallTextFontSIze(),
                                  fontWeight: FontWeight.normal)),
                          TextSpan(
                              text: "Sign up".tr,
                              style: TextStyle(
                                  color: colorConstants.buttonColor,
                                  fontSize: getSmallTextFontSIze() + 2,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.ResetPassword),
                  child: addText('Forgot Password?', getNormalTextFontSIze(),
                      colorConstants.black, FontWeight.bold),
                ),
                SizedBox(
                  height: 3.h,
                ),
                addText('Or login with', getSmallTextFontSIze(),
                    colorConstants.greyTextColor, FontWeight.normal),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.handleGoogleSignIn(context);
                      },
                      child: socialIcons('google.svg'),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.fbLogin(context);
                      },
                      child: socialIcons('facebook.svg'),
                    ),
                    if (GetPlatform.isIOS)
                      GestureDetector(
                          onTap: () {
                            controller.appleSignIn(context);
                          },
                          child: socialIcons('apple.svg')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget socialIcons(String image) {
    return Container(
      width: 25.w,
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          border: Border.all(color: colorConstants.lightGrey),
          borderRadius: getBorderRadiusCircular()),
      child: SvgPicture.asset('assets/images/$image'),
    );
  }
}
