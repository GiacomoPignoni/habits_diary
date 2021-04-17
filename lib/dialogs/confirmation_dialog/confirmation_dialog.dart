import 'package:flutter/material.dart';
import 'package:project_habits/widgets/button.dart';

class ConfirmationDialog extends StatelessWidget {
  final Function() onYes;
  final Function()? onNo;
  final String text;

  ConfirmationDialog(this.onYes, this.onNo, this.text);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
            ),
            Divider(color: Colors.transparent),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Button(
                  text: "No",
                  onPressed: () {
                    Navigator.of(context).pop();
                    if(onNo != null) {
                      onNo!();
                    }
                  },
                  color: Theme.of(context).highlightColor,
                ),
                Button(
                  text: "Yes",
                  onPressed: () {
                    Navigator.of(context).pop();
                    onYes();
                  },
                )
              ]
            )
          ]
        ),
      ),
    );
  }
  
  static void show(
    BuildContext context,
    {
      required Function() onYes,
      Function()? onNo,
      required String text
    }
  ) {
    showGeneralDialog(
      context: context,
      barrierLabel: "confirmation-dialog",
      barrierDismissible: false,
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
        return ConfirmationDialog(onYes, onNo, text);
      }
    );
  }
}