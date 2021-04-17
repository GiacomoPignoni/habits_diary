import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project_habits/db/habits_db.dart';
import 'package:project_habits/models/day.dart';
import 'package:project_habits/models/habit.dart';
import 'package:project_habits/utils/stream_data.dart';
import 'package:sqflite/sqflite.dart';

class DataService {
  late final Database db;

  // Mapped by Year + Month
  late final Map<int, List<Day>> _daysCache = Map();

  late final StreamData<Map<int, Habit>> habits;

  // PUBLIC METHODS

  Future<void> init() async {
    db = await HabitsDb.connectToDb();
    habits = StreamData(initialValue: await _getAllHabits(), broadcast: true);
    
    // Load in cache the last three months
    var date = DateTime.now();
    for(int i = 0; i < 3; i++) {
      date = DateUtils.addMonthsToMonthDate(date, -1 * i);
      final days = await _getDays(date.year, date.month);
      _addDaysToCache(days, date: date);
    }
  }

  List<Day> getDays(int year, int month) {
    _checkSavedInCache(year, month);
    return _getDaysFromCache(year, month);
  }

  Future<Map<String, Day>> getDaysFromYear(int year) async {
    Map<String, Day> toReturn = {};
    final now = DateTime.now();

    for(int i = 1; i <= 12; i++) {
      var days = _getDaysFromCache(year, i);
      if(days.length == 0 && DateUtils.monthDelta(now, DateTime(year, i)) <= 0) {
        days = await _getDays(year, i);
        _addDaysToCache(days);
      }
      for(final day in days) {
        toReturn["${day.date.year}${day.date.month.toString().padLeft(2, "0")}${day.date.day}"] = day;
      }
    }

    return toReturn;
  }

  Future<void> updateHabitDone(DateTime dayDate, int habitId, bool newValue) {
    return HabitsDb.updateHabitDayDone(db, dayDate, habitId, newValue);
  }

  Future<void> addHabit(Habit newHabit) async {
    final newHabitId = await HabitsDb.createHabit(db, newHabit);
    final days = (await HabitsDb.getAllDays(db)).map((e) => Day.fromDb(e, []));

    for(final day in days) {
      if(newHabit.startPeriod != null && newHabit.startPeriod!.compareTo(day.date) > 0) {
        continue;
      }

      if(newHabit.period.contains(day.date.weekday)) {
        await HabitsDb.createHabitDay(db, day.date.millisecondsSinceEpoch, newHabitId);
      }
    }

    await _reloadDaysInCache();
    _loadHabits();
  }

  Future<void> deleteHabit(int id) async {
    await HabitsDb.deleteHabitsDays(db, id);
    await HabitsDb.deleteHabit(db, id);
    await _reloadDaysInCache();
    _loadHabits();
  }

  Future<void> updateHabit(Habit habit) async {
    await HabitsDb.updateHabit(db, habit);
    _loadHabits();
  }

  // PRIVATE METHODS

  Future<List<Day>> _getDays(int year, int month) async {
    final List<Day> days = [];
    var daysMap = await HabitsDb.getDaysByMonth(db, year: year, month: month);
    if(daysMap.length < DateUtils.getDaysInMonth(year, month)) {
      await _createDays(year, month);
      daysMap = await HabitsDb.getDaysByMonth(db, year: year, month: month);
    }
    for(final dayMap in daysMap) {
      final habitsDaysMaps = await HabitsDb.getHabitsDaysByDay(db, day: dayMap);
      days.add(Day.fromDb(dayMap, habitsDaysMaps));
    }
    return days;
  }

  Future<Map<int, Habit>> _getAllHabits() async {
    final habits = await _getAllHabitsFromDb();
    final map = Map<int, Habit>();
    for(final habit in habits) {
      map[habit.id] = habit;
    }
    return map;
  }

  Future<List<Habit>> _getAllHabitsFromDb() async {
    final habitsMap = await HabitsDb.getAllHabits(db);
    final habitsList = habitsMap.map((e) => Habit.fromDb(e)).toList();
    return habitsList;
  }

  Future<void> _createDays(int year, int month) async {
    final allHabits = await _getAllHabitsFromDb();
    final daysInMonth = DateUtils.getDaysInMonth(year, month);

    for(int i = 0; i < daysInMonth; i++) {
      final date = DateTime(year, month, i + 1);
      final dayId = await HabitsDb.createDay(db, date: date);
      for(final habit in allHabits) {
        if(habit.startPeriod != null && habit.startPeriod!.compareTo(date) > 0) {
          continue;
        }

        if(habit.period.contains(date.weekday)) {
          await HabitsDb.createHabitDay(db, dayId, habit.id);
        }
      }
    }
  }

  Future<void> _loadHabits() async {
    habits.add(await _getAllHabits());
  }

  // CACHE METHODS
  
  Future<void> _reloadDaysInCache() async {
    _daysCache.forEach((key, value) async {
      _daysCache[key] = await _getDays(value[0].date.year, value[0].date.month);
    });
  }

  Future<void> _checkSavedInCache(int year, int month) async {
    var date = DateTime(year, month);
    for(int i = 1; i <= 2; i++) {
      date = DateUtils.addMonthsToMonthDate(date, -1 * i);
      if(_daysCache.containsKey(_getDayCacheKey(date.year, date.month)) == false) {
        final days = await _getDays(date.year, date.month);
        _addDaysToCache(days, date: date);
      }
    }
  }

  void _addDaysToCache(List<Day> days, { DateTime? date }) {
    if(date == null) {
      date = days[0].date;
    }
    _daysCache[_getDayCacheKey(date.year, date.month)] = days;
  }

  List<Day> _getDaysFromCache(int year, int month) {
    final key = _getDayCacheKey(year, month);
    if(_daysCache.containsKey(key)) {
      return _daysCache[key]!;
    }
    return [];
  }

  int _getDayCacheKey(int year, int month) {
    return year + month;
  }
}