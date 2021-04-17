import 'package:flutter/material.dart';
import 'package:project_habits/dialogs/habits_dialogs/habits_dialog_controller.dart';
import 'package:project_habits/models/habit.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HabitsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HabitsDialogController>(context);

    return StreamBuilder<Map<int, Habit>>(
      stream: controller.habits.stream,
      initialData: controller.habits.value,
      builder: (context, snapshot) {
        return ListView.builder(
          padding: const EdgeInsets.all(0),
          itemCount: snapshot.data!.length,
          itemBuilder: (ctx, i) {
            final habit = snapshot.data![snapshot.data!.keys.elementAt(i)]!;
            final slidableController = SlidableController();

            return GestureDetector(
              onTap: () => controller.showHabitDetailsDialog(context, habit.id),
              child: Slidable(
                actionPane: SlidableDrawerActionPane(),
                controller: slidableController,
                secondaryActions: [
                  GestureDetector(
                    onTap: () => controller.showDeleteHabitConfirmation(context, habit.id, slidableController),
                    child: SizedBox.expand(
                      child: Container(
                        color: Theme.of(context).highlightColor,
                        alignment: Alignment.center,
                        child: Text(
                          "Delete",
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                    ),
                  )
                ],
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          habit.emoji,
                          style: Theme.of(context).textTheme.headline1!.copyWith(
                            color: Theme.of(context).primaryColorDark
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              habit.text,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  controller.getDaysString(habit),
                                  style: Theme.of(context).textTheme.subtitle1
                                ),
                                Text(
                                  habit.startPeriod != null ? "Start from: ${controller.getStartPeriodString(habit.startPeriod!)}" : "",
                                  style: Theme.of(context).textTheme.subtitle1,
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          } 
        );
      }
    );
  }
}