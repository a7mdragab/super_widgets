import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:super_widgets/super_widgets.dart';

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
  String Function(dynamic)? itemAsString;

  final int crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;

  final dynamic initialValue;

  SuperCheckBoxGroupGrid(
      {super.key,
      required this.items,
      this.itemAsString,
      this.optionsOrientation = OptionsOrientation.wrap,
      this.onChanged,
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
      builder: (FormFieldState<dynamic> field) {
        return SuperPanel(
          title: (hint ?? label ?? '').tr,
          child: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: crossAxisSpacing,
            mainAxisSpacing: mainAxisSpacing,
            shrinkWrap: true,
            children: items
                .map((obj) => GestureDetector(
                      onTap: () {
                        selectedItems.contains(obj) ? selectedItems.remove(obj) : selectedItems.add(obj);
                        field.didChange(selectedItems);
                      },
                      child: Obx(() {
                        return FormBuilderFieldOption(
                          value: obj,
                          child: Txt(itemAsString!(obj), color: (Get.isDarkMode ? Colors.white : Colors.black), fontSize: 16),
                        );
                      }),
                    ))
                .toList(growable: false),
          ),
        );
      },
    );
  }
}
