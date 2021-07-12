import 'package:flutter/material.dart';

import 'numerical_keypad.dart';

/// This widget uses the [NumericalKeyPad] as input to create a custom
/// password form. Password must be 6 digits then submit automatically,
/// let parent widget handle submit.
class PasswordForm extends StatefulWidget {
  final int digits;
  final String title;
  final Color backgroundColor;
  final Color accentColor;
  final double width;
  final Function(String) onSubmit;
  final Function() onBackButtonPressed;

  const PasswordForm(
      {Key key,
      this.title,
      this.digits = 6,
      this.width,
      this.backgroundColor,
      this.accentColor,
      this.onSubmit,
      this.onBackButtonPressed})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => PasswordFormState();
}

class PasswordFormState extends State<PasswordForm> {
  List<num> input = List();

  void clear() {
    widget.onBackButtonPressed?.call();
    setState(() => input.clear());
  }

  void removeLast() {
    widget.onBackButtonPressed?.call();
    setState(() => input.length > 0 ? input.removeLast() : null);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      child: Center(
          child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.account_circle_outlined, size: 65, color: Colors.blue[900],),
            SizedBox(height: 10),
            Text(widget.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 22.0,
                    color: widget.accentColor, // Green
                    fontWeight: FontWeight.w500)),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              // Digits inserted display
              for (var i = 0; i < widget.digits; i++)
                Container(
                  width: 20,
                  height: 20,
                  margin: EdgeInsets.all(8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: i < input.length
                          ? widget.accentColor
                          : Colors.white,
                      border: Border.all(width: 1, color: widget.accentColor)),
                  padding: EdgeInsets.all(5),
                )
            ]),
            SizedBox(
              height: 15,
            ),
            NumericalKeyPad(
                onInput: (number) => setState(() {
                      if (input.length < widget.digits) {
                        input.add(number);
                        if (input.length == widget.digits) {
                          widget.onSubmit(input.join());
                        }
                      }
                    }),
                onRemove: removeLast,
                onLongRemove: clear,
                backgroundColor: widget.backgroundColor,
                accentColor: widget.accentColor,
                maxWidth: widget.width),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      )),
    );
  }
}
