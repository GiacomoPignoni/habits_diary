import 'package:flutter/material.dart';
import 'package:project_habits/dialogs/add_habit_dialog/add_habit_dialog_controller.dart';
import 'package:project_habits/dialogs/add_habit_dialog/period_input.dart';
import 'package:project_habits/dialogs/add_habit_dialog/start_period_input.dart';
import 'package:project_habits/widgets/button.dart';
import 'package:project_habits/widgets/emoji_input.dart';
import 'package:project_habits/widgets/text_input.dart';
import 'package:provider/provider.dart';

class AddHabitDialog extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (ctx) => AddHabitDialogController(),
      dispose: (ctx, AddHabitDialogController controller) => controller.dispose(),
      child: Consumer<AddHabitDialogController>(
        builder: (ctx, controller, child) {
          return AlertDialog(
            insetPadding: const EdgeInsets.all(0),
            contentPadding: const EdgeInsets.all(0),
            backgroundColor: Theme.of(context).backgroundColor,
            scrollable: true,
            content: Container(
              width: MediaQuery.of(context).size.width * 0.95,
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Add Habit",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                  Divider(color: Colors.transparent),
                  Center(
                    child: Text(
                      "Icon",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  Center(
                    child: EmojiInput(
                      onChange: controller.changeEmojiValue, 
                      initialEmoji: " "
                    )
                  ),
                  Divider(color: Colors.transparent),
                  TextInput(
                    onChanged: controller.changeTextValue,
                    label: "Name",
                    hint: "Insert habit name...",
                  ),
                  Divider(color: Colors.transparent),
                  Text(
                    "Period:",
                    style: Theme.of(context).textTheme.bodyText2
                  ),
                  Divider(color: Colors.transparent, height: 10),
                  PeriodInput(),
                  Divider(color: Colors.transparent),
                  Text(
                    "Start Period:",
                    style: Theme.of(context).textTheme.bodyText2
                  ),
                  Divider(color: Colors.transparent, height: 10),
                  StartPeriodInput(),
                  Divider(color: Colors.transparent, height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Button(
                        onPressed: () => Navigator.of(context).pop(),
                        text: "Cancel",
                        color: Theme.of(context).highlightColor
                      ),
                      StreamBuilder<bool>(
                        stream: controller.addBtnEnabled,
                        initialData: false,
                        builder: (context, snapshot) {
                          return Button(
                            onPressed: () => controller.addHabit(context),
                            text: "Add",
                            enabled: snapshot.data!,
                          );
                        }
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        }
      ),
    );
  }

  static void show(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierLabel: "add-habit-dialog",
      barrierDismissible: true,
      transitionDuration: const Duration(milliseconds: 200),
      transitionBuilder: (ctx, anim1, anim2, child) {
        final curvedAnimation = CurvedAnimation(
          parent: anim1,
          curve: Curves.ease
        );

        return ScaleTransition(
          scale: curvedAnimation,
          child: child,
        );
      },
      pageBuilder: (cts, anim1, anim2) {
        return AddHabitDialog();
      }
    );
  }
}