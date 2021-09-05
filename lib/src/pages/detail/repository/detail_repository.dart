import 'package:bitcoin_app/src/core/api_source/bitcoin_api/bitcoin_api.dart';
import 'package:bitcoin_app/src/core/api_source/models/last_prices_model.dart';

class DetailRepository{
  final BitcoinApi _api = BitcoinApi();

  Future<List<LastPricesModel>> getLastWeeksPrices(String start, String end, String money)async{
    return await _api.getLastWeeksPrices(start, end, money);
  }
}