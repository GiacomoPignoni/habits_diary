import 'package:get_it/get_it.dart';
import 'package:project_habits/models/day.dart';
import 'package:project_habits/services/data_service.dart';
import 'package:project_habits/utils/stream_data.dart';

class FullYearPageController {
  DataService _dataService = GetIt.I.get<DataService>();

  StreamData<bool> loading = StreamData(initialValue: true, broadcast: true);

  Map<String, Day>? days;

  FullYearPageController() {
    _dataService.getDaysFromYear(DateTime.now().year).then((days) {
      this.days = days;
      loading.add(false);
    });
  }

  Day? getDay(DateTime date) {
    if(days != null) {
      return days!["${date.year}${date.month.toString().padLeft(2, "0")}${date.day}"];
    }

    return null;
  }

  int countHabitsDone(Day day) {
    return day.habits.keys.where((key) => day.habits[key] ?? false).length;
  }

  void dispose() {
    loading.close();
  }
}