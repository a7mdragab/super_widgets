import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:flutter/material.dart';

import 'package:dart_extensions/dart_extensions.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:super_widgets/utils/my_extensions.dart';

class SuperTimeField extends StatefulWidget {
  final String? label, hint;
  final bool showClearBtn;
  final bool enabled;
  final Color? txtColor, fillColor;
  final void Function(dynamic)? onChanged;

  final ValueNotifier<TimeOfDay?> _curValue = ValueNotifier(null);
  TimeOfDay? get curValue => _curValue.value;
  set curValue(TimeOfDay? val) => _curValue.value = val;

  final TextEditingController mController = TextEditingController();

  setValue(TimeOfDay? val) {
    curValue = val;
  }

  final List<String? Function(dynamic)>? validators;

  SuperTimeField({super.key, this.txtColor, this.fillColor, this.label, this.hint, this.enabled = true, this.showClearBtn = true, this.onChanged, this.validators = const [], value}) {
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
      style: TextStyle(fontSize: 14, color: widget.txtColor ?? context.theme.primaryColor),
      decoration: const InputDecoration().applyDefaults(context.theme.inputDecorationTheme).copyWith(
            fillColor: widget.fillColor,
            suffixIcon: widget.showClearBtn == true
                ? InkWell(
                    onTap: () {
                      widget.mController.clear();
                      widget.setValue(null);
                      setState(() {});
                    },
                    child: const Icon(Icons.close, size: 16))
                : const SizedBox(),
            contentPadding: EdgeInsets.zero,
            suffixIconConstraints: const BoxConstraints(maxHeight: 20, maxWidth: 20),
            labelStyle: TextStyle(color: widget.txtColor ?? context.theme.primaryColor),
            hintStyle: TextStyle(color: widget.txtColor ?? context.theme.primaryColor),
            labelText: widget.label,
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
