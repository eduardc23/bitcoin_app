import 'dart:async';

import 'package:bitcoin_app/src/core/api_source/app_exception.dart';
import 'package:bitcoin_app/src/core/api_source/enums/notifier_state.dart';
import 'package:bitcoin_app/src/core/api_source/models/bitcoin_model.dart';
import 'package:bitcoin_app/src/core/api_source/models/last_prices_model.dart';
import 'package:bitcoin_app/src/pages/home/repository/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  final _repository = HomeRepository();

  //Api call status, get initial info.
  NotifierState _getInfoState = NotifierState.initial;

  NotifierState get state => _getInfoState;

  //Api call status, refresh price every 60 seconds.
  NotifierState _refreshPriceState = NotifierState.initial;

  NotifierState get refreshPriceState => _refreshPriceState;

  //Timer to get price in real time every 60 seconds
  Timer? timer;

  //Class for exceptions
  AppException? _failure;

  AppException? get failure => _failure;

  //Data model, today information
  BitcoinModel? _bitcoinModel;

  BitcoinModel? get bitcoinModel => _bitcoinModel;

  //Price list, for the last two weeks.
  List<LastPricesModel>? _lastPrices;

  List<LastPricesModel>? get lastPrices => _lastPrices;

  //Get price today, and the last two weeks.
  void getInfo() async {
    _setStateInfo(NotifierState.loading);
    try {
      final todayInformation = await _repository.getTodayInfo();
      _bitcoinModel = todayInformation.first;
      final lastWeekPrices = await _repository.getLastWeeksPrices(
          _getDataTime(14), _getDataTime(1), "USD");
      _lastPrices = lastWeekPrices;
      _setTimer();
    } on AppException catch (f) {
      _setFailure(f);
    }
    _setStateInfo(NotifierState.loaded);
  }

  //Method called every 60 seconds, to refresh the price
  void _refreshPrice() async {
    _setStateRefreshPrice(NotifierState.loading);
    try {
      final answer = await _repository.getTodayInfo();
      _bitcoinModel = answer.first;
    } on AppException catch (f) {
      _setFailure(f);
    }
    _setStateRefreshPrice(NotifierState.loaded);
  }

  //Activate a timer to refresh price every 60 seconds.
  void _setTimer() {
    timer = Timer.periodic(Duration(seconds: 60), (Timer t) => _refreshPrice());
  }

  //Set state of get initial info
  void _setStateInfo(NotifierState state) {
    _getInfoState = state;
    notifyListeners();
  }

  //Set state of refresh price
  void _setStateRefreshPrice(NotifierState state) {
    _refreshPriceState = state;
    notifyListeners();
  }

  //Set error when the api call fail
  void _setFailure(AppException failure) {
    _failure = failure;
    notifyListeners();
  }

  //Returns a date. The value per parameter is subtracted from the current day
  String _getDataTime(int value) {
    DateTime today = DateTime.now();
    return today.subtract(Duration(days: value)).toUtc().toIso8601String();
  }

  //Nav to detail page
  navToDetail(BuildContext context, String date, String logoUrl) {
    Navigator.pushNamed(context, 'detail',
        arguments: {'date': date, 'logoUrl': logoUrl});
  }
}
