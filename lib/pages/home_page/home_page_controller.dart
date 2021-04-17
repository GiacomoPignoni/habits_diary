import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:project_habits/pages/full_year_page/full_year_page.dart';
import 'package:project_habits/dialogs/habits_dialogs/habits_dialog.dart';
import 'package:project_habits/models/day.dart';
import 'package:project_habits/models/habit.dart';
import 'package:project_habits/services/data_service.dart';
import 'package:project_habits/utils/stream_data.dart';

class HomePageController {
  final DataService _dataService = GetIt.I.get<DataService>();

  late Map<int, Habit> habits;
  late List<Day> days;

  final StreamData<DateTime> selectedMonth = StreamData(initialValue: DateTime(DateTime.now().year, DateTime.now().month), broadcast: true);
  final StreamData<int> selectedDayindex = StreamData(initialValue: DateTime.now().day - 1, broadcast: true);

  HomePageController() {
    final now = DateTime.now();
    _loadNewDays(now.year, now.month);
    habits = _dataService.habits.value;
  }

  void selectNewDay(int newDayIndex) {
    selectedDayindex.add(newDayIndex);
  }

  void nextMonth() {
    final nextMonth = DateUtils.addMonthsToMonthDate(selectedMonth.value, 1);
    _loadNewDays(nextMonth.year, nextMonth.month);
    selectedMonth.add(nextMonth);
    selectedDayindex.add(0);
  }

  void previousMonth() {
    final prevMonth = DateUtils.addMonthsToMonthDate(selectedMonth.value, -1);
    _loadNewDays(prevMonth.year, prevMonth.month);
    selectedMonth.add(prevMonth);
    selectedDayindex.add(0);
  }

  void updateHabitCheck(int dayIndex, int habitId, bool newValue) {
    days[dayIndex].habits[habitId] = newValue;
    selectedMonth.emptyCall();
    _dataService.updateHabitDone(days[dayIndex].date, habitId, newValue);
  }

  int countHabitsDone(int index) {
    if(days.length > index) {
      return days[index].habits.keys.where((key) => days[index].habits[key] ?? false).length;
    }
    return 0;
  }

  int countAllHabits(int index) {
    if(days.length > index) {
      return days[index].habits.length;
    }
    return 1;
  }

  void onSwipeCalendar(DragEndDetails details) {
    if(details.primaryVelocity! == 0) {
      return;
    }

    if(details.primaryVelocity!.isNegative) {
      final now = DateTime.now();
      if(!(selectedMonth.value.year == now.year && selectedMonth.value.month == now.month)) {
        nextMonth();
      }
    } else {
      previousMonth();
    }
  }

  void showHabitsDialog(BuildContext context) {
    HabitsDialog.show(context).then((value) {
      habits = _dataService.habits.value;
      _loadNewDays(selectedMonth.value.year, selectedMonth.value.month);
      selectedMonth.emptyCall();
      selectedDayindex.emptyCall();
    });
  }

  void showFullYearDialog(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => FullYearPage()));
  } 

  void _loadNewDays(int year, int month) {
    this.days = _dataService.getDays(year, month);
  }

  void dispose() {
    selectedMonth.close();
    selectedDayindex.close();
  }
}