import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final String text;
  final Function onPressed;
  final Color? color;
  final bool enabled;

  Button({
    required this.text,
    required this.onPressed,
    this.enabled = true,
    this.color
  });

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  bool isTapDown = false;

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? Theme.of(context).accentColor;

    return GestureDetector(
      onTap: () {
        if(widget.enabled) {
          widget.onPressed();
        }
      },
      onTapDown: (details) => setState(() { isTapDown = true; }),
      onTapUp: (details) => setState(() { isTapDown = false; }),
      onTapCancel: () => setState(() { isTapDown = false; }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        decoration: BoxDecoration(
          color: (isTapDown || widget.enabled == false) ? HSVColor.fromColor(color).withValue(0.6).toColor() : color,
          borderRadius: BorderRadius.circular(5)
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(
          widget.text,
          style: Theme.of(context).textTheme.headline4
        ),
      ),
    );
  }
}