import 'package:flutter/material.dart';

class NumericalKeyPad extends StatefulWidget {
  final Function(num) onInput;
  final Function() onRemove;
  final Function() onLongRemove;
  final Color backgroundColor;
  final Color accentColor;
  final double maxWidth;

  const NumericalKeyPad(
      {Key key,
      @required this.onInput,
      @required this.onRemove,
      this.onLongRemove,
      this.backgroundColor,
      this.accentColor,
      this.maxWidth})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _NumericalKeyPadState();
}

class _NumericalKeyPadState extends State<NumericalKeyPad> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        numericInputRow(1),
        SizedBox(
          height: widget.maxWidth * 0.04,
        ),
        numericInputRow(4),
        SizedBox(
          height: widget.maxWidth * 0.04,
        ),
        numericInputRow(7),
        SizedBox(
          height: widget.maxWidth * 0.04,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              width: widget.maxWidth * 0.27,
            ),
            numericInputButton(0),
            SizedBox(
              width: widget.maxWidth * 0.07,
            ),
            GestureDetector(
                onLongPress: widget.onLongRemove,
                onTap: widget.onRemove,
                child: Container(
                    width: widget.maxWidth * 0.2,
                    height: widget.maxWidth * 0.2,
                    alignment: Alignment.center,
                    // child: SvgPicture.asset(Assets.backspace,
                    //     width: widget.maxWidth * 0.14,
                    //     height: widget.maxWidth * 0.14,
                    //     color: widget.accentColor),
                    child: Icon(Icons.backspace_outlined, size: 60, color: widget.accentColor,),
                ),
            )
          ],
        )
      ],
    );
  }

  Widget numericInputRow(num start) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        numericInputButton(start),
        SizedBox(
          width: widget.maxWidth * 0.07,
        ),
        numericInputButton(start + 1),
        SizedBox(
          width: widget.maxWidth * 0.07,
        ),
        numericInputButton(start + 2),
      ],
    );
  }

  Widget numericInputButton(num display) {
    return NumPadButton(
        display: display,
        size: widget.maxWidth * 0.2,
        accentColor: widget.accentColor,
        backgroundColor: widget.backgroundColor,
        onPress: widget.onInput);
  }
}

class NumPadButton extends StatefulWidget {
  final double size;
  final num display;
  final Color accentColor;
  final Color backgroundColor;
  final Function(num n) onPress;

  const NumPadButton(
      {Key key,
      this.size,
      this.display,
      this.accentColor,
      this.backgroundColor,
      this.onPress})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _NumpadButtonState();
}

class _NumpadButtonState extends State<NumPadButton>
    with SingleTickerProviderStateMixin {
  Animation<Color> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = ColorTween(begin: Colors.grey, end: widget.accentColor)
        .animate(controller);
  }

  void animateColor() {
    controller.reverse(from: 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return MaterialButton(
              elevation: 0,
              minWidth: widget.size,
              height: widget.size,
              color: widget.backgroundColor,
              shape: CircleBorder(
                  side: BorderSide(width: 1, color: animation.value)),
              onPressed: () {
                animateColor();
                widget.onPress(widget.display);
              },
              child: Text(
                '${widget.display}',
                style: TextStyle(
                  fontSize: widget.size * 0.35,
                  color: widget.accentColor,
                  fontWeight: FontWeight.w600,
                ),
              ));
        });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
