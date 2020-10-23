import 'package:currency_conversion/data_source/exchangerate/exchange_rate_data_source.dart';
import 'package:currency_conversion/model/rate.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

class ExchangeRateDataSourceApi extends ExchangeRateDataSource {
  final Dio dio;
  final String url = 'https://api.exchangeratesapi.io/';

  ExchangeRateDataSourceApi({@required this.dio});

  @override
  Future<Rate> fromDay(
      {DateTime from, String base, List<String> symbols}) async {
    final response = await dio.get('$url${_formatDate(from) ?? 'latest'}',
        queryParameters: {'base': base, 'symbols': symbols?.join(',')});
    return Rate.fromMap(response.data);
  }

  String _formatDate(DateTime from) {
    if (from == null) return null;
    return '${from.year}-${from.month}-${from.day}';
  }
}
