// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'package:dart_extensions/dart_extensions.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:super_widgets/utils/helpers.dart';

import 'txt.dart';

// import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SuperRadioGroup extends StatefulWidget {
  final String hint;
  final String? label;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? eAsset;
  final bool enableRTL;
  final OptionsOrientation optionsOrientation;
  final EdgeInsets contentPadding;
  final List<dynamic> items;
  final void Function(dynamic)? onChanged;
  String Function(dynamic)? itemAsString;

  final List<String? Function(dynamic)>? validators;

  final bool enabled;
  final dynamic initialValue;

  SuperRadioGroup({
    super.key,
    required this.items,
    String Function(dynamic)? itemAsString,
    this.optionsOrientation = OptionsOrientation.wrap,
    this.onChanged,
    this.hint = '',
    this.label,
    this.initialValue = '',
    this.prefixIcon,
    this.suffixIcon,
    this.eAsset,
    this.contentPadding = const EdgeInsets.all(8),
    this.enabled = true,
    this.enableRTL = false,
    this.validators = const [],
  }) {
    this.itemAsString = itemAsString ?? ((dynamic s) => s.toString());
  }

  @override
  _SuperRadioGroupState createState() => _SuperRadioGroupState();
}

class _SuperRadioGroupState extends State<SuperRadioGroup> {
  bool isValid = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: isArabic((widget.label ?? widget.hint).tr) || widget.enableRTL ? TextDirection.rtl : TextDirection.ltr,
      child: FormBuilderRadioGroup(
        decoration: const InputDecoration().applyDefaults(context.theme.inputDecorationTheme).copyWith(
              contentPadding: widget.contentPadding,
              labelText: (widget.label ?? widget.hint).tr,
              hintText: widget.hint.tr,
              suffixIcon: widget.suffixIcon == null ? null : Icon(widget.suffixIcon),
              prefixIcon: widget.prefixIcon == null
                  ? widget.eAsset == null
                      ? null
                      : Image.asset(widget.eAsset!)
                  : Icon(widget.prefixIcon),
            ),
        name: widget.hint,
        initialValue: widget.initialValue!,
        orientation: OptionsOrientation.horizontal,
        onChanged: widget.onChanged,
        enabled: widget.enabled,
        validator: FormBuilderValidators.compose(widget.validators!),
        options: widget.items
            .map((obj) => FormBuilderFieldOption(
                  value: obj,
                  child: Txt(widget.itemAsString!(obj)),
                ))
            .toList(growable: false),
      ),
    );
  }
}
