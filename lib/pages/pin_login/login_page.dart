import 'package:flutter/material.dart';

import 'pin_login_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(
        child: RaisedButton(
            child: Text('Go to pin login page'),
            onPressed: () {
              print('Go to pin Login page');
              Navigator.push(context, MaterialPageRoute(builder: (context)=> PinLoginPage()));
            }),
      ),
    );
  }
}
