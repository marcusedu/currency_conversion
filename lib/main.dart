import 'package:currency_conversion/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:ms_material_color/ms_material_color.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conversor de Moeda',
      theme: ThemeData(
        primarySwatch: MsMaterialColor(0xFFFFD185),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: AppRoutes.routes,
      initialRoute: AppRoutes.login,
    );
  }
}
