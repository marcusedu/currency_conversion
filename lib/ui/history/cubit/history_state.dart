part of 'history_cubit.dart';

@immutable
abstract class HistoryState {}

class HistoryInitial extends HistoryState {}

class HistoryListLoaded extends HistoryState {
  final List<Rate> historical;

  HistoryListLoaded(this.historical) {
    this.historical.sort((rA, rB) => rB.date.compareTo(rA.date));
  }
}

class HistoryListLoadFails extends HistoryState {
  final dynamic error;

  HistoryListLoadFails(this.error);
}
