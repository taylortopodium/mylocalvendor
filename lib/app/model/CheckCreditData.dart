// To parse this JSON data, do
//
//     final checkCibilData = checkCibilDataFromJson(jsonString);

import 'dart:convert';

CheckCreditData checkCibilDataFromJson(String str) => CheckCreditData.fromJson(json.decode(str));

String checkCibilDataToJson(CheckCreditData data) => json.encode(data.toJson());

class CheckCreditData {
  CheckCreditData({
    required this.status,
    required this.msg,
    required this.data,
  });

  bool status;
  String msg;
  int data;

  factory CheckCreditData.fromJson(Map<String, dynamic> json) => CheckCreditData(
    status: json["status"],
    msg: json["msg"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": data,
  };
}
