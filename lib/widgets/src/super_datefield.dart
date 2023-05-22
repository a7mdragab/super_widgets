import 'package:dart_extensions/dart_extensions.dart';
import 'package:date_field/date_field.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:super_widgets/home/home.dart';
import 'package:super_widgets/utils/my_extensions.dart';

class SuperDateField extends StatefulWidget {
  final String? label, hint;
  final String dateFormat;
  final bool enabled;
  final DateTime? initialDate, firstDate, lastDate;
  final void Function(dynamic)? onChanged;

  final List<String? Function(dynamic)>? validators;

  const SuperDateField(
      {super.key,
      this.initialDate,
      this.firstDate,
      this.lastDate,
      this.dateFormat = 'dd-MMMM-yyyy',
      this.label = 'From',
      this.hint = 'From',
      this.enabled = true,
      this.onChanged,
      this.validators = const []});

  @override
  State<SuperDateField> createState() => _SuperDateFieldState();
}

class _SuperDateFieldState extends State<SuperDateField> {
  final TextEditingController mController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DateTimeFormField(
      enabled: widget.enabled,

      //region Decorator
      decoration: const InputDecoration().applyDefaults(Get.context!.theme.inputDecorationTheme).copyWith(
            isDense: true,
            isCollapsed: true,
            alignLabelWithHint: true,
            contentPadding: const EdgeInsets.all(16),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            filled: true,
            fillColor: Colors.white,
            suffixIcon: mController.text.isNullOrWhiteSpace || !widget.enabled
                ? null
                : IconButton(
                    onPressed: () {
                      mController.clear();
                      setState(() {});
                    },
                    icon: const Icon(Icons.close),
                  ),
            suffixIconConstraints: const BoxConstraints(maxWidth: 40),
            labelStyle: TextStyle(fontSize: 16, color: context.theme.primaryColor),
            labelText: widget.hint,
            hintText: widget.hint,
            hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
      //endregion Decorator

      dateFormat: DateFormat(widget.dateFormat, LanguageService.to.getLocale.languageCode),
      initialValue: widget.initialDate,
      initialDate: widget.initialDate,
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
      mode: DateTimeFieldPickerMode.date,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      // validator: (e) => (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
      validator: FormBuilderValidators.compose(widget.validators!),
      onDateSelected: widget.onChanged,
    );
    // return DateTimeField(
    //   enabled: widget.enabled,
    //   format: DateFormat(widget.dateFormat, LanguageService.to.getLocale.languageCode),
    //   decoration: const InputDecoration().applyDefaults(context.theme.inputDecorationTheme).copyWith(
    //         isDense: true,
    //         isCollapsed: true,
    //         alignLabelWithHint: true,
    //         contentPadding: const EdgeInsets.all(16),
    //         floatingLabelBehavior: FloatingLabelBehavior.always,
    //         filled: true,
    //         fillColor: Colors.white,
    //         suffixIcon: mController.text.isNullOrWhiteSpace || !widget.enabled
    //             ? null
    //             : IconButton(
    //                 onPressed: () {
    //                   mController.clear();
    //                   setState(() {});
    //                 },
    //                 icon: const Icon(Icons.close),
    //               ),
    //         suffixIconConstraints: const BoxConstraints(maxWidth: 40),
    //         labelStyle: TextStyle(fontSize: 16, color: context.theme.primaryColor),
    //         labelText: widget.hint,
    //         hintText: widget.hint,
    //         hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
    //       ),
    //   initialValue: widget.initialDate,
    //   controller: mController,
    //   validator: FormBuilderValidators.compose(widget.validators!),
    //   onShowPicker: (BuildContext context, DateTime? currentValue) async {
    //     var res = await showDatePicker(
    //       context: context,
    //       firstDate: widget.firstDate ?? DateTime(1900),
    //       lastDate: widget.lastDate ?? DateTime(2050),
    //       initialDate: currentValue ?? widget.initialDate ?? DateTime.now(),
    //     );
    //     mController.text = res == null ? (currentValue ?? widget.initialDate)!.toDateStr(widget.dateFormat) : res.toDateStr(widget.dateFormat);
    //     // mController.text = res == null ? '' : 'res.toDateStr(widget.dateFormat)';
    //
    //     setState(() {});
    //     return res;
    //   },
    // );
  }
}
