import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:flutter/material.dart';

import 'package:dart_extensions/dart_extensions.dart';
import 'package:intl/intl.dart';
import 'panel/super_panel.dart';
import 'package:time/time.dart';
import 'super_datefield.dart';
import 'super_timefield.dart';

class SuperDateTimeField extends StatefulWidget {
  final String hint;
  final  bool enabled;
  void Function(dynamic, dynamic)? onChanged;
  void Function(dynamic)? onChangedAll;

  final ValueNotifier<TimeOfDay?> _curTime = ValueNotifier(null);
  TimeOfDay? get curTime => _curTime.value;
  set curTime(TimeOfDay? val) => _curTime.value = val;

  final ValueNotifier<DateTime?> _curDate = ValueNotifier(null);
  DateTime? get curDate => _curDate.value;
  set curDate(DateTime? val) => _curDate.value = val;

  DateTime? curValue;
  final  List<String? Function(dynamic?)>? validators;

  SuperDateTimeField({super.key, this.hint = '', this.curValue, this.enabled = true, this.onChanged, this.onChangedAll, this.validators = const [], date, time}) {
    curDate = date;
    curTime = time;
    updateFullDateTime();
  }
  updateFullDateTime() {
    if (curValue != null) {
      curTime = TimeOfDay.fromDateTime(curValue!);
      curDate = curValue!.copyWith(
        hour: curTime!.hour,
        minute: curTime!.minute,
      );
    } else if (curDate != null) {
      curTime ??= TimeOfDay.now();
      curValue = curDate!.copyWith(
        hour: curTime!.hour,
        minute: curTime!.minute,
      );
    }
  }

  @override
  SuperDateTimeFieldState createState() => SuperDateTimeFieldState();
}

class SuperDateTimeFieldState extends State<SuperDateTimeField> {
  DateTime? date;
  TimeOfDay? time;

  @override
  Widget build(BuildContext context) {
    return SuperPanel(
      title: widget.hint,
      child: Row(
        children: [
          Expanded(
              child: SuperDateField(
                  validators: widget.validators!,
                  enabled: widget.enabled,
                  onChanged: (s) {
                    date = s;
                    widget.onChanged?.call(date, time);
                    if (date != null) {
                      time ??= TimeOfDay.now();
                      widget.onChangedAll?.call(
                        date!.copyWith(
                          hour: time!.hour,
                          minute: time!.minute,
                        ),
                      );
                    }
                  },
                  label: 'Date',
                  hint: 'Date',
                  value: widget.curDate)),
          const SizedBox(width: 16),
          Expanded(
              child: SuperTimeField(
                  validators: widget.validators!,
                  enabled: widget.enabled,
                  onChanged: (s) {
                    time = s;
                    widget.onChanged?.call(date, time);
                    if (date != null) {
                      time ??= TimeOfDay.now();
                      widget.onChangedAll?.call(
                        date!.copyWith(
                          hour: time!.hour,
                          minute: time!.minute,
                        ),
                      );
                    }
                  },
                  label: 'Time',
                  hint: 'Time',
                  value: widget.curTime)),
        ],
      ),
    );
  }
}
