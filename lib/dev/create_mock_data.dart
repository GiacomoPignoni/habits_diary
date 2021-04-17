import 'package:project_habits/db/habits_table.dart';
import 'package:sqflite/sqflite.dart';

Future<void> createMockData(Database db) async {
  db.insert(
    HabitsTable.tableName, 
    {
      "text": "Run",
      "emoji": "🏃🏻",
      "period": "[2, 4]"
    }
  );
  db.insert(
    HabitsTable.tableName, 
    {
      "text": "Read",
      "emoji": "📖",
      "period": "[1, 2, 3, 4, 5, 6, 7]"
    }
  );
  db.insert(
    HabitsTable.tableName, 
    {
      "text": "Study",
      "emoji": "📚",
      "period": "[1, 3, 4, 5]"
    }
  );
}