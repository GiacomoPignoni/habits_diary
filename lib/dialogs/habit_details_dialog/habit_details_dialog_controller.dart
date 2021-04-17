import 'package:get_it/get_it.dart';
import 'package:project_habits/models/habit.dart';
import 'package:project_habits/services/data_service.dart';

class HabitDetailsDialogController {
  DataService _dataService = GetIt.I.get<DataService>();

  late Habit habit;

  HabitDetailsDialogController(int habitId) {
    habit =  _dataService.habits.value[habitId]!;
  }

  void newEmoji(String newEmoji) {
    habit.emoji = newEmoji;
    _dataService.updateHabit(habit);
  }

  void newName(String newName) {
    habit.text = newName;
    _dataService.updateHabit(habit);
  }

  String getStartPeriodString() {
    if(habit.startPeriod == null) {
      return "none";
    } 

    return "${habit.startPeriod!.year}-${habit.startPeriod!.month.toString().padLeft(2, "0")}-${habit.startPeriod!.day.toString().padLeft(2, "0")}";
  }
}