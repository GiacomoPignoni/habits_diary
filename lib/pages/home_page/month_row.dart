import 'package:flutter/material.dart';
import 'package:project_habits/pages/home_page/home_page_controller.dart';
import 'package:project_habits/utils/consts.dart';
import 'package:provider/provider.dart';

class MonthRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomePageController>(context);
    final now = DateTime.now();

    return StreamBuilder<DateTime>(
      stream: controller.selectedMonth.stream,
      initialData: controller.selectedMonth.value,
      builder: (context, snapshot) {
        final selectedMonth = snapshot.data!;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.12,
              child: GestureDetector(
                onTap: () => controller.previousMonth(),
                child: Icon(
                  Icons.chevron_left_rounded,
                  color: Theme.of(context).primaryColorDark,
                )
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.35,
              child: Text(
                MONTH_NAMES[selectedMonth.month - 1],
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline2
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.12,
              child: (selectedMonth.year == now.year && selectedMonth.month == now.month) 
              ? SizedBox.shrink()
              : GestureDetector(
                onTap: () => controller.nextMonth(),
                child: Icon(
                  Icons.chevron_right_rounded,
                  color: Theme.of(context).primaryColorDark
                )
              ) ,
            )
          ],
        );
      }
    );
  }
}