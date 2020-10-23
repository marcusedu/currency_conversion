import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login no app',
          style: TextStyle(color: Colors.white),
        ),
        primary: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Form(
          child: Builder(
        builder: (context) => ListView(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          children: [
            TextFormField(
              decoration:
                  InputDecoration(labelText: 'Email ou Nome de Usuário'),
            ),
            Divider(color: Colors.transparent),
            TextFormField(
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            Divider(color: Colors.transparent),
            FlatButton(
              onPressed: () => _goHome(context),
              color: Theme.of(context).primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'LOGIN',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
            Divider(color: Colors.transparent),
            Row(
              children: [
                Expanded(child: Divider()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text('ou'),
                ),
                Expanded(child: Divider())
              ],
            ),
            Divider(color: Colors.transparent),
            FlatButton(
              onPressed: () => _goHome(context),
              color: Color(0xFF3b5998),
              child: Row(
                children: [
                  Icon(MdiIcons.facebook, color: Colors.white),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'LOGIN COM FACEBOOK',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            Divider(color: Colors.transparent),
            FlatButton(
              onPressed: () => _goHome(context),
              color: Color(0xFF1DA1F2),
              child: Row(
                children: [
                  Icon(MdiIcons.twitter, color: Colors.white),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'LOGIN COM TWITTER',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            Divider(color: Colors.transparent),
            FlatButton(
              onPressed: () => _goHome(context),
              color: Color(0xFFDB4437),
              child: Row(
                children: [
                  Icon(MdiIcons.google, color: Colors.white),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'LOGIN COM GOOGLE',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            Divider(color: Colors.transparent),
          ],
        ),
      )),
    );
  }

  _goHome(BuildContext context) {
    // Navigator.of(context).pushReplacementNamed(AppRoutes.root);
    Navigator.of(context).pop();
  }
}
