library duration_extension;

import 'package:flutter/material.dart';
import 'package:ready_extensions/ready_extensions.dart';

import '../messages/ready_extension_localizations.dart';


extension FlutterDurationExtensions on Duration {

  /// convert the duration to  [TimeOfDay]
  /// if duration is greater than 24 hours it will throw an exception
  TimeOfDay toTimeOfDay() {
    var delta = inMinutes;
    var hours = (delta / 60).floor();
    var minutes = delta % 60;
    if (hours > 23) {
      throw FlutterError('Hours cannot be greater than 23');
    }
    return TimeOfDay(hour: hours, minute: minutes);
  }
}
