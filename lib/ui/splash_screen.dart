import 'package:currency_conversion/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:ms_undraw/illustrations.g.dart';
import 'package:ms_undraw/ms_undraw.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(Duration(milliseconds: 2500), () {
        Navigator.of(context).pushReplacementNamed(AppRoutes.root);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(32.0),
      color: Theme.of(context).backgroundColor,
      child: Center(
        child: UnDraw(
          illustration: UnDrawIllustration.digital_currency,
          color: Theme.of(context).primaryColor,
          errorWidget: Icon(
            Icons.monetization_on_outlined,
            size: 120,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
