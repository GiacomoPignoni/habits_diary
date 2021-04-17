import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get_it/get_it.dart';
import 'package:project_habits/dialogs/confirmation_dialog/confirmation_dialog.dart';
import 'package:project_habits/dialogs/habit_details_dialog/habit_details_dialog.dart';
import 'package:project_habits/models/habit.dart';
import 'package:project_habits/services/data_service.dart';
import 'package:project_habits/utils/consts.dart';
import 'package:project_habits/utils/stream_data.dart';

class HabitsDialogController {
  final DataService _dataService = GetIt.I.get<DataService>();

  StreamData<Map<int, Habit>> get habits => _dataService.habits;

  String getDaysString(Habit habit) {
    if(habit.period.length == 7) {
      return "All week days";
    } else if(habit.period.length == 2 && habit.period.reduce((a, b) => a + b) == 13) {
      return "Weekend";
    } else if(habit.period.length == 5 && habit.period.reduce((a, b) => a + b) == 15) {
      return "Work week";
    }
    return habit.period.map((e) => DAY_NAMES[e - 1].substring(0, 3)).join(', ');
  }

  String getStartPeriodString(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, "0")}-${date.day.toString().padLeft(2, "0")}";
  }

  void deleteHabit(int id) {
    _dataService.deleteHabit(id);
  }

  void showHabitDetailsDialog(BuildContext context, int id) {
    HabitDetailsDialog.show(context, id);
  }

  void showDeleteHabitConfirmation(BuildContext context, int id, SlidableController slidableController) {
    ConfirmationDialog.show(context, 
      text: "Are you sure you want to delete this habit?",
      onYes: () => deleteHabit(id),
      onNo: () => slidableController.activeState?.close()
    );
  }

  void dispose() {
    //
  }
}