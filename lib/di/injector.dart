import 'package:currency_conversion/data_source/exchangerate/exchange_rate_data_source.dart';
import 'package:currency_conversion/data_source/exchangerate/remote/exchange_rate_data_source_api.dart';
import 'package:currency_conversion/ui/converter/cubit/converter_cubit.dart';
import 'package:dio/dio.dart';
import 'package:dioc/dioc.dart' as dioc;

class Injector {
  static Injector _instance;
  static Injector get instance {
    _instance ??= Injector._();
    return _instance;
  }

  dioc.Container _container = dioc.Container();

  Injector._() {
    _registerDio();
    _registerDataSource();
    _registerCubits();
  }

  ConverterCubit get converterCubit =>
      _container.get<ConverterCubit>(creator: 'ConverterCubit');

  Dio get dio => _container.get<Dio>(creator: 'Dio');

  ExchangeRateDataSource get exchangeRateDataSource =>
      _container.get<ExchangeRateDataSource>(creator: 'ExchangeRateDataSource');

  void _registerCubits() {
    _container.register<ConverterCubit>(
      (c) => ConverterCubit(
          exchangeRate: exchangeRateDataSource),
      name: 'ConverterCubit',
      defaultMode: dioc.InjectMode.create,
    );
  }

  void _registerDataSource() {
    _container.register<ExchangeRateDataSource>(
      (container) => ExchangeRateDataSourceApi(dio: dio),
      name: 'ExchangeRateDataSource',
      defaultMode: dioc.InjectMode.singleton,
    );
  }

  void _registerDio() {
    _container.register<Dio>(
      (c) => Dio(BaseOptions(
        headers: {'accept': 'application/json'},
      )),
      name: 'Dio',
      defaultMode: dioc.InjectMode.singleton,
    );
  }
}
