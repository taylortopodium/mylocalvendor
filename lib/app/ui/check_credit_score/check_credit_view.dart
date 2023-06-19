import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_local_vendor/app/controller/check_credit_controller.dart';
import 'package:my_local_vendor/app/routes/app_routes.dart';
import 'package:my_local_vendor/common/color_constants.dart';
import 'package:my_local_vendor/common/header.dart';
import 'package:my_local_vendor/common/utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CheckCreditView extends StatefulWidget {
  const CheckCreditView({Key? key}) : super(key: key);

  @override
  State<CheckCreditView> createState() => _CheckCreditViewState();
}

class _CheckCreditViewState extends State<CheckCreditView> {
  var controller = Get.put(CheckCreditController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorConstants.white,
      // bottomNavigationBar: ,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              AppHeader(title: 'Check CIBIL Score'),
              SizedBox(
                height: 4.h,
              ),
              Expanded(
                  child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  addEditText(controller.referenceIdController, 'Reference ID'),
                  SizedBox(
                    height: 2.h,
                  ),
                  buildType(),
                  SizedBox(
                    height: 2.h,
                  ),
                  addEditText(controller.fNameController, 'First Name*'),
                  SizedBox(
                    height: 2.h,
                  ),
                  addEditText(controller.mNameController, 'Middle Name'),
                  SizedBox(
                    height: 2.h,
                  ),
                  addEditText(controller.lNameController, 'Last Name'),
                  SizedBox(
                    height: 2.h,
                  ),
                  addEditText(controller.emailController, 'Email*'),
                  SizedBox(
                    height: 2.h,
                  ),
                  addNumberEditText(
                      controller.mobileController, 'Mobile Number*'),
                  SizedBox(
                    height: 2.h,
                  ),
                  addNumberEditText(
                      controller.homePhoneController, 'Home Phone'),
                  SizedBox(
                    height: 2.h,
                  ),
                  addEditText(
                      controller.securityController, 'Social Security Number*'),
                  SizedBox(
                    height: 2.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      selectDate(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      decoration: BoxDecoration(
                          border: Border.all(color: colorConstants.lightGrey),
                          borderRadius: getBorderRadiusCircular()),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() => addText(
                              controller.dob.value,
                              getNormalTextFontSIze(),
                              colorConstants.greyTextColor,
                              FontWeight.normal)),
                          SvgPicture.asset(
                            'assets/images/calendar.svg',
                            height: getHeadingTextFontSIze() + 1,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  addEditText(
                      controller.curAddressController, 'Current Address*'),
                  SizedBox(
                    height: 2.h,
                  ),
                  addEditText(
                      controller.prevAddressController, 'Previous Address'),
                  SizedBox(
                    height: 2.h,
                  ),
                  Obx(() => controller.isLoading.value
                      ? Align(
                          alignment: Alignment.center,
                          child: getLoader(),
                        )
                      : GestureDetector(
                          onTap: () {
                            if (controller.selectedType == null) {
                              showSnackbar(context, 'Please select Type');
                            } else if (controller.fNameController.text
                                    .trim()
                                    .length ==
                                0) {
                              showSnackbar(context, 'Please enter First Name');
                            } else if (controller.emailController.text
                                    .trim()
                                    .length ==
                                0) {
                              showSnackbar(context, 'Please enter Email');
                            } else if (!controller.emailController.text
                                .trim()
                                .isValidEmail()) {
                              showSnackbar(context, 'Please enter valid Email');
                            } else if (controller.mobileController.text
                                    .trim()
                                    .length ==
                                0) {
                              showSnackbar(
                                  context, 'Please enter Mobile Number');
                            } else if (controller.securityController.text
                                    .trim()
                                    .length ==
                                0) {
                              showSnackbar(context,
                                  'Please enter Social Security Number');
                            } else if (controller.dob.value ==
                                'Date Of Birth') {
                              showSnackbar(
                                  context, 'Please select Date of Birth');
                            } else if (controller.curAddressController.text
                                    .trim()
                                    .length ==
                                0) {
                              showSnackbar(
                                  context, 'Please enter Current Address');
                            } else {
                              controller.checkCreditScore(context);
                            }
                          },
                          child: getSolidButton(90.w, 'Submit'),
                        )),
                  SizedBox(
                    height: 2.h,
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now().subtract(const Duration(days: 6575)),
        firstDate: DateTime(1900, 1),
        lastDate: DateTime.now().subtract(const Duration(days: 6575)));

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      controller.updateDate(
          '${selectedDate.day}-${selectedDate.month}-${selectedDate.year}');
    }
    // else return selectedDate.toString();
  }

  Widget buildType() {
    return DropdownButtonHideUnderline(
        child: DropdownButton2(
      buttonPadding: const EdgeInsets.symmetric(horizontal: 20),
      hint: Text(
        'Type*',
        style: TextStyle(
          fontSize: getNormalTextFontSIze(),
          // color: colorConstants.black,
        ),
      ),
      items: controller.typeValues
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: TextStyle(
                    fontSize: getNormalTextFontSIze(),
                  ),
                ),
              ))
          .toList(),
      value: controller.selectedType,
      onChanged: (value) {
        setState(() {
          controller.selectedType = value as String;
        });
      },
      buttonDecoration: BoxDecoration(
          border: Border.all(color: colorConstants.lightGrey),
          borderRadius: getBorderRadiusCircular()),
      iconSize: 10,
      icon: SvgPicture.asset('assets/images/down_arrow.svg'),
      buttonWidth: 100.w,
      dropdownElevation: 1,
      dropdownDecoration: BoxDecoration(
        color: colorConstants.white,
        boxShadow: [getDeepBoxShadow()],
      ),
    ));
  }
}
