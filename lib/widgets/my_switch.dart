import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MySwitch extends StatefulWidget {
  final bool? initialValue;
  final Function(bool newValue) onChanged;

  MySwitch({ 
    required this.onChanged,
    this.initialValue
  });

  @override
  _MySwitchState createState() => _MySwitchState();
}

class _MySwitchState extends State<MySwitch> {
  bool selected = false;

  @override
  void initState() {
    selected = widget.initialValue ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(Platform.isIOS) {
      return CupertinoSwitch(
        value: selected, 
        onChanged: (newValue) => setState(() {
          selected = newValue;
          widget.onChanged(newValue);
        }),
        activeColor: Theme.of(context).accentColor,
      );
    } else {
      return Switch(
        value: selected, 
        onChanged: (newValue) => setState(() {
          selected = newValue;
          widget.onChanged(newValue);
        }),
        activeColor: Theme.of(context).accentColor,
      );
    }
  }
}