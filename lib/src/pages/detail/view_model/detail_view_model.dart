import 'package:bitcoin_app/src/core/api_source/app_exception.dart';
import 'package:bitcoin_app/src/core/api_source/enums/notifier_state.dart';
import 'package:bitcoin_app/src/pages/detail/repository/detail_repository.dart';
import 'package:stacked/stacked.dart';

class DetailViewModel extends BaseViewModel {
  final _repository = DetailRepository();

  //Api call status
  NotifierState _getInfoState = NotifierState.initial;

  NotifierState get state => _getInfoState;

  //Price in dollars
  String? _priceUsd;

  String? get priceUsd => _priceUsd;

  //Price in euros
  String? _priceEur;

  String? get priceEur => _priceEur;

  //Class for exceptions
  AppException? _failure;

  AppException? get failure => _failure;

  //Get the price of bitcoin in dollars and euros for a date.
  getInfo(String date) async {
    _setStateInfo(NotifierState.loading);
    try {
      DateTime dateTime = DateTime.parse(date);
      var dateFormat = dateTime.toUtc().toIso8601String();
      final priceUsd =
          await _repository.getLastWeeksPrices(dateFormat, dateFormat, "USD");
      _priceUsd = priceUsd.first.prices.first.toString();
      final priceEur =
          await _repository.getLastWeeksPrices(dateFormat, dateFormat, "EUR");
      _priceEur = priceEur.first.prices.first.toString();
    } on AppException catch (f) {
      _setFailure(f);
    }
    _setStateInfo(NotifierState.loaded);
  }

  //Set state of get initial info
  void _setStateInfo(NotifierState state) {
    _getInfoState = state;
    notifyListeners();
  }

  //Set error when the api call fail
  void _setFailure(AppException failure) {
    _failure = failure;
    notifyListeners();
  }
}
