// To parse this JSON data, do
//
//     final bitcoinModel = bitcoinModelFromJson(jsonString);

import 'dart:convert';

List<BitcoinModel> bitcoinModelFromJson(String str) => List<BitcoinModel>.from(
    json.decode(str).map((x) => BitcoinModel.fromJson(x)));

String bitcoinModelToJson(List<BitcoinModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BitcoinModel {
  BitcoinModel({
    required this.id,
    required this.currency,
    required this.symbol,
    required this.name,
    required this.logoUrl,
    required this.status,
    required this.price,
    required this.rank,
    required this.priceDate,
    required this.priceTimestamp,
  });

  String id;
  String currency;
  String symbol;
  String name;
  String logoUrl;
  String status;
  String price;
  String rank;
  DateTime priceDate;
  DateTime priceTimestamp;

  factory BitcoinModel.fromJson(Map<String, dynamic> json) => BitcoinModel(
        id: json["id"],
        currency: json["currency"],
        symbol: json["symbol"],
        name: json["name"],
        logoUrl: json["logo_url"],
        status: json["status"],
        price: json["price"],
        rank: json["rank"],
        priceDate: DateTime.parse(json["price_date"]),
        priceTimestamp: DateTime.parse(json["price_timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "currency": currency,
        "symbol": symbol,
        "name": name,
        "logo_url": logoUrl,
        "status": status,
        "price": price,
        "rank": rank,
        "price_date": priceDate.toIso8601String(),
        "price_timestamp": priceTimestamp.toIso8601String(),
      };
}
