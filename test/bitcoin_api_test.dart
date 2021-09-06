import 'package:bitcoin_app/src/core/api_source/bitcoin_api/bitcoin_api.dart';
import 'package:bitcoin_app/src/core/api_source/models/bitcoin_model.dart';
import 'package:bitcoin_app/src/core/api_source/models/last_prices_model.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  final BitcoinApi api = BitcoinApi();

  test('Bitcoin information GET request test', () async {
    var response = await api.getTodayInfo();
    expect(response.length, 1);
    expect(response, isInstanceOf<List<BitcoinModel>>());
    expect(response.first.id, 'BTC');
  });

  test('Price list GET request test', () async {
    var response = await api.getLastWeeksPrices(
        '2021-07-23T01:44:53.031608Z', '2021-08-23T01:44:53.031608Z', 'USD');
    expect(response.length, 1);
    expect(response, isInstanceOf<List<LastPricesModel>>());
    expect(response.first.currency, 'BTC');
  });
}
