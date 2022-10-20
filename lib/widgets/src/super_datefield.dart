import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:flutter/material.dart';

import 'package:dart_extensions/dart_extensions.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:super_widgets/utils/my_extensions.dart';

class SuperDateField extends StatefulWidget {
  final String? label, hint;
  final bool enabled;
  final void Function(dynamic)? onChanged;

  final ValueNotifier<DateTime?> _curValue = ValueNotifier(null);
  DateTime? get curValue => _curValue.value;
  set curValue(DateTime? val) => _curValue.value = val;

  final TextEditingController mController = TextEditingController();

  setValue(DateTime? val) {
    curValue = val;
  }

  final List<String? Function(dynamic)>? validators;

  SuperDateField({super.key, this.label = 'From', this.hint = 'To', this.enabled = true, this.onChanged, this.validators = const [], value}) {
    curValue = value;
    if (curValue != null) {
      mController.text = curValue!.toDateStr();
      // mController.text = curValue!.dateTime.toTimeStr();
    }
    _curValue.addListener(() {
      if (curValue == null) {
        mController.clear();
      } else {
        mController.text = curValue!.toDateStr();
      }
      onChanged?.call(curValue);
    });
  }

  @override
  State<SuperDateField> createState() => _SuperDateFieldState();
}

class _SuperDateFieldState extends State<SuperDateField> {
  @override
  Widget build(BuildContext context) {
    return DateTimeField(
      enabled: widget.enabled,
      format: DateFormat("dd-MMMM-yyyy"),
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
            hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
            // prefixIconConstraints: BoxConstraints.tightForFinite(width: 30),
            // prefixIcon: widget.eIcon == null
            //     ? widget.eAsset == null
            //         ? null
            //         : Image.asset('assets/images/${widget.eAsset}.svg')
            //     : Icon(widget.eIcon),
            border: OutlineInputBorder(borderSide: const BorderSide(color: Colors.blue), borderRadius: BorderRadius.circular(1)),
            enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.blue), borderRadius: BorderRadius.circular(1)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(2), borderSide: const BorderSide(color: Colors.green)),
          ),
      initialValue: widget.curValue,
      controller: widget.mController,
      validator: FormBuilderValidators.compose(widget.validators!),
      onShowPicker: (BuildContext context, DateTime? currentValue) async {
        var res = await showDatePicker(
          context: context,
          firstDate: DateTime(1900),
          lastDate: DateTime(2050),
          initialDate: currentValue ?? widget.curValue ?? DateTime.now(),
        );
        if (res != null) {
          widget.setValue(res);
        }
        setState(() {});
        return widget.curValue;
      },
    );
  }
}
