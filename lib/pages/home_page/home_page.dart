import 'package:flutter/material.dart';
import 'package:project_habits/pages/home_page/calendar.dart';
import 'package:project_habits/pages/home_page/day_box.dart';
import 'package:project_habits/pages/home_page/habits_day_list.dart';
import 'package:project_habits/pages/home_page/home_page_controller.dart';
import 'package:project_habits/pages/home_page/month_row.dart';
import 'package:project_habits/pages/home_page/top_bar.dart';
import 'package:project_habits/widgets/circular_button.dart';
import 'package:provider/provider.dart';

import 'day_box.dart';
import 'habits_day_list.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (ctx) => HomePageController(),
      dispose: (ctx, HomePageController controller) => controller.dispose(),
      builder: (ctx, child) => Consumer<HomePageController>(
        builder: (ctx, controller, child) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TopBar(),
                  MonthRow(),
                  SizedBox(
                    child: Calendar()
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 35, right: 35, left: 35, bottom: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).primaryColorLight
                              ),
                              padding: const EdgeInsets.only(top: 35),
                              child: HabitsDayList(),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 0,
                            width: 70,
                            height: 70,
                            child: DayBox()
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            width: 70,
                            height: 70,
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).primaryColor
                              ),
                              child: CircularButton(
                                onPressed: () => controller.showHabitsDialog(context),
                                icon: Icon(Icons.list),
                              )
                            )
                          )
                        ],
                      ),
                    )
                  )
                ],
              )
            )
          );
        }
      ),
    );
  }
}