
import 'package:flutter/material.dart';

import 'digit_password/password_form.dart';

/// Validates the user by password and routes to [SelectLicensePlatePage].
class PinLoginPage extends StatefulWidget {
  static String route = '/password';

  @override
  State<StatefulWidget> createState() => _PinLoginPageState();
}

class _PinLoginPageState extends State<PinLoginPage> {
  String _password;
  GlobalKey<PasswordFormState> _key = GlobalKey();

  // void badResponse(context, result) {
  //   _key.currentState.clear();
  //   showErrorDialog(context,"${result.responseCode} ${result.responseBody}");
  // }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width < 380
        ? MediaQuery.of(context).size.width
        : 380;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, iconTheme: IconThemeData(color: Colors.blue[900]), elevation: 0,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          PasswordForm(
            key: _key,
            title: 'Please enter your password',
            width: width,
            backgroundColor: Colors.white,
            accentColor: Colors.blue[900],
            onSubmit: (String pin) => setState(() => _password = pin),
            onBackButtonPressed: () => setState(() => _password = null),

          ),
          Visibility(
              maintainState: true,
              maintainAnimation: true,
              maintainSize: true,
              visible: _password != null,
              child: MaterialButton(
                  minWidth: width * 0.74,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  color: Colors.blue[900],
                  child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    Text('Log in',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                    )
                  ]),
                  onPressed: () {
                    print('Pressed Login button');
                    print('---- password is ----');
                    print(_password);
                    // TODO: Put the logic here after get password.
                },
            ),
          ),
          // TODO: Just show how to clear password.
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                child: Text('Clear'),
                onPressed: (){
                  _key.currentState.clear();
                  print(_password);
              }),
            ),
          )
        ],
      ),
    );
  }
}
