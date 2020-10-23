import 'package:currency_conversion/model/rate.dart';

abstract class ExchangeRateDataSource {
  Future<Rate> fromDay({DateTime from, String base, List<String> symbols});
}
