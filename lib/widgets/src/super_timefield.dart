import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:flutter/material.dart';

import 'package:dart_extensions/dart_extensions.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:super_widgets/utils/my_extensions.dart';

class SuperTimeField extends StatefulWidget {
  final String? label, hint;
  final bool enabled;
  final void Function(dynamic)? onChanged;

  final ValueNotifier<TimeOfDay?> _curValue = ValueNotifier(null);
  TimeOfDay? get curValue => _curValue.value;
  set curValue(TimeOfDay? val) => _curValue.value = val;

  final TextEditingController mController = TextEditingController();

  setValue(TimeOfDay? val) {
    curValue = val;
  }

  final List<String? Function(dynamic)>? validators;

  SuperTimeField({super.key, this.label = 'من', this.hint = 'الوقت', this.enabled = true, this.onChanged, this.validators = const [], value}) {
    curValue = value;
    if (curValue != null) {
      mController.text = curValue!.toTimeStr();
      // mController.text = curValue!.dateTime.toTimeStr();
    }
    _curValue.addListener(() {
      if (curValue == null) {
        mController.clear();
      } else {
        mController.text = curValue!.toTimeStr();
      }
      onChanged?.call(curValue);
    });
  }

  @override
  SuperTimeFieldState createState() => SuperTimeFieldState();
}

class SuperTimeFieldState extends State<SuperTimeField> {
  @override
  Widget build(BuildContext context) {
    return DateTimeField(
      enabled: widget.enabled,
      format: DateFormat("hh:mm a", 'en'),
      validator: FormBuilderValidators.compose(widget.validators!),
      decoration: const InputDecoration().applyDefaults(context.theme.inputDecorationTheme).copyWith(
            isDense: true,
            isCollapsed: true,
            alignLabelWithHint: true,
            contentPadding: const EdgeInsets.all(4),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            filled: true,
            fillColor: Colors.white,
            suffixIcon: InkWell(
                onTap: () {
                  widget.mController.clear();
                  widget.setValue(null);
                  setState(() {});
                },
                child: const Icon(Icons.close, size: 16)),
            suffixIconConstraints: const BoxConstraints(maxHeight: 20, maxWidth: 20),
            labelStyle: TextStyle(fontSize: 16, color: context.theme.primaryColor),
            labelText: widget.hint,
            hintText: widget.hint,
      ),
      initialValue: widget.curValue?.dateTime,
      controller: widget.mController,
      onShowPicker: (BuildContext context, DateTime? currentValue) async {
        var res = await showTimePicker(
          context: context,
          initialTime: (currentValue != null ? TimeOfDay.fromDateTime(currentValue) : widget.curValue ?? TimeOfDay.now()),
        );
        if (res != null) {
          widget.setValue(res);
        }
        setState(() {});
        return widget.curValue?.dateTime;
      },
    );
  }
}
