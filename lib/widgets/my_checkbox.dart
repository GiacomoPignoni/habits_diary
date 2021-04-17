import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyCheckbox extends StatefulWidget {
  final bool initValue;
  final Function(bool newValue) onChange;

  MyCheckbox({
    this.initValue = false,
    required this.onChange
  }) : super(key: GlobalKey());

  @override
  _MyCheckboxState createState() => _MyCheckboxState();
}

class _MyCheckboxState extends State<MyCheckbox> {
  late bool value;

  @override
  void initState() {
    value = widget.initValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      activeColor: Theme.of(context).accentColor,
      checkColor: Theme.of(context).primaryColorLight,
      
      onChanged: (newValue) {
        setState(() {
          value = newValue ?? false;  
        });
        widget.onChange(value);
      }
    );
  }
}