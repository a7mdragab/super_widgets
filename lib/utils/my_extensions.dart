import 'package:dart_extensions/dart_extensions.dart';
import 'package:flutter/material.dart' as matLib;
import 'package:flutter/material.dart';

import 'package:intl/intl.dart' as intl;
import 'package:intl/intl.dart';
import 'package:ready_extensions/ready_extensions.dart';
import 'package:time/time.dart';
import 'dart:convert';

/// region Dates Formats
///
/// Specify a defaultDateFormat (Optional) default (dd-MM-yyyy)
DateFormat defaultDateFormat = intl.DateFormat('dd-MM-yyyy');

/// Specify a defaultTimeFormat (Optional) default (hh:mm a)
DateFormat defaultTimeFormat = intl.DateFormat('hh:mm a');

/// Specify a defaultDateTimeFormat (Optional) default (dd-MM-yyyy - hh:mm a)
DateFormat defaultDateTimeFormat = intl.DateFormat('$defaultDateFormat - $defaultTimeFormat');

DateTime toDateTime(TimeOfDay x) {
  return DateTime(2020, 1, 1, x.hour, x.minute);
}

TimeOfDay toTimeOfDay(DateTime x) {
  return TimeOfDay.fromDateTime(x);
}

DateTime? tryParseDateTime(String x) {
  try {
    return int.tryParse(x) != null ? DateTime.fromMillisecondsSinceEpoch(int.parse(x)) : defaultDateTimeFormat.parse(x);
  } catch (e) {
    return DateTime.tryParse(x);
  }
}

DateTime? tryParseDate(String x) {
  try {
    return defaultDateFormat.parse(x);
  } catch (e) {
    return tryParseDateTime(x);
  }
}

TimeOfDay? tryParseTime(String x) {
  DateTime? d;
  try {
    d = defaultTimeFormat.parse(x);
  } catch (e) {
    d = tryParseDateTime(x);
  }
  return d == null ? null : TimeOfDay.fromDateTime(d);
}

/// endregion

extension DateTimeExtension on DateTime {
  String toTimeStr([String local = 'en']) {
    // context.printInfo(info: 'toTimeStr: In: ' + this.toString());
    var format = intl.DateFormat('hh:mm a', local);
    var date = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    // context.printInfo(info: 'toTimeStr: Out: ' + format.format(date));
    return format.format(date);
  }

  String toTimeStrQuery() {
    var format = intl.DateFormat('hh:mm:ss', 'en');
    var date = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    return format.format(date);
  }

  String toFullDateTimeStr() {
    var format = intl.DateFormat('y-M-d - hh:mm a', 'en');
    // var format = INTL.DateFormat(
    //     LanguageService.to.isArabic ? 'd-M-y - hh:mm a' : 'y-M-d - hh:mm a',
    //     LanguageService.to.currentLanguage);
    var date = DateTime.now();
    date = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    return format.format(date);
  }

  String toFullDateTimeStrQuery() {
    var format = intl.DateFormat('y-M-d hh:mm:ss', 'en');
    // var format = INTL.DateFormat(
    //     LanguageService.to.isArabic ? 'd-M-y - hh:mm a' : 'y-M-d - hh:mm a',
    //     LanguageService.to.currentLanguage);
    var date = DateTime.now();
    date = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    return format.format(date);
  }

  String toDateStr([String formatStr = 'dd-MM-yyyy']) {
    var format = intl.DateFormat(formatStr);
    var date = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    return format.format(date);
  }

  DateTime updateWithDateTimeValues(String? date, String? time) {
    // print('date = $date & time = $time');
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    if (date != null) {
      dateTime = DateFormat("dd-MMMM-yyyy").parse(date);
      if (time != null) {
        TimeOfDay t = TimeOfDay.fromDateTime(DateFormat("hh:mm a").parse(time));
        dateTime = dateTime.copyWith(hour: t.hour, minute: t.minute);
      }
    }
    return dateTime;
  }

  DateTime updateWithTimeValues(TimeOfDay? time) {
    // print('date = $date & time = $time');
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    if (time != null) {
      dateTime = dateTime.copyWith(hour: time.hour, minute: time.minute);
    }
    return dateTime;
  }
}

