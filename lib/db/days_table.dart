class DaysTable {
  static const String tableName = "Days";

  static const String date = "date";

  static const String createQuery = """
    CREATE TABLE $tableName (
      $date integer primary key not null
    )
  """;
}