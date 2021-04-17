import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircularButton extends StatefulWidget {
  final Function() onPressed;
  final Icon icon;
  final EdgeInsetsGeometry? padding;
  final bool noBackground;

  CircularButton({
    required this.onPressed,
    required this.icon,
    this.padding,
    this.noBackground = false
  });

  @override
  _CircularButtonState createState() => _CircularButtonState();
}

class _CircularButtonState extends State<CircularButton> {
  bool isTapDown = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: (details) => setState(() { isTapDown = true; }),
      onTapUp: (details) => setState(() { isTapDown = false; }),
      onTapCancel: () => setState(() { isTapDown = false; }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: widget.padding,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: (isTapDown)
            ? (widget.noBackground) ? Colors.transparent : HSVColor.fromColor(Theme.of(context).accentColor).withValue(0.6).toColor()
            : (widget.noBackground) ? Colors.transparent : Theme.of(context).accentColor,
        ),
        child: widget.icon
      ),
    );
  }
}