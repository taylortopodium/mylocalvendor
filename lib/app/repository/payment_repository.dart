import 'package:my_local_vendor/app/provider/api_provider.dart';

import '../model/CheckCreditData.dart';
import '../model/card_list_data.dart';
import '../model/normal_response.dart';
import '../model/pay_later_data.dart';

class PaymentRepository {
  late APIProvider _apiProvider;

  PaymentRepository() {
    this._apiProvider = APIProvider();
  }

  Future<CheckCreditData> checkCreditScore(
      String referenceID,
      String type,
      String fName,
      String mName,
      String lName,
      String email,
      String mobile,
      String phoneNo,
      String socialNo,
      String dob,
      String currAddress,
      String prevAddress) async {
    return _apiProvider.checkCreditScore(referenceID, type, fName, mName, lName,
        email, mobile, phoneNo, socialNo, dob, currAddress, prevAddress);
  }

  Future<CardListData> addCard(String card_number, String name,
      String expiry_date, String security_code) async {
    return _apiProvider.addCard(card_number, name, expiry_date, security_code);
  }

  Future<CardListData> getCardList() async {
    return _apiProvider.getCardList();
  }

  Future<CardListData> editCard(String card_number, String name,
      String expiry_date, String security_code, String cardId) async {
    return _apiProvider.editCard(
        card_number, name, expiry_date, security_code, cardId);
  }

  Future<CardListData> deleteCard(String cardId) async {
    return _apiProvider.deleteCard(cardId);
  }

  Future<PayLaterData> getPayLaterData(String productId) async {
    return _apiProvider.getPayLaterData(productId);
  }

  Future<NormalResponse> proceedPayment(String productID, String total,
      String amountReceieved, String type, String emiOption,String cardId) async {
    return _apiProvider.proceedPayment(
        productID, total, amountReceieved, type, emiOption,cardId);
  }
}
