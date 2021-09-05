import 'package:bitcoin_app/src/core/api_source/bitcoin_api/bitcoin_api.dart';
import 'package:bitcoin_app/src/core/api_source/models/bitcoin_model.dart';
import 'package:bitcoin_app/src/core/api_source/models/last_prices_model.dart';

class HomeRepository{
  final BitcoinApi _api = BitcoinApi();

  Future<List<BitcoinModel>> getTodayInfo()async{
    return await _api.getTodayInfo();
  }

  Future<List<LastPricesModel>> getLastWeeksPrices(String start, String end, String money)async{
    return await _api.getLastWeeksPrices(start, end, money);
  }
}


