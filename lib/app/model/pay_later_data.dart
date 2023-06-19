// To parse this JSON data, do
//
//     final payLaterData = payLaterDataFromJson(jsonString);

import 'dart:convert';

PayLaterData payLaterDataFromJson(String str) => PayLaterData.fromJson(json.decode(str));

String payLaterDataToJson(PayLaterData data) => json.encode(data.toJson());

class PayLaterData {
  PayLaterData({
    required this.status,
    required this.msg,
    required this.data,
  });

  bool status;
  String msg;
  Data data;

  factory PayLaterData.fromJson(Map<String, dynamic> json) => PayLaterData(
    status: json["status"],
    msg: json["msg"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.amount,
    // required this.firstPayment,
    required this.emiDetails,
  });

  dynamic amount;
  // String firstPayment;
  List<EmiDetail> emiDetails;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    amount: json["amount"],
    // firstPayment: json["first_payment"],
    emiDetails: List<EmiDetail>.from(json["emi_details"].map((x) => EmiDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    // "first_payment": firstPayment,
    "emi_details": List<dynamic>.from(emiDetails.map((x) => x.toJson())),
  };
}

class EmiDetail {
  EmiDetail({
    required this.emiOption,
    required this.amount,
    required this.emiData,
  });

  int emiOption;
  dynamic amount;
  List<EmiDatum> emiData;

  factory EmiDetail.fromJson(Map<String, dynamic> json) => EmiDetail(
    emiOption: json["emi_option"],
    amount: json["amount"],
    emiData: List<EmiDatum>.from(json["emi_data"].map((x) => EmiDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "emi_option": emiOption,
    "amount": amount,
    "emi_data": List<dynamic>.from(emiData.map((x) => x.toJson())),
  };
}

class EmiDatum {
  EmiDatum({
    required this.key,
    required this.date,
    required this.amount,
  });

  String key;
  dynamic date;
  dynamic amount;

  factory EmiDatum.fromJson(Map<String, dynamic> json) => EmiDatum(
    key: json["key"],
    date: json["date"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "date": date,
    "amount": amount,
  };
}
