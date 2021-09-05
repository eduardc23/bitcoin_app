import 'dart:io';

import 'package:bitcoin_app/src/core/api_source/models/bitcoin_model.dart';
import 'package:bitcoin_app/src/core/api_source/models/last_prices_model.dart';
import 'package:http/http.dart' as http;

import '../app_exception.dart';

class BitcoinApi {
  final String _apiKey = 'fcdf9c110cee9acfca862fd298a274ae538278ae';
  final String _baseurl = 'api.nomics.com';


  Future<List<BitcoinModel>> getTodayInfo() async {
    final String _todayInfo = '/v1/currencies/ticker';
    try {
      final _url = Uri.https(_baseurl, _todayInfo,
          {"key": _apiKey, "ids": "BTC", "convert": "USD"});
      final answer = await http.get(
        _url,
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (answer.statusCode == 200) {
        final bitcoinModel = bitcoinModelFromJson(answer.body);
        return bitcoinModel;
      } else {
        throw UnauthorisedException('Autenticación fallida');
      }
    } on SocketException {
      throw FetchDataException(
          'No se pudo establecer conexión con el servidor.');
    }
  }

  Future<List<LastPricesModel>> getLastWeeksPrices(String start, String end, String money) async {
    final String _todayInfo = '/v1/currencies/sparkline';

    try {
      final _url = Uri.https(_baseurl, _todayInfo, {
        "key": _apiKey,
        "ids": "BTC",
        "convert": money,
        "start": start,
        "end": end
      });

      final answer = await http.get(
        _url,
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (answer.statusCode == 200) {
        final lastPricesModel = lastPricesModelFromJson(answer.body);
        return lastPricesModel;
      } else {
        throw UnauthorisedException('Autenticación fallida');
      }
    } on SocketException {
      throw FetchDataException(
          'No se pudo establecer conexión con el servidor.');
    }
  }
}
