import 'package:flutter/material.dart';

class MyTextButton extends StatefulWidget {
  final Function() onPressed;
  final String text;
  final TextAlign align;

  MyTextButton({
    required this.onPressed,
    required this.text,
    this.align = TextAlign.start
  });

  @override
  _MyTextButtonState createState() => _MyTextButtonState();
}

class _MyTextButtonState extends State<MyTextButton> {
  bool isTapDown = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: (details) => setState(() { isTapDown = true; }),
      onTapUp: (details) => setState(() { isTapDown = false; }),
      onTapCancel: () => setState(() { isTapDown = false; }),
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 100),
        child: Text(
          widget.text,
          textAlign: widget.align,
        ), 
        style: Theme.of(context).textTheme.button!.copyWith(
          color: (isTapDown) 
          ? HSVColor.fromColor(Theme.of(context).accentColor).withValue(0.6).toColor() 
          : Theme.of(context).accentColor
        )
      )
    );
  }
}