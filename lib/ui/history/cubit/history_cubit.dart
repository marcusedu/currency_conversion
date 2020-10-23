import 'package:bloc/bloc.dart';
import 'package:currency_conversion/model/rate.dart';
import 'package:meta/meta.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryInitial());

  Future<List<Rate>> refresh() async {
    List list;
    try {
      list = await Rate().list();
      this.emit(HistoryListLoaded(list));
    } catch (e) {
      this.emit(HistoryListLoadFails(e));
    }
    return list;
  }

  Future deleteRate(Rate rate) async {
    await rate.delete();
    this.refresh();
  }
}
