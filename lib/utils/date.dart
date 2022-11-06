import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:super_widgets/super_widgets.dart';

class Date {
  /// Creates a date only.
  /// The [year] [month] [day].
  Date(int year, [int month = 1, int day = 1]) {
    _year = year;
    _month = month;
    _day = day;
  }

  Date.withFields({required int year, int? month, int? day});

  /// Creates a time of day based on the given time.
  ///
  /// The [year] is set to the time's hour and the [month] is set to the time's
  /// minute in the timezone of the given [DateTime].
  Date.fromDateTime(DateTime time)
      : _year = time.year,
        _month = time.month,
        _day = time.day;

  DateTime toDateTime() => DateTime(year, month, day);

  static DateFormat defaultDateFormat = DateFormat('dd-MM-yyyy');

  /// Creates a time of day based on the current time.
  ///
  /// The [year] is set to the current hour and the [month] is set to the
  /// current minute in the local time zone.
  factory Date.now() => Date.fromDateTime(DateTime.now());

  static const int monthsPerYear = 12;
  static const int maxDaysPerMonth = 31;

  static Date parse(String formattedString, {DateFormat? dateFormat}) {
    dateFormat ??= Date.defaultDateFormat;
    return Date.fromDateTime(dateFormat.parse(formattedString));
  }

  /// Constructs a new [DateTime] instance based on [formattedString].
  ///
  /// Works like [parse] except that this function returns `null`
  /// where [parse] would throw a [FormatException].
  static Date? tryParse(String formattedString) {
    // TODO: Optimize to avoid throwing.
    try {
      return parse(formattedString);
    } on FormatException {
      return null;
    }
  }

  /// Returns a new TimeOfDay with the hour and/or minute replaced.
  Date copyWith({int? year, int? month, int? day}) {
    assert(month == null || (month >= 0 && month < monthsPerYear));
    assert(day == null || (day >= 0 && day < maxDaysPerMonth));
    return Date(year ?? this.year, month ?? this.month, day ?? this.day);
  }

  /// The selected year.
  int _year = 0;

  /// The selected month.
  int? _month;

  /// The selected month.
  int? _day;

  int get year => _year;

  int get month => _month ?? 1;

  int get day => _day ?? 1;

  external int get millisecondsSinceEpoch;

  /// The number of microseconds since
  /// the "Unix epoch" 1970-01-01T00:00:00Z (UTC).
  ///
  /// This value is independent of the time zone.
  ///
  /// This value is at most
  /// 8,640,000,000,000,000,000us (100,000,000 days) from the Unix epoch.
  /// In other words: `microsecondsSinceEpoch.abs() <= 8640000000000000000`.
  ///
  /// Note that this value does not fit into 53 bits (the size of a IEEE double).
  /// A JavaScript number is not able to hold this value.
  external int get microsecondsSinceEpoch;

  /// The time zone name.
  ///
  /// This value is provided by the operating system and may be an
  /// abbreviation or a full name.
  ///
  /// In the browser or on Unix-like systems commonly returns abbreviations,
  /// such as "CET" or "CEST". On Windows returns the full name, for example
  /// "Pacific Standard Time".
  external String get timeZoneName;

  /// The time zone offset, which
  /// is the difference between local time and UTC.
  ///
  /// The offset is positive for time zones east of UTC.
  ///
  /// Note, that JavaScript, Python and C return the difference between UTC and
  /// local time. Java, C# and Ruby return the difference between local time and
  /// UTC.
  ///
  /// For example, using local time in San Francisco, United States:
  /// ```dart
  /// final dateUS = DateTime.parse('2021-11-01 20:18:04Z').toLocal();
  /// print(dateUS); // 2021-11-01 13:18:04.000
  /// print(dateUS.timeZoneName); // PDT ( Pacific Daylight Time )
  /// print(dateUS.timeZoneOffset.inHours); // -7
  /// print(dateUS.timeZoneOffset.inMinutes); // -420
  /// ```
  ///
  /// For example, using local time in Canberra, Australia:
  /// ```dart
  /// final dateAus = DateTime.parse('2021-11-01 20:18:04Z').toLocal();
  /// print(dateAus); // 2021-11-02 07:18:04.000
  /// print(dateAus.timeZoneName); // AEDT ( Australian Eastern Daylight Time )
  /// print(dateAus.timeZoneOffset.inHours); // 11
  /// print(dateAus.timeZoneOffset.inMinutes); // 660
  /// ```
  external Duration get timeZoneOffset;

