// To parse this JSON data, do
//
//     final lastPricesModel = lastPricesModelFromJson(jsonString);

import 'dart:convert';

List<LastPricesModel> lastPricesModelFromJson(String str) => List<LastPricesModel>.from(json.decode(str).map((x) => LastPricesModel.fromJson(x)));

String lastPricesModelToJson(List<LastPricesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LastPricesModel {
  LastPricesModel({
    required this.currency,
    required this.timestamps,
    required this.prices,
  });

  String currency;
  List<DateTime> timestamps;
  List<String> prices;

  factory LastPricesModel.fromJson(Map<String, dynamic> json) => LastPricesModel(
    currency: json["currency"],
    timestamps: List<DateTime>.from(json["timestamps"].map((x) => DateTime.parse(x))),
    prices: List<String>.from(json["prices"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "currency": currency,
    "timestamps": List<dynamic>.from(timestamps.map((x) => x.toIso8601String())),
    "prices": List<dynamic>.from(prices.map((x) => x)),
  };
}
