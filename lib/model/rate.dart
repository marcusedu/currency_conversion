import 'package:ms_map_utils/ms_map_utils.dart';
import 'package:ms_persist/ms_persist.dart';

class Rate with Persist<Rate> {
  DateTime date, createdAt, updatedAt;
  String uuid, base, baseValue, symbol, symbolValue;
  Map<String, num> rates;

  Rate(
      {this.base,
      this.baseValue,
      this.createdAt,
      this.date,
      this.rates,
      this.symbol,
      this.symbolValue,
      this.updatedAt,
      this.uuid});

  factory Rate.fromMap(Map<String, dynamic> map) {
    return new Rate(
      uuid: map['uuid'] as String,
      base: map['base'] as String,
      baseValue: map['baseValue'] as String,
      symbol: map['symbol'] as String,
      symbolValue: map['symbolValue'] as String,
      date: map.doIfContains(
        'date',
        doWork: (key, value) => DateTime.tryParse(value),
      ),
      createdAt: map.doIfContains(
        'createdAt',
        doWork: (key, value) => DateTime.tryParse(value),
      ),
      updatedAt: map.doIfContains(
        'updatedAt',
        doWork: (key, value) => DateTime.tryParse(value),
      ),
      rates: map['rates']
          .map((k, v) => MapEntry<String, num>(k, v))
          .cast<String, num>() as Map<String, num>,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': this.date.toIso8601String(),
      'createdAt': this.createdAt.toIso8601String(),
      'updatedAt': this.updatedAt.toIso8601String(),
      'uuid': this.uuid,
      'base': this.base,
      'baseValue': this.baseValue,
      'symbol': this.symbol,
      'symbolValue': this.symbolValue,
      'rates': this.rates,
    };
  }

  @override
  Rate buildModel(Map<String, dynamic> map) {
    return Rate.fromMap(map);
  }

  Rate copyWith({
    DateTime date,
    DateTime createdAt,
    DateTime updatedAt,
    String uuid,
    String base,
    String baseValue,
    String symbol,
    String symbolValue,
    Map<String, num> rates,
  }) {
    return new Rate(
      date: date ?? this.date,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      uuid: uuid ?? this.uuid,
      base: base ?? this.base,
      baseValue: baseValue ?? this.baseValue,
      symbol: symbol ?? this.symbol,
      symbolValue: symbolValue ?? this.symbolValue,
      rates: rates ?? this.rates,
    );
  }
}
