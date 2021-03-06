import 'package:currency_conversion/di/injector.dart';
import 'package:currency_conversion/ui/converter/converter_screen.dart';
import 'package:currency_conversion/ui/history/history_screen.dart';
import 'package:currency_conversion/ui/login/login_screen.dart';
import 'package:currency_conversion/ui/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoutes {
  static String root = '/';
  static String history = '/history';
  static String splash = '/splash';
  static String login = '/login';

  static Map<String, Widget Function(BuildContext context)> routes = {
    splash: (context) => SplashScreen(),
    root: (context) => BlocProvider(
          create: (_) => Injector.instance.converterCubit..loadRate(),
          child: ConverterScreen(),
        ),
    history: (context) => BlocProvider(
          child: HistoryScreen(),
          create: (_) => Injector.instance.historyCubit..refresh(),
        ),
    login: (context) => LoginScreen()
  };
}
