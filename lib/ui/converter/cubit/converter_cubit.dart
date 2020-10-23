import 'package:bloc/bloc.dart';
import 'package:currency_conversion/data_source/exchangerate/exchange_rate_data_source.dart';
import 'package:currency_conversion/model/rate.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part './converter_state.dart';

class ConverterCubit extends Cubit<ConverterState> {
  final ExchangeRateDataSource exchangeRate;
  String base, symbol;
  double baseValue;
  Rate lastRate;
  final TextEditingController baseCtrl = TextEditingController(),
      symbolCtrl = TextEditingController();

  ConverterCubit({@required this.exchangeRate}) : super(ConverterInitial());

  String get _newValue {
    if (base != null && symbol != null && baseValue != null) {
      return (this.baseValue * this.lastRate.rates[symbol]).toStringAsFixed(2);
    }
    return '';
  }

  Future<Rate> loadRate([String baseValue]) async {
    this.baseValue = baseValue == null ? null : double.parse(baseValue);
    try {
      lastRate = await exchangeRate.fromDay(base: base);
      _saveSnapshot();
      this.emit(ExchangeRateLoaded(lastRate, base, symbol, _newValue));
    } catch (e) {
      this.emit(ExchangeRateFails(e));
    }
    return lastRate;
  }

  void changeBase(String value) {
    this.base = value;
    this.emit(ExchangeRateLoaded(lastRate, base, symbol));
  }

  void changeSymbol(String value) {
    this.symbol = value;
    this.emit(ExchangeRateLoaded(lastRate, base, symbol));
  }

  void _saveSnapshot() async {
    if (_newValue == '' || _newValue == null) return;
    var draft = lastRate.copyWith(
        uuid: null,
        base: this.base,
        baseValue: this.baseValue.toStringAsFixed(2),
        symbol: this.symbol,
        symbolValue: _newValue);
    var res = await draft.save();
    draft.isDirty();
  }
}
