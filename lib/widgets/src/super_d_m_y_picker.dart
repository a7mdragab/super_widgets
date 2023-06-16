import 'package:date_only_field/date_only_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:super_widgets/super_widgets.dart';

class SuperDMYPicker extends StatelessWidget {
  SuperDMYPicker({this.label, this.enabled = true, this.onChangedDate, this.onChangedDateTime, this.validators = const [], this.initialDate, this.initialDateTime, super.key});

  int day = 1;
  int month = 1;
  int? year;
  String? label;
  bool enabled = true;
  Function(Date)? onChangedDate;
  Function(DateTime)? onChangedDateTime;
  final List<String? Function(dynamic)> validators;
  final Date? initialDate;
  final DateTime? initialDateTime;

  upDate(FormFieldState<dynamic> field) {
    field.didChange(year == null ? null : Date(year!, month, day));
    if (year != null && (onChangedDate != null || onChangedDateTime != null)) {
      onChangedDate?.call(Date(year!, month, day));
      onChangedDateTime?.call(DateTime(year!, month, day));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      name: "DMYPicker_$label",
      enabled: enabled,
      validator: FormBuilderValidators.compose(validators),
      builder: (FormFieldState<dynamic> field) {
        return SuperPanel(
          title: label ?? '',
          child: Row(
            // runAlignment: WrapAlignment.spaceEvenly,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: SuperDropdownMenu(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  eHint: 'Day',
                  showSearchBox: false,
                  selectedItem: initialDate?.day,
                  items: List.generate(31, (index) => index + 1),
                  enabled: enabled,
                  // selectedItem: day,
                  onChanged: (s) => {day = s, upDate(field)},
                ),
              ),
              hSpace8,
              Expanded(
                child: SuperDropdownMenu(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  eHint: 'Month',
                  showSearchBox: false, enabled: enabled,
                  selectedItem: initialDate?.month,
                  items: List.generate(12, (index) => index + 1),
                  itemAsString: (s) => '($s) ${monthsNames[s - 1].tr}',
                  // selectedItem: month,
                  onChanged: (s) => {month = s, upDate(field)},
                ),
              ),
              hSpace8,
              Expanded(
                child: SuperDropdownMenu(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  eHint: 'Year',
                  showSearchBox: false,
                  enabled: enabled,
                  selectedItem: initialDate?.year,
                  items: List.generate(100, (index) => Date.now().year - index),
                  onChanged: (s) => {year = s, upDate(field)},
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