extension DateExtension on DateTime? {
  DateTime updateWithTimeValues(TimeOfDay? time) {
    DateTime? dateTime;
    if (this != null) {
      dateTime = DateTime.fromMillisecondsSinceEpoch(this!.millisecondsSinceEpoch);
      if (time != null) {
        dateTime = dateTime.copyWith(hour: time.hour, minute: time.minute);
      }
    }
    return dateTime ?? DateTime.now();
  }
}

extension StringExtension on String {
  String toTimeDateStr() {
    if (length < 11) return "2000-01-01 ${this}";
    return this;
  }

  TimeOfDay toTimeStr([String local = 'en']) {
    // context.printInfo(info: 'toTimeStr: In: ' + this.toString());
    var format = intl.DateFormat('hh:mm a', local);
    var date = format.parse(this);
    // context.printInfo(info: 'toTimeStr: Out: ' + format.format(date));
    return TimeOfDay.fromDateTime(date);
  }

  TimeOfDay toTimeOfDay() {
    return TimeOfDay(hour: int.parse(split(":")[0]), minute: int.parse(split(":")[1]));
  }
}

extension DoubleExtension on double {
  String toDoubleStr() {
    return this == null
        ? "0"
        : ((this - (toInt())) > 0.000001)
            ? toString()
            : toInt().toString();
  }
}

extension TimeOfDayExtension on TimeOfDay {
  String get str => '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:00';

  String get strShort => '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';

  DateTime get dateTime => DateTime(2000, 1, 1, hour, minute); //Date 2000,1,1 is a reference

  String toTimeStr([String formatStr = 'hh:mm a']) {
    var format = intl.DateFormat(formatStr);
    return format.format(dateTime);
  }
}

extension GenericListExtension<T extends List> on T? {
  bool hasData() {
    return this != null && this!.isNotEmpty;
  }

  int addAllSynced(List<dynamic> list) {
    int c = 0;
    for (var obj in list) {
      int index = 0;
      if ((index = this!.indexWhere((element) => element.id == obj.id)) == -1) {
        this!.add(obj);
        c++;
      } else {
        this![index] = obj;
      }
    }

    // this!.sort((a, b) => b.created_at!.compareTo(a.created_at!));
    return c;
  }

  int addAllSynced2(List<dynamic> list) {
    List newItems = this!.where((element) => list.indexWhere((obj) => element.id == obj.id) == -1).toList();
    this!.addAll(newItems);

    List oldItems = list.subtract(newItems).toList();

    for (var obj in oldItems) {
      int index = 0;
      if ((index = this!.indexWhere((element) => element.id == obj.id)) == -1) {
        this!.add(obj);
      } else {
        this![index] = obj;
      }
    }

    // this!.sort((a, b) => b.created_at!.compareTo(a.created_at!));
    return newItems.length;
  }
}

extension ColorExt on matLib.Color {
  MaterialColor get toMaterial {
    Map<int, matLib.Color> colors = {
      50: matLib.Color.fromRGBO(red, green, blue, 0.1),
      100: matLib.Color.fromRGBO(red, green, blue, .2),
      200: matLib.Color.fromRGBO(red, green, blue, .3),
      300: matLib.Color.fromRGBO(red, green, blue, .4),
      400: matLib.Color.fromRGBO(red, green, blue, .5),
      500: matLib.Color.fromRGBO(red, green, blue, .6),
      600: matLib.Color.fromRGBO(red, green, blue, .7),
      700: matLib.Color.fromRGBO(red, green, blue, .8),
      800: matLib.Color.fromRGBO(red, green, blue, .9),
      900: matLib.Color.fromRGBO(red, green, blue, 1),
    };
    return matLib.MaterialColor(value, colors);
  }

  List<Color> get toGradiant {
    return [
      toMaterial[900]!,
      toMaterial[900]!,
      toMaterial[800]!,
      toMaterial[700]!,
      toMaterial[600]!,
      // toMaterial[500]!,
      // toMaterial[400]!,
    ].reversed.toList();
  }
}

extension StringNullExtension on String? {
  bool get isBase64 {
    if (!isNullOrEmptyOrWhiteSpace) {
      try {
        base64Decode(this!);
        return true;
      } on Exception catch (_) {
        return false;
      }
    }
    return false;
  }
}
