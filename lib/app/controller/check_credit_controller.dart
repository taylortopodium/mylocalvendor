import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_local_vendor/common/color_constants.dart';
import 'package:my_local_vendor/common/utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../model/CheckCreditData.dart';
import '../repository/payment_repository.dart';
import '../routes/app_routes.dart';

class CheckCreditController extends GetxController {
  late TextEditingController referenceIdController;
  late TextEditingController fNameController;
  late TextEditingController mNameController;
  late TextEditingController lNameController;
  late TextEditingController emailController;
  late TextEditingController mobileController;
  late TextEditingController homePhoneController;
  late TextEditingController securityController;
  late TextEditingController curAddressController;
  late TextEditingController prevAddressController;
  final dob = 'Date Of Birth*'.obs;
  final isLoading = false.obs;

  List<String> typeValues = [
    'Us Person',
  ];

  String? selectedType;
  late PaymentRepository paymentRepository;

  CheckCreditController() {
    paymentRepository = PaymentRepository();
    referenceIdController = TextEditingController();
    fNameController = TextEditingController();
    mNameController = TextEditingController();
    lNameController = TextEditingController();
    emailController = TextEditingController();
    mobileController = TextEditingController();
    homePhoneController = TextEditingController();
    securityController = TextEditingController();
    curAddressController = TextEditingController();
    prevAddressController = TextEditingController();
  }

  updateDate(String date) {
    print("Date " + date);
    this.dob.value = date;
  }

  void checkCreditScore(BuildContext context) async {
    try {
      isLoading.value = true;
      CheckCreditData checkCreditData =
          await paymentRepository.checkCreditScore(
              referenceIdController.text.trim(),
              selectedType!,
              fNameController.text.trim(),
              mNameController.text.trim(),
              lNameController.text.trim(),
              emailController.text.trim(),
              mobileController.text.trim(),
              homePhoneController.text.trim(),
              securityController.text.trim(),
              dob.value,
              curAddressController.text.trim(),
              prevAddressController.text.trim());
      isLoading.value = false;
      showCreditDialog(checkCreditData);
    } catch (e) {
      isLoading.value = false;
      if (e is DioError) {
        showSnackbar(context, e.response!.data['msg']);
        print(e.response!.data);
      }

      else{
        showSnackbar(context, e.toString());
        print(e.toString());
      }

    }
  }

  void showCreditDialog(CheckCreditData checkCreditData) {
    Get.dialog(Center(
      child: Container(
        width: 90.w,
        height: 40.h,
        decoration: BoxDecoration(
            borderRadius: getCurvedBorderRadius(), color: colorConstants.white),
        child: ClipRRect(
            borderRadius: getCurvedBorderRadius(),
            child: Scaffold(
              backgroundColor: colorConstants.white,
              body: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: GestureDetector(
                          onTap: () => Get.back(),
                          child: Icon(
                            Icons.close,
                            color: colorConstants.black,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                    addText('Your CIBIL Score', getHeadingTextFontSIze(),
                        colorConstants.black, FontWeight.bold),
                    SizedBox(
                      height: 2.h,
                    ),
                    Stack(
                      children: [
                        Container(
                          width: 13.h,
                          height: 13.h,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colorConstants.black),
                          child: Center(
                            child: addText(
                                checkCreditData.data.toString(),
                                getLargeTextFontSIze() * 1.2,
                                checkCreditData.status
                                    ? Colors.green
                                    : Colors.red,
                                FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 13.h,
                          height: 13.h,
                          child: CircularProgressIndicator(
                            backgroundColor: colorConstants.lightGrey,
                            value: 0.75,
                            strokeWidth: 5,
                            color: checkCreditData.status
                                ? Colors.green
                                : Colors.red,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    addText(checkCreditData.msg, getHeadingTextFontSIze(),
                        colorConstants.black, FontWeight.bold),
                    SizedBox(
                      height: 2.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (checkCreditData.status) {
                          // Get.back();
                          // Get.back();
                          Get.toNamed(Routes.PayLaterView);
                        }
                      },
                      child: checkCreditData.status
                          ? getSolidButton(80.w, 'Request')
                          : getDisabledButton(80.w, 'Request'),
                    )
                  ],
                ),
              ),
            )),
      ),
    ));
  }
}
