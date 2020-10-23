import 'package:currency_conversion/ui/history/cubit/history_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ms_undraw/illustrations.g.dart';
import 'package:ms_undraw/ms_undraw.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Histórico',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: RefreshIndicator(
        onRefresh: () async => context.bloc<HistoryCubit>().refresh(),
        child: BlocConsumer<HistoryCubit, HistoryState>(
          listener: (BuildContext context, state) {},
          builder: (context, state) {
            if (state is HistoryListLoaded)
              return ListView.separated(
                itemCount: state.historical.length,
                padding: EdgeInsets.symmetric(vertical: 16.0),
                itemBuilder: (context, index) {
                  var rate = state.historical[index];
                  return Dismissible(
                    key: Key(rate.uuid),
                    confirmDismiss: (direction) async {
                      await context.bloc<HistoryCubit>().deleteRate(rate);
                      return true;
                    },
                    background: Container(
                      color: Theme.of(context).errorColor,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete_forever_outlined,
                            color: Colors.white,
                          ),
                          Spacer(),
                          Icon(
                            Icons.delete_forever_outlined,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    child: ListTile(
                      title: Text('${rate.base} para ${rate.symbol}'),
                      subtitle: Text(
                          '${rate.baseValue} ${rate.base} * ${rate.rates[rate.symbol].toStringAsFixed(2)} ${rate.symbol} = ${rate.symbolValue} ${rate.symbol}'
                          '\nData da consulta: ${rate.date.toString().substring(0, 10)}'),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
              );
            return FutureBuilder(
              future: Future.delayed(Duration(seconds: 5)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done)
                  return Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        UnDraw(
                          illustration: UnDrawIllustration.waiting_for_you,
                          color: Theme.of(context).primaryColor,
                          height: 120,
                        ),
                        Divider(color: Colors.transparent),
                        Text('Isso está demorando muito'),
                        Divider(color: Colors.transparent),
                        FlatButton(
                            onPressed: context.bloc<HistoryCubit>().refresh,
                            child: Text('Recarregar'))
                      ],
                    ),
                  );
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
