class TimeService {
  DateTime parse(String dateString) {
    try {
      return DateTime.tryParse(dateString) ?? DateTime(-1);
    } on Exception {
      return DateTime(-1);
    }
  }

  String format(DateTime date) {
    return date.toIso8601String();
  }

  DateTime addYears(DateTime date, int years) {
    return DateTime(date.year + years, date.month, date.day);
  }
}
