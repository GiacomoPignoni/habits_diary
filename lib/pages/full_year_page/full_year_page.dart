import 'package:flutter/material.dart';
import 'package:project_habits/pages/full_year_page/full_year_page_controller.dart';
import 'package:project_habits/utils/consts.dart';
import 'package:provider/provider.dart';

class FullYearPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return Provider(
      create: (ctx) => FullYearPageController(),
      dispose: (ctx, FullYearPageController controller) => controller.dispose(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            now.year.toString(),
            style: Theme.of(context).textTheme.headline1
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  shrinkWrap: true,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MiniCalendar(now.year, 1),
                        MiniCalendar(now.year, 2)
                      ],
                    ),
                    Divider(color: Colors.transparent),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MiniCalendar(now.year, 3),
                        MiniCalendar(now.year, 4)
                      ],
                    ),
                    Divider(color: Colors.transparent),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MiniCalendar(now.year, 5),
                        MiniCalendar(now.year, 6)
                      ],
                    ),
                    Divider(color: Colors.transparent),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MiniCalendar(now.year, 7),
                        MiniCalendar(now.year, 8)
                      ],
                    ),
                    Divider(color: Colors.transparent),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MiniCalendar(now.year, 9),
                        MiniCalendar(now.year, 10)
                      ],
                    ),
                    Divider(color: Colors.transparent),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MiniCalendar(now.year, 11),
                        MiniCalendar(now.year, 12)
                      ],
                    ),
                  ],
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}

class MiniCalendar extends StatelessWidget {
  final int month;
  final int year;

  MiniCalendar(this.year, this.month);

  @override
  Widget build(BuildContext context) {
    final whiteSpaces = DateTime(year, month).weekday - 1;
    final days = DateUtils.getDaysInMonth(year, month) + whiteSpaces;
    final controller = Provider.of<FullYearPageController>(context);

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            MONTH_NAMES[month - 1].substring(0, 3),
            style: Theme.of(context).textTheme.subtitle2,
          ),
          StreamBuilder<bool>(
            stream: controller.loading.stream,
            initialData: controller.loading.value,
            builder: (context, snapshot) {
              return GridView.count(
                crossAxisCount: 7,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(10),
                children: List.generate(days, (index) {
                  if(index < whiteSpaces) {
                    return SizedBox.shrink();
                  }

                  final day = (snapshot.data! == false) 
                  ? controller.getDay(DateTime(year, month, index - whiteSpaces + 1))
                  : null;

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    decoration: BoxDecoration(
                      color: (day != null)
                      ? Color.lerp(Theme.of(context).shadowColor, Theme.of(context).primaryColor, controller.countHabitsDone(day) / day.habits.length)
                      : Theme.of(context).shadowColor,
                      borderRadius: BorderRadius.circular(5)
                    )
                  );
                }),
              );
            }
          ),
        ]
      ),
    );
  }
}