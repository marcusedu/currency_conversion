import 'package:currency_conversion/routes/app_routes.dart';
import 'package:currency_conversion/ui/converter/cubit/converter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConverterScreen extends StatelessWidget {
  final TextEditingController baseCtrl = TextEditingController(),
      symbolCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conversão de Moeda'),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.history);
            },
            child: Text('Histórico'),
          ),
        ],
      ),
      body: BlocConsumer<ConverterCubit, ConverterState>(
        listener: (context, state) {
          if (state is ExchangeRateLoaded && state.result != null) {
            symbolCtrl.text = state.result;
          } else if (state is ExchangeRateFails) {}
        },
        builder: (context, state) => Form(
          child: RefreshIndicator(
            onRefresh: () async =>
                await context.bloc<ConverterCubit>().loadRate(),
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              children: [
                DropdownButton<String>(
                  hint: Text('TIPO MOEDA'),
                  value: state is ExchangeRateLoaded ? state.base : null,
                  isExpanded: true,
                  items: state is ExchangeRateLoaded
                      ? (state.rate.rates.entries.toList()
                            ..sort((a, b) => a.key.compareTo(b.key)))
                          .map((e) => DropdownMenuItem<String>(
                                child: Text(e.key),
                                value: e.key,
                              ))
                          .toList()
                      : [],
                  onChanged: (value) {
                    context.bloc<ConverterCubit>().changeBase(value);
                  },
                ),
                Divider(color: Colors.transparent),
                TextFormField(
                  controller: baseCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText:
                        'Valor ${state is ExchangeRateLoaded ? state.base : ''}',
                  ),
                ),
                Divider(color: Colors.transparent),
                DropdownButton<String>(
                  hint: Text('MOEDA DESEJADA'),
                  value: state is ExchangeRateLoaded ? state.symbol : null,
                  isExpanded: true,
                  items: state is ExchangeRateLoaded
                      ? (state.rate.rates.entries.toList()
                            ..sort((a, b) => a.key.compareTo(b.key)))
                          .map((e) => DropdownMenuItem<String>(
                                child: Text(e.key),
                                value: e.key,
                              ))
                          .toList()
                      : [],
                  onChanged: (value) {
                    context.bloc<ConverterCubit>().changeSymbol(value);
                  },
                ),
                Divider(color: Colors.transparent),
                TextFormField(
                  controller: symbolCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Novo Valor',
                  ),
                ),
                Divider(color: Colors.transparent),
                FlatButton(
                    onPressed: () {
                      context
                          .bloc<ConverterCubit>()
                          .loadRate(baseCtrl.text.trim());
                    },
                    color: Theme.of(context).primaryColor,
                    child: Text('Converter'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
