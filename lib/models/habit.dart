import 'dart:convert';

import 'package:project_habits/db/habits_table.dart';

class Habit {
  late final int id;
  late String text;
  late String emoji;
  late final List<int> period;
  late final DateTime? startPeriod;

  Habit({
    required this.text,
    required this.emoji,
    required this.period,
    this.startPeriod
  });

  Habit.fromDb(Map<String, dynamic> map) {
    id = map[HabitsTable.id];
    text = map[HabitsTable.text];
    emoji = map[HabitsTable.emoji];
    period = (jsonDecode(map[HabitsTable.period]) as List<dynamic>).map((e) => e as int).toList();
    if(map[HabitsTable.startPeriod] != null) {
      startPeriod = DateTime.fromMillisecondsSinceEpoch(map[HabitsTable.startPeriod]);
    } else {
      startPeriod = null;
    }
  }

  Map<String, dynamic> toDb() {
    return {
      HabitsTable.text: text,
      HabitsTable.emoji: emoji,
      HabitsTable.period: jsonEncode(period),
      HabitsTable.startPeriod: startPeriod?.millisecondsSinceEpoch
    };
  }
}