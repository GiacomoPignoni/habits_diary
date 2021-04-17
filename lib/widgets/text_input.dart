import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final Function(String newValue) onChanged;
  final String label;
  final String? hint;
  final TextEditingController? controller;
  final Function(String newValue)? onSubmitted;
  final bool autoFocus;

  TextInput({
    required this.onChanged,
    required this.label,
    this.hint,
    this.controller,
    this.onSubmitted,
    this.autoFocus = false
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      autofocus: autoFocus,
      style: Theme.of(context).textTheme.bodyText2,
      cursorColor: Theme.of(context).accentColor,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
          fontWeight: FontWeight.bold
        ),
        alignLabelWithHint: true,
        hintText: hint,
        hintStyle: Theme.of(context).textTheme.bodyText2,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).accentColor),
          borderRadius: BorderRadius.circular(10)
        ),
      ),
    );
  }
}