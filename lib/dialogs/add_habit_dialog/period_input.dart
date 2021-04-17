import 'package:flutter/material.dart';
import 'package:project_habits/dialogs/add_habit_dialog/add_habit_dialog_controller.dart';
import 'package:provider/provider.dart';

class PeriodInput extends StatelessWidget {  
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AddHabitDialogController>(context);
  
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        MiniDayButton(
          text: "M", 
          initialChecked: controller.period[0],
          onValueChange: (newValue) => controller.changePeriodValue(0, newValue),
        ),
        MiniDayButton(
          text: "T", 
          initialChecked: controller.period[1],
          onValueChange: (newValue) => controller.changePeriodValue(1, newValue),
        ),
        MiniDayButton(
          text: "W", 
          initialChecked: controller.period[2],
          onValueChange: (newValue) => controller.changePeriodValue(2, newValue),
        ),
        MiniDayButton(
          text: "T", 
          initialChecked: controller.period[3],
          onValueChange: (newValue) => controller.changePeriodValue(3, newValue),
        ),
        MiniDayButton(
          text: "F", 
          initialChecked: controller.period[4],
          onValueChange: (newValue) => controller.changePeriodValue(4, newValue),
        ),
        MiniDayButton(
          text: "S", 
          initialChecked: controller.period[5],
          onValueChange: (newValue) => controller.changePeriodValue(5, newValue),
        ),
        MiniDayButton(
          text: "S", 
          initialChecked: controller.period[6],
          onValueChange: (newValue) => controller.changePeriodValue(6, newValue),
        )
      ],
    );
  }
}

class MiniDayButton extends StatefulWidget {
  final String text;
  final bool initialChecked;
  final Function(bool newValue) onValueChange;

  MiniDayButton({
    required this.text,
    required this.initialChecked,
    required this.onValueChange
  });

  @override
  _MiniDayButtonState createState() => _MiniDayButtonState();
}

class _MiniDayButtonState extends State<MiniDayButton> {
  bool checked = false;

  @override
  void initState() {
    checked = widget.initialChecked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          checked = !checked;          
        });
        widget.onValueChange(checked);
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).shadowColor,
        ),
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              switchInCurve: Curves.elasticOut,
              switchOutCurve: Curves.easeInOutExpo,
              transitionBuilder: (child, anim) {
                return ScaleTransition(
                  scale: anim,
                  child: child,
                );
              },
              child: (checked) 
                ? Container (
                  key: ValueKey<bool>(true),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).accentColor,
                  )
                )
                : SizedBox.shrink()
            ),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: (checked) ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColorDark,
                fontSize: 18
              ),
              child: Text(
                widget.text,
                textAlign: TextAlign.center
              ),
            ),
          ]
        ),
      ),
    );
  }
}