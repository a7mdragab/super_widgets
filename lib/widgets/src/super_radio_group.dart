// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:dart_extensions/dart_extensions.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

// import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SuperRadioGroup extends StatefulWidget {
  final String? hint;
  final String? label;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? eAsset;
  final bool enableRTL;
  final OptionsOrientation optionsOrientation;
  final List<dynamic> items;
  final void Function(dynamic)? onChanged;

  final List<String? Function(dynamic)>? validators;

  final bool enabled;
  final String? initialValue;

  const SuperRadioGroup({
    super.key,
    required this.items,
    this.optionsOrientation = OptionsOrientation.wrap,
    this.onChanged,
    this.hint = '',
    this.label = '',
    this.initialValue = '',
    this.prefixIcon,
    this.suffixIcon,
    this.eAsset,
    this.enabled = true,
    this.enableRTL = false,
    this.validators = const [],
  });

  @override
  _SuperRadioGroupState createState() => _SuperRadioGroupState();
}

class _SuperRadioGroupState extends State<SuperRadioGroup> {
  bool isValid = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: widget.enableRTL ? TextDirection.rtl : TextDirection.ltr,
      child: FormBuilderRadioGroup(
        decoration: const InputDecoration().applyDefaults(context.theme.inputDecorationTheme).copyWith(
              labelText: widget.hint,
              hintText: widget.hint,
              suffixIcon: widget.suffixIcon == null ? null : Icon(widget.suffixIcon),
              prefixIcon: widget.prefixIcon == null
                  ? widget.eAsset == null
                      ? null
                      : Image.asset(widget.eAsset!)
                  : Icon(widget.prefixIcon),
            ),
        name: widget.hint!,
        initialValue: widget.initialValue!,
        orientation: OptionsOrientation.horizontal,
        onChanged: widget.onChanged,
        enabled: widget.enabled,
        validator: FormBuilderValidators.compose(widget.validators!),
        options: widget.items.map((obj) => FormBuilderFieldOption(value: obj)).toList(growable: false),
      ),
    );
  }
}
