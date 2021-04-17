import 'package:flutter/material.dart';
import 'package:project_habits/pages/home_page/home_page_controller.dart';
import 'package:project_habits/utils/consts.dart';
import 'package:provider/provider.dart';

class DayBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomePageController>(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).primaryColor
      ),
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.center,
      child: StreamBuilder<int>(
        stream: controller.selectedDayindex.stream,
        initialData: controller.selectedDayindex.value,
        builder: (ctx, snapshot) {
          final selectedDay = DateTime(
            controller.selectedMonth.value.year, controller.selectedMonth.value.month, snapshot.data! + 1
          );
              
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            switchInCurve: Curves.elasticOut,
            switchOutCurve: Curves.easeInExpo,
            transitionBuilder: (child, animation) {
              return SlideTransition(
                position: Tween<Offset>(begin: Offset(0, 2), end: Offset(0, 0)).animate(animation),
                child: child,
              );
            },
            child: RichText(
              key: ValueKey<DateTime>(selectedDay),
              textAlign: TextAlign.center,
              text: TextSpan(
                text: selectedDay.day.toString().padLeft(2, "0") + "\n",
                style: Theme.of(context).textTheme.headline1,
                children: [
                  TextSpan(
                    text: DAY_NAMES[selectedDay.weekday - 1].substring(0, 3),
                    style: Theme.of(context).textTheme.headline4
                  )
                ]
              )
            ),
          );
        }
      ),
    );
  }
}