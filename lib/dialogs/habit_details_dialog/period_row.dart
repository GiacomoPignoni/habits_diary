import 'package:flutter/material.dart';
import 'package:project_habits/dialogs/habit_details_dialog/habit_details_dialog_controller.dart';
import 'package:provider/provider.dart';

class PeriodRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HabitDetailsDialogController>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PeriodDayBox(
          text: "M",
          colored: controller.habit.period.contains(1),
        ),
        PeriodDayBox(
          text: "T",
          colored: controller.habit.period.contains(2),
        ),
        PeriodDayBox(
          text: "W",
          colored: controller.habit.period.contains(3),
        ),
        PeriodDayBox(
          text: "T",
          colored: controller.habit.period.contains(4),
        ),
        PeriodDayBox(
          text: "F",
          colored: controller.habit.period.contains(5),
        ),
        PeriodDayBox(
          text: "S",
          colored: controller.habit.period.contains(6),
        ),
        PeriodDayBox(
          text: "S",
          colored: controller.habit.period.contains(7),
        )
      ],
    );
  }
}

class PeriodDayBox extends StatelessWidget {
  final String text;
  final bool colored;

  PeriodDayBox({
    required this.text,
    required this.colored
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: (colored) ? Theme.of(context).accentColor : Theme.of(context).shadowColor,
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
          fontSize: 18,
          color: (colored) ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColorDark
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
