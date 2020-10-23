part of './converter_cubit.dart';

@immutable
abstract class ConverterState {}

class ConverterInitial extends ConverterState {}

class ExchangeRateLoaded extends ConverterState {
  final Rate rate;
  final String base, symbol, result;

  ExchangeRateLoaded(this.rate, this.base, this.symbol, [this.result]);
}

class ExchangeRateFails extends ConverterState {
  final dynamic error;

  ExchangeRateFails(this.error);
}
