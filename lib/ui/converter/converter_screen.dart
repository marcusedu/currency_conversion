import 'package:currency_conversion/routes/app_routes.dart';
import 'package:currency_conversion/ui/converter/cubit/converter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConverterScreen extends StatelessWidget {

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
            context.bloc<ConverterCubit>().symbolCtrl.text = state.result;
          } else if (state is ExchangeRateFails) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
                'Ocorreu um erro',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Theme.of(context).errorColor,
            ));
          }
        },
        builder: (context, state) => Form(
          child: RefreshIndicator(
            onRefresh: () async =>
            await context.bloc<ConverterCubit>().loadRate(),
            child: Form(
              child: Builder(
                builder: (formContext) =>
                    ListView(
                      padding: EdgeInsets.symmetric(
                          vertical: 16, horizontal: 32),
                      children: [
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: 'TIPO MOEDA',
                            hintText: 'Selecione a moeda base',
                          ),
                          validator: (value) {
                            if (value == null)
                              return 'Você deve selecionar uma moeda base';
                            return null;
                          },
                          value: state is ExchangeRateLoaded
                              ? state.base
                              : null,
                          isExpanded: true,
                          items: state is ExchangeRateLoaded
                              ? (state.rate.rates.entries.toList()
                            ..sort((a, b) => a.key.compareTo(b.key)))
                              .map((e) =>
                              DropdownMenuItem<String>(
                                child: Text(e.key,),
                                value: e.key,
                              ))
                              .toList()
                              : [],
                          onChanged: (value) {
                            context
                                .bloc<ConverterCubit>()
                                .symbolCtrl
                                .clear();
                            context.bloc<ConverterCubit>().changeBase(value);
                          },
                        ),
                        Divider(color: Colors.transparent),
                        TextFormField(
                          controller: context
                              .bloc<ConverterCubit>()
                              .baseCtrl,
                          keyboardType: TextInputType.numberWithOptions(),
                          decoration: InputDecoration(
                            labelText:
                            'Valor ${state is ExchangeRateLoaded
                                ? state.base
                                : ''}',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return 'Você deve informar o valor a ser convertido';
                            return null;
                          },
                        ),
                        Divider(color: Colors.transparent),
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: 'MOEDA DESEJADA',
                            hintText: 'Selecione a moeda para conversão',
                          ),
                          validator: (value) {
                            if (value == null)
                              return 'Você deve selecionar uma moeda desejada';
                            return null;
                          },
                          value: state is ExchangeRateLoaded
                              ? state.symbol
                              : null,
                          isExpanded: true,
                          items: state is ExchangeRateLoaded
                              ? (state.rate.rates.entries.toList()
                            ..sort((a, b) => a.key.compareTo(b.key)))
                              .map((e) =>
                              DropdownMenuItem<String>(
                                child: Text(e.key),
                                value: e.key,
                              ))
                              .toList()
                              : [],
                          onChanged: (value) {
                            context
                                .bloc<ConverterCubit>()
                                .symbolCtrl
                                .clear();
                            context.bloc<ConverterCubit>().changeSymbol(value);
                          },
                        ),
                        Divider(color: Colors.transparent),
                        TextFormField(
                          controller: context
                              .bloc<ConverterCubit>()
                              .symbolCtrl,
                          keyboardType: TextInputType.number,
                          enabled: false,
                          decoration: InputDecoration(
                            labelText: 'Novo Valor',
                          ),
                        ),
                        Divider(color: Colors.transparent),
                        FlatButton(
                            onPressed: () {
                              if (Form.of(formContext).validate())
                                context
                                    .bloc<ConverterCubit>()
                                    .loadRate(context
                                    .bloc<ConverterCubit>()
                                    .baseCtrl
                                    .text
                                    .trim());
                            },
                            color: Theme
                                .of(context)
                                .primaryColor,
                            child: Text('Converter'))
                      ],
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
