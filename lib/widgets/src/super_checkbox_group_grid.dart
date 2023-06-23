import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:list_ext/list_ext.dart';
import 'package:ready_extensions/ready_extensions.dart';
import 'package:super_widgets/super_widgets.dart';

import 'super_labeled_check_box.dart';

// import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SuperCheckBoxGroupGrid extends StatelessWidget {
  final String? hint;
  final String? label;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? eAsset;
  final bool enableRTL;
  final bool enabled;
  final WrapAlignment wrapAlignment;
  final OptionsOrientation optionsOrientation;
  final List<dynamic> items;
  final List<String? Function(dynamic)> validators;
  final void Function(List<dynamic>?)? onChanged;
  late final String Function(dynamic)? itemAsString;

  late final EdgeInsets? contentPadding;
  final int crossAxisCount;
  final double? childAspectRatio;
  final double crossAxisSpacing;
  final double mainAxisSpacing;

  final List<dynamic> initialValue;

  SuperCheckBoxGroupGrid(
      {super.key,
      required this.items,
      this.itemAsString,
      this.optionsOrientation = OptionsOrientation.wrap,
      this.onChanged,
      this.contentPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      this.childAspectRatio,
      this.crossAxisCount = 2,
      this.crossAxisSpacing = 10.0,
      this.mainAxisSpacing = 10.0,
      this.hint = '',
      this.label = '',
      this.wrapAlignment = WrapAlignment.start,
      this.prefixIcon,
      this.suffixIcon,
      this.eAsset,
      this.initialValue = const [],
      this.enabled = true,
      this.enableRTL = false,
      this.validators = const []}) {
    itemAsString = itemAsString ?? ((dynamic s) => s.toString().tr);
    if (initialValue.isNotNullOrEmpty) {
      selectedItems = [...initialValue];
    }
    // mPrint('initialValue = $initialValue');
  }

  final _selectedItems = <dynamic>[].obs;

  List<dynamic> get selectedItems => _selectedItems;

  set selectedItems(List<dynamic> val) => _selectedItems.value = val;

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<List<dynamic>>(
      name: "SuperCheckBoxGroupGrid_${label}_$hint",
      enabled: enabled,
      validator: FormBuilderValidators.compose(validators),
      onChanged: onChanged,
      initialValue: initialValue,
      builder: (FormFieldState<dynamic> field) {
        return SuperPanel(
          title: (hint ?? label ?? '').tr,
          contentPadding: contentPadding,
          child: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: crossAxisCount,
            childAspectRatio: childAspectRatio ?? (1 / (0.12 * crossAxisCount)),
            crossAxisSpacing: crossAxisSpacing,
            mainAxisSpacing: mainAxisSpacing,
            shrinkWrap: true,
            children: items
                .map((obj) => SuperLabeledCheckbox(
                      enabled: enabled,
                      contentPadding: EdgeInsets.zero,
                      value: selectedItems.contains(obj),
                      onChanged: (b) {
                        if (b == true) {
                          if (obj is String && obj.isNullOrEmptyOrWhiteSpace) {
                            mPrint('obj = $obj isNullOrEmptyOrWhiteSpace');
                            selectedItems.remove(obj);
                            return;
                          }
                          if (!selectedItems.contains(obj)) selectedItems.add(obj);
                        } else {
                          selectedItems.remove(obj);
                        }
                        field.didChange(selectedItems);
                      },
                      title: itemAsString!(obj),
                      txtColor: (Get.isDarkMode ? Colors.white : Colors.black),
                    ))
                .toList(growable: false),
          ),
        );
      },
    );
  }
}
