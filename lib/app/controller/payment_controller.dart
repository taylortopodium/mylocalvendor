import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_local_vendor/app/controller/home_controller.dart';
import 'package:my_local_vendor/app/controller/pay_later_controller.dart';
import 'package:my_local_vendor/app/controller/product_detail_controller.dart';
import 'package:my_local_vendor/app/model/card_list_data.dart';
import 'package:my_local_vendor/app/model/normal_response.dart';
import 'package:my_local_vendor/app/routes/app_routes.dart';
import 'package:my_local_vendor/common/utils.dart';

import '../repository/payment_repository.dart';
import 'check_credit_controller.dart';

class PaymentCOntroller extends GetxController {
  final cardListLength = 0.obs;
  late TextEditingController cardNameController;
  late TextEditingController cardNoController;
  late TextEditingController expiryController;
  late TextEditingController cvvController;
  late TextEditingController confirmationEmailController;

  // final isLoading = false.obs;
  late PaymentRepository paymentRepository;
  final isLoading = false.obs;
  final isPaymentLoading = false.obs;
  final cardList = <CardListDatum>[].obs;
  final isPayLater = false.obs;
  final isPayingEmi = false.obs;

  final cardId = ''.obs;
  final cardSelectedPos = 0.obs;


  final StripeSecret = 'sk_test_51LdTWyC2YEc8eoyMZCwqWItPFdbPnwPkBbItDOfG5RxdzbZpC7jv6enFAp2EfT9JwqgkSgKCqHVnpO5yZGQkpFED00GTYGn1I3';

   String paymentApiUrl = 'https://api.stripe.com/v1/payment_intents';
   Map<String, String> headers = {
    'Authorization': 'Bearer sk_test_51LdTWyC2YEc8eoyMZCwqWItPFdbPnwPkBbItDOfG5RxdzbZpC7jv6enFAp2EfT9JwqgkSgKCqHVnpO5yZGQkpFED00GTYGn1I3',
    'Content-Type': 'application/x-www-form-urlencoded'
  };

  PaymentCOntroller() {
    paymentRepository = PaymentRepository();
    cardNameController = TextEditingController();
    cardNoController = TextEditingController();
    expiryController = TextEditingController();
    cvvController = TextEditingController();
    confirmationEmailController = TextEditingController();
  }

  @override
  void onInit() {
    super.onInit();
    isPayLater.value = Get.arguments['payLater'] as bool;
    isPayingEmi.value = Get.arguments['isPayingEmi'] as bool;
    getCardList();
    // initPaymentSheet();
  }

  void addCard(BuildContext context) async {
    try {
      isLoading.value = true;
      CardListData cardListData = await paymentRepository.addCard(
          cardNoController.text.trim().replaceAll(" ", ""),
          cardNameController.text.trim(),
          expiryController.text.trim(),
          cvvController.text.trim());
      // showSnackbar(context, normalResponse.msg);
      cardList.assignAll(cardListData.data);
      if(cardList.length > 0){
        cardId.value = cardList[0].id.toString();
      }
      isLoading.value = false;
      cardNoController.clear();
      cardNameController.clear();
      expiryController.clear();
      cvvController.clear();
      Get.back();
    } catch (e) {
      isLoading.value = false;
      if (e is DioError) {
        showSnackbar(context, e.response!.data['msg']);
        print(e.response!.data);
      } else {
        showSnackbar(context, e.toString());
        print(e.toString());
      }
    }
  }

