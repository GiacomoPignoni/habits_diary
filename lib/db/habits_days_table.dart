import 'package:project_habits/db/days_table.dart';
import 'package:project_habits/db/habits_table.dart';

class HabitsDaysTable {
  static const String tableName = "HabitsDays";

  static const String id = "id";
  static const String habitId = "habitId";
  static const String dayId = "dayId";
  static const String done = "done";

  static const String createQuery = """
    CREATE TABLE $tableName (
	    $id integer PRIMARY key AUTOINCREMENT,
  	  $habitId integer not null,
      $dayId integer not null,
      $done integer not null default(0),
  	  FOREIGN Key($habitId) REFERENCES ${HabitsTable.tableName}(${HabitsTable.id}),
      FOREIGN Key($dayId) REFERENCES ${DaysTable.tableName}(${DaysTable.date})
    )
  """;
}