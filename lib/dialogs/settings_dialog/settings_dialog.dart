import 'package:flutter/material.dart';
import 'package:project_habits/dialogs/settings_dialog/settings_dialog_controller.dart';
import 'package:project_habits/themes/base_theme.dart';
import 'package:project_habits/widgets/triple_selector.dart';
import 'package:provider/provider.dart';

class SettingsDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (ctx) => SettingsDialogController(),
      dispose: (ctx, SettingsDialogController controller) => controller.dispose(),
      child: Consumer<SettingsDialogController>(
        builder: (ctx, controller, child) => Dialog(
          backgroundColor: Theme.of(context).backgroundColor,
          insetPadding: const EdgeInsets.symmetric(horizontal: 30),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Settings",
                    style: Theme.of(context).textTheme.headline2
                  ),
                ),
                Divider(color: Colors.transparent, height: 20),
                Text(
                  "Light mode",
                ),
                Divider(color: Colors.transparent, height: 5),
                TripleSelector(
                  options: ["Light", "Dark", "Auto"],
                  onChanged: (newValue) => controller.changeThemeStatus(newValue),
                  initialValue: controller.themeStatus.index,
                  align: MainAxisAlignment.start,
                ),
                Divider(color: Colors.transparent),
                Text("Colors"),
                StreamBuilder<Object>(
                  stream: controller.selectedColor.stream,
                  initialData: controller.selectedColor.value,
                  builder: (context, snapshot) {
                    return Row(
                      children: [
                        Expanded(
                          child: ColorsBox(
                            colors: getColors(ThemeColors.yellowBlue),
                            selected: snapshot.data == ThemeColors.yellowBlue,
                            onTap: () => controller.changeThemeColor(ThemeColors.yellowBlue),
                          )
                        ),
                        VerticalDivider(color: Colors.transparent),
                        Expanded(
                          child: ColorsBox(
                            colors: getColors(ThemeColors.purpleGreen),
                            selected: snapshot.data == ThemeColors.purpleGreen,
                            onTap: () => controller.changeThemeColor(ThemeColors.purpleGreen),
                          )
                        ),
                        VerticalDivider(color: Colors.transparent),
                        Expanded(
                          child: ColorsBox(
                            colors: getColors(ThemeColors.orangeBlue),
                            selected: snapshot.data == ThemeColors.orangeBlue,
                            onTap: () => controller.changeThemeColor(ThemeColors.orangeBlue),
                          )
                        ),
                      ],
                    );
                  }
                ),
                Divider(color: Colors.transparent, height: 50),
                GestureDetector(
                  onTap: controller.openGithub,
                  child: Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "This is an open source project\ncheck it on ",
                        style: Theme.of(context).textTheme.subtitle1,
                        children: [
                          TextSpan(
                            text: "GitHub",
                            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              decoration: TextDecoration.underline,
                              color: Theme.of(context).accentColor
                            )
                          )
                        ]
                      )
                    ),
                  ),
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }
  
  static void show(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierLabel: "settings-dialog",
      barrierDismissible: true,
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: (ctx, anim1, anim2, child) {
        final curvedAnimation = CurvedAnimation(
          parent: anim1,
          curve: Curves.easeOut
        );

        return SlideTransition(
          position: Tween<Offset>(begin: Offset(0, -1), end: Offset(0, 0)).animate(curvedAnimation),
          child: child,
        );
      },
      pageBuilder: (cts, anim1, anim2) {
        return SettingsDialog();
      }
    );
  }
}

class ColorsBox extends StatelessWidget {
  static const double HEIGHT = 30;
  static const double RADIUS = 7;

  final List<Color> colors;
  final bool selected;
  final Function() onTap;
  
  ColorsBox({
    required this.colors,
    required this.selected,
    required this.onTap
  }) : assert(colors.length == 3);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: (selected) ? Border.all(color: Theme.of(context).accentColor, width: 3) : null,
          borderRadius: BorderRadius.circular(10)
        ),
        padding: const EdgeInsets.all(2),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: HEIGHT,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(RADIUS), bottomLeft: Radius.circular(RADIUS)),
                  color: colors[0]
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: HEIGHT,
                decoration: BoxDecoration(
                  color: colors[1]
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: HEIGHT,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(RADIUS), bottomRight: Radius.circular(RADIUS)),
                  color: colors[2]
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}