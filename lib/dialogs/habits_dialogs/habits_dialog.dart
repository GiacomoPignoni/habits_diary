import 'package:flutter/material.dart';
import 'package:project_habits/dialogs/add_habit_dialog/add_habit_dialog.dart';
import 'package:project_habits/dialogs/habits_dialogs/habits_dialog_controller.dart';
import 'package:project_habits/dialogs/habits_dialogs/habits_list.dart';
import 'package:project_habits/widgets/text_button.dart';
import 'package:provider/provider.dart';

class HabitsDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (ctx) => HabitsDialogController(),
      dispose: (ctx, HabitsDialogController controller) => controller.dispose(),
      child: Consumer<HabitsDialogController>(
        builder: (cts, controller, child) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.all(0),
            contentPadding: const EdgeInsets.all(0),
            content: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10)
                )
              ),
              padding: const EdgeInsets.only(top: 15),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.15,
                          child: MyTextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            text: "Close",
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Habits",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline2
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.15,
                          child: MyTextButton(
                            onPressed: () => AddHabitDialog.show(context),
                            text: "Add",
                            align: TextAlign.right,
                          ),
                        ),
                      ]
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: HabitsList(),
                    )
                  )
                ]
              ),
            ),
          );
        },
      )
    );
  }

  static Future<void> show(BuildContext context) {
    return showGeneralDialog(
      context: context,
      transitionDuration: const Duration(milliseconds: 300),
      barrierDismissible: true,
      barrierLabel: "habits-dialog",
      transitionBuilder: (ctx, anim1, anim2, child) {
        final curvedAnimation = CurvedAnimation(
          parent: anim1,
          curve: Curves.ease
        );

        return SlideTransition(
          position: Tween<Offset>(begin: Offset(0, 1), end: Offset(0, 0.1)).animate(curvedAnimation),
          child: child,
        );
      },
      pageBuilder: (ctx, anim1, anima2) => HabitsDialog()
    );
  }
}