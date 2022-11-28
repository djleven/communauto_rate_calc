import 'package:date_format/date_format.dart';

class TripParameters {
  late DateTime startDate;
  late DateTime endDate;
  int selectedCity;
  int distance;
  bool excludePromos;

  TripParameters(
      {DateTime? startDate,
      DateTime? endDate,
      this.selectedCity = 59,
      this.distance = 0,
      this.excludePromos = true}) {
    this.startDate =
        DateTimeUtils.nearestQuarterHourDateTime(startDate ?? DateTime.now());

    this.endDate = endDate != null
        ? DateTimeUtils.nearestQuarterHourDateTime(endDate)
        : this.startDate;
  }
}

class DateTimeUtils {
  static DateTime nearestQuarterHourDateTime(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day, dateTime.hour,
        [15, 30, 45, 60][(dateTime.minute / 15).floor()]);
  }

  static String getDateTimeLabel(DateTime dateTime) {
    return formatDate(
            dateTime, [yyyy, "-", mm, "-", dd, " ", hh, ':', nn, " ", am])
        .toString();
  }

  static DateTime addMonthToDateTime(DateTime dateTime) {
    return DateTime(
        dateTime.year, dateTime.month + 1, dateTime.day, dateTime.hour);
  }

  static DateTime addYearToDateTime(DateTime dateTime) {
    return DateTime(
        dateTime.year + 1, dateTime.month, dateTime.day, dateTime.hour);
  }
}
