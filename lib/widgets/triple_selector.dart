import 'package:flutter/material.dart';

class TripleSelector extends StatefulWidget {
  final List<String> options;
  final Function(int value) onChanged;
  final int? initialValue;
  final MainAxisAlignment align;

  TripleSelector({
    required this.options,
    required this.onChanged,
    this.initialValue,
    this.align = MainAxisAlignment.center
  }) : assert(options.length == 3);

  @override
  _TripleSelectorState createState() => _TripleSelectorState();
}

class _TripleSelectorState extends State<TripleSelector> {
  int? selected;

  @override
  void initState() {
    selected = widget.initialValue;
    super.initState();
  }

  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: widget.align,
      children: [
        Box(
          border: Border.all(color: Theme.of(context).accentColor),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
          selected: selected == 0,
          text: widget.options[0],
          onTap: () => _ontap(0)
        ),
        Box(
          border: Border.symmetric(horizontal: BorderSide(color: Theme.of(context).accentColor)),
          selected: selected == 1,
          text: widget.options[1],
          onTap: () => _ontap(1)
        ),
        Box(
          border: Border.all(color: Theme.of(context).accentColor),
          borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
          selected: selected == 2,
          text: widget.options[2],
          onTap: () => _ontap(2),
        ),
      ],
    );
  }

  _ontap(int value) {
    setState(() {
      selected = value;
    });
    widget.onChanged(value);
  }
}

class Box extends StatelessWidget {
  final bool selected;
  final Function() onTap;
  final String text;
  final Border border;
  final BorderRadius? borderRadius;

  Box({
    required this.selected,
    required this.onTap,
    required this.text,
    required this.border,
    this.borderRadius
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: border,
          borderRadius: borderRadius,
          color: selected ? Theme.of(context).accentColor : Colors.transparent
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
            fontSize: Theme.of(context).textTheme.bodyText2!.fontSize! - 2,
            color: selected ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColorDark 
          ),
        ),
      ),
    );
  }
}