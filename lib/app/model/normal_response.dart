// To parse this JSON data, do
//
//     final normalResponse = normalResponseFromJson(jsonString);

import 'dart:convert';

NormalResponse normalResponseFromJson(String str) => NormalResponse.fromJson(json.decode(str));

String normalResponseToJson(NormalResponse data) => json.encode(data.toJson());

class NormalResponse {
  NormalResponse({
    required this.status,
    required this.msg,
  });

  bool status;
  String msg;

  factory NormalResponse.fromJson(Map<String, dynamic> json) => NormalResponse(
    status: json["status"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
  };
}