  /// The day of the week [monday]..[sunday].
  ///
  /// In accordance with ISO 8601
  /// a week starts with Monday, which has the value 1.
  ///
  /// ```dart
  /// final moonLanding = DateTime.parse('1969-07-20 20:18:04Z');
  /// print(moonLanding.weekday); // 7
  /// assert(moonLanding.weekday == DateTime.sunday);
  /// ```
  external int get weekday;

  /// Returns the localized string representation of this time of day.
  ///
  /// This is a shortcut for [MaterialLocalizations.formatTimeOfDay].
  String format({DateFormat? dateFormat}) {
    dateFormat ??= Date.defaultDateFormat;
    return dateFormat.format(toDateTime());
  }

  @override
  bool operator ==(Object other) {
    return other is Date && other.year == year && other.month == month && other.day == day;
  }

  Date operator +(dynamic other) {
    if (other is Date) {
      return Date(year + other.year, max(1, (month) + (other.month)), max(1, (day) + (other.day)));
    } else if (other is DateTime) {
      return Date(year + other.year, max(1, (month) + (other.month)), max(1, (day) + (other.day)));
    } else if (other is Duration) {
      return Date(year, month, max(1, (day) + (other.inDays)));
    } else if (other is num) {
      return Date(year, month, max(1, (day) + (other.toInt())));
    }
    return this;
  }

  Date operator -(dynamic other) {
    if (other is Date) {
      return Date(year - other.year, max(1, (month) - (other.month)), max(1, (day) - (other.day)));
    } else if (other is DateTime) {
      return Date(year - other.year, max(1, (month) - (other.month)), max(1, (day) - (other.day)));
    } else if (other is Duration) {
      return Date(year, month, min(1, (day) - (other.inDays)));
    } else if (other is num) {
      return Date(year, month, min(1, (day) - (other.toInt())));
    }
    return this;
  }

  @override
  int get hashCode => Object.hash(year, month, day);

  @override
  String toString() => format();
}

