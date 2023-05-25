import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:super_widgets/super_widgets.dart';

// import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SuperCheckBoxGroup extends StatefulWidget {
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
  final List<String? Function(dynamic)>? validators;
  final void Function(dynamic)? onChanged;
  String Function(dynamic)? itemAsString;

  final dynamic initialValue;

  SuperCheckBoxGroup(
      {super.key,
      required this.items,
      this.itemAsString,
      this.optionsOrientation = OptionsOrientation.wrap,
      this.onChanged,
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

  @override
  SuperCheckBoxGroupState createState() => SuperCheckBoxGroupState();
}

class SuperCheckBoxGroupState extends State<SuperCheckBoxGroup> {
  @override
  Widget build(BuildContext context) {
    return SuperPanel(
        title: (widget.hint ?? widget.label ?? '').tr,
        child: FormBuilderCheckboxGroup(
          name: widget.hint!,
          initialValue: widget.initialValue!,
          wrapAlignment: widget.wrapAlignment,
          decoration: const InputDecoration().applyDefaults(context.theme.inputDecorationTheme).copyWith(
              labelText: (widget.label ?? widget.hint ?? '').tr,
              hintText: (widget.hint ?? widget.label ?? '').tr,
              suffixIcon: widget.suffixIcon == null ? null : Icon(widget.suffixIcon),
              prefixIcon: widget.prefixIcon == null
                  ? widget.eAsset == null
                      ? null
                      : Image.asset(widget.eAsset!)
                  : Icon(widget.prefixIcon)),
          orientation: widget.optionsOrientation,
          onChanged: widget.onChanged,
          enabled: widget.enabled,
          validator: FormBuilderValidators.compose(widget.validators!),
          options: widget.items
              .map((obj) => FormBuilderFieldOption(
                    value: obj,
                    child: Txt(widget.itemAsString!(obj), color: (Get.isDarkMode ? Colors.white : Colors.black), fontSize: 16),
                  ))
              .toList(growable: false),
        ));
  }
}