  void getCardList() async {
    try {
      isLoading.value = true;
      CardListData cardListData = await paymentRepository.getCardList();
      cardList.assignAll(cardListData.data);
      cardSelectedPos.value = 0;
      if(cardList.length > 0){
        cardId.value = cardList[0].id.toString();
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      if (e is DioError) {
        // showSnackbar(context, e.response!.data['msg']);
        print(e.response!.data);
      } else {
        // showSnackbar(context, e.toString());
        print(e.toString());
      }
    }
  }

  void editCard(BuildContext context, CardListDatum cardListDatum) async {
    try {
      isLoading.value = true;
      CardListData cardListData = await paymentRepository.editCard(
          cardNoController.text.trim(),
          cardNameController.text.trim(),
          expiryController.text.trim(),
          cvvController.text.trim(),
          cardListDatum.id.toString());
      cardList.assignAll(cardListData.data);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      if (e is DioError) {
        showSnackbar(context, e.response!.data['msg']);
        print(e.response!.data);
      } else {
        showSnackbar(context, e.toString());
        print(e.toString());
      }
    }
  }

  void removeCard(BuildContext context, String cardId) async {
    try {
      isLoading.value = true;
      CardListData cardListData = await paymentRepository.deleteCard(cardId);
      cardList.assignAll(cardListData.data);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      if (e is DioError) {
        showSnackbar(context, e.response!.data['msg']);
        print(e.response!.data);
      } else {
        showSnackbar(context, e.toString());
        print(e.toString());
      }
    }
  }

  void proceedPaymentAPI(BuildContext context) async {
    try {
      isPaymentLoading.value = true;
      print('Card Id : ${cardId.value}');
      NormalResponse? normalResponse;

      if (isPayLater.value) {
        normalResponse = await paymentRepository.proceedPayment(
            Get.find<ProductDetailController>().productId,
            Get.find<ProductDetailController>().productDetailData.data.price.toString(),
            Get.find<PayLaterController>().emiList[0].amount,
            'partial',
            Get.find<PayLaterController>().payLaterInnerData.emiDetails[Get.find<PayLaterController>().installmentSelectedPos.value].emiOption.toString(),
            cardId.value
        );
      } else {
        normalResponse = await paymentRepository.proceedPayment(
            Get.find<ProductDetailController>().productId,
            Get.find<ProductDetailController>().productDetailData.data.price.toString(),
            Get.find<ProductDetailController>().productDetailData.data.price.toString(), 'full',
            '0',
            cardId.value
        );
      }

      showSnackbar(context, normalResponse.msg);
      Get.offAllNamed(Routes.Home);
      Get.put(HomeController());
      Get.toNamed(Routes.MyOrderView);

      isPaymentLoading.value = false;
    } catch (e) {
      isPaymentLoading.value = false;
      if (e is DioError) {
        print('============================> '+e.response!.data.toString());
        showSnackbar(context, e.response!.data['msg']);
      } else {
        showSnackbar(context, e.toString());
        print(e.toString());
      }
    }
  }



  bool validateCardNumWithLuhnAlgorithm(String input, BuildContext context) {
    if (input.isEmpty) {
      showSnackbar(context, 'Please enter card number');
      return false;
    }
    input = input.replaceAll(' ', '');

    // if(input.length<8) return false;

    if (input.length < 8) {
      showSnackbar(context, 'Please enter valid card number');
      return false;
    }

    int sum = 0;
    int length = input.length;
    for (var i = 0; i < length; i++) {
      // get digits in reverse order
      int digit = int.parse(input[length - i - 1]);

      // every 2nd number multiply with 2
      if (i % 2 == 1) {
        digit *= 2;
      }
      sum += digit > 9 ? (digit - 9) : digit;
    }

    if (sum % 10 == 0) {
      return true;
    } else {
      showSnackbar(context, 'Card is not valid');
      return false;
    }
  }

  CardType getCardTypeFrmNumber(String input) {
    CardType cardType;
    if (input.startsWith(RegExp(r'((5[1-5])|(222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720))'))) {
      cardType = CardType.MasterCard;
    } else if (input.startsWith(RegExp(r'[4]'))) {
      cardType = CardType.Visa;
    } else if (input
        .startsWith(RegExp(r'((506(0|1))|(507(8|9))|(6500))'))) {
      cardType = CardType.Verve;
    } else if (input.length <= 8) {
      cardType = CardType.Others;
    } else {
      cardType = CardType.Invalid;
    }
    return cardType;
  }


  String getTodaysDate(){
    // DateTime dateTime = DateTime.parse(DateTime.now());
    // return '${dateTime.hour}:${dateTime.minute}';
    return DateFormat('dd-MM-yyyy').format(DateTime.now());
  }












}

enum CardType {
  MasterCard,
  Visa,
  Verve,
  Others, // Any other card issuer
  Invalid // We'll use this when the card is invalid
}