// extension DateExtension on Date {
//   static final DateFormat _monthFormat = DateFormat('MMMM yyyy');
//   static final DateFormat _dayFormat = DateFormat('dd');
//   static final DateFormat _firstDayFormat = DateFormat('MMM dd');
//   static final DateFormat _fullDayFormat = DateFormat('EEE MMM dd, yyyy');
//   static final DateFormat _apiDayFormat = DateFormat('yyyy-MM-dd');
//
//   String get formatMonth => _monthFormat.format(toDateTime());
//
//   String get formatDay => _dayFormat.format(toDateTime());
//
//   String get formatFirstDay => _firstDayFormat.format(toDateTime());
//
//   String get fullDayFormat => _fullDayFormat.format(toDateTime());
//
//   String get apiDayFormat => _apiDayFormat.format(toDateTime());
//
//   /// The list of days in a given month
//   List<Date> daysInMonth() {
//     var first = firstDayOfMonth;
//     var daysBefore = first
//         .toDateTime()
//         .weekday;
//     var firstToDisplay = first-daysBefore;
//     var last = lastDayOfMonth;
//
//     int daysAfter = 7 - last.toDateTime().weekday;
//
//     // If the last day is sunday (7) the entire week must be rendered
//     if (daysAfter == 0) {
//       daysAfter = 7;
//     }
//
//     var lastToDisplay = last+daysAfter;
//     return daysInRange(firstToDisplay, lastToDisplay).toList();
//   }
//
//   bool isFirstDayOfMonth(Date day) {
//     return isSameDay(firstDayOfMonth(day), day);
//   }
//
//   bool get isLastDayOfMonth {
//     return isSameDay(lastDayOfMonth, day);
//   }
//
//   Date get firstDayOfMonth {
//     return Date(year, month);
//   }
//
//   Date get firstDayOfWeek {
//     /// Handle Daylight Savings by setting hour to 12:00 Noon
//     /// rather than the default of Midnight
//     day = Date(day.year, day.month, day.day, 12);
//
//     /// Weekday is on a 1-7 scale Monday - Sunday,
//     /// This Calendar works from Sunday - Monday
//     var decreaseNum = weekday % 7;
//     return day.subtract(Duration(days: decreaseNum));
//   }
//
//   Date lastDayOfWeek(Date day) {
//     /// Handle Daylight Savings by setting hour to 12:00 Noon
//     /// rather than the default of Midnight
//     day = Date.utc(day.year, day.month, day.day, 12);
//
//     /// Weekday is on a 1-7 scale Monday - Sunday,
//     /// This Calendar's Week starts on Sunday
//     var increaseNum = day.weekday % 7;
//     return day.add(Duration(days: 7 - increaseNum));
//   }
//
//   /// The last day of a given month
//   Date get lastDayOfMonth {
//     var beginningNextMonth = (month < 12) ? Date(year, month + 1, 1) : Date(year + 1, 1, 1);
//     return beginningNextMonth.subtract(const Duration(days: 1));
//   }
//
//   bool get isBefore(Date b)=>year<b.year || month<b.month|| year<b.year;
//
//   /// Returns a [Date] for each day the given range.
//   ///
//   /// [start] inclusive
//   /// [end] exclusive
//   Iterable<Date> get daysInRange(Date start, Date end) sync* {
//     var i = start;
//     var offset = start.timeZoneOffset;
//     while (i.isBefore(end)) {
//       yield i;
//       i = i.add(const Duration(days: 1));
//       var timeZoneDiff = i.timeZoneOffset - offset;
//       if (timeZoneDiff.inSeconds != 0) {
//         offset = i.timeZoneOffset;
//         i = i.subtract(Duration(seconds: timeZoneDiff.inSeconds));
//       }
//     }
//   }
//
//   /// Whether or not two times are on the same day.
//   bool isSameDay( Date b) {
//     return year == b.year && month == b.month && day == b.day;
//   }
//
//   bool isSameWeek( Date b) {
//     /// Handle Daylight Savings by setting hour to 12:00 Noon
//     /// rather than the default of Midnight
//     b = Date(b.year, b.month, b.day);
//
//     var diff = (this-b).toDateTime()
//         .inDays;
//     if (diff.abs() >= 7) {
//       return false;
//     }
//
//     var min = a.isBefore(b) ? a : b;
//     var max = a.isBefore(b) ? b : a;
//     var result = max.weekday % 7 - min.weekday % 7 >= 0;
//     return result;
//   }
//
//   Date previousMonth(Date m) {
//     var year = m.year;
//     var month = m.month;
//     if (month == 1) {
//       year--;
//       month = 12;
//     } else {
//       month--;
//     }
//     return Date(year, month);
//   }
//
//   Date nextMonth(Date m) {
//     var year = m.year;
//     var month = m.month;
//
//     if (month == 12) {
//       year++;
//       month = 1;
//     } else {
//       month++;
//     }
//     return Date(year, month);
//   }
//
//   Date previousWeek(Date w) {
//     return w.subtract(Duration(days: 7));
//   }
//
//   Date nextWeek(Date w) {
//     return w.add(Duration(days: 7));
//   }
// }

void main() {
  Date mDate = Date.now();
  mPrint(mDate);
  mPrint(mDate.millisecondsSinceEpoch);
  mPrint(mDate.format());
}
