class HabitsTable {
  static const String tableName = "Habits";

  static const String id = "id";
  static const String text = "text";
  static const String emoji = "emoji";
  static const String period = "period";
  static const String startPeriod = "startPeriod";

  static const String createQuery = """
    CREATE TABLE $tableName (
      $id integer primary key autoincrement,
      $text text not null,
      $emoji text not null,
      $period text not null,
      $startPeriod integer
    )
  """;
}