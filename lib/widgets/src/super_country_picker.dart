import 'package:country_picker/country_picker.dart' as cp;

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:super_widgets/utils/my_extensions.dart';

import '../../utils/helpers.dart';
import 'super_edit_text.dart';

class SuperCountryPicker extends StatelessWidget {
  final TextEditingController eController;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;

  final String hint;
  final String? label;

  final bool enableRTL;

  final bool enableValidate = true;

  final List<String? Function(String?)>? validators;

  final bool enabled;
  final AutovalidateMode autovalidateMode;

  final EdgeInsets? contentPadding;
  final Color fillColor;

  final TextDirection? textDirection;
  final TextAlign? textAlign;
  final void Function(cp.Country)? onSelect;
  final double flagSize;
  final double? bottomSheetHeight;
  final String labelText;
  final String hintText;

  const SuperCountryPicker(
    this.eController, {
    super.key,
    this.focusNode,
    this.nextFocus,
    this.hint = '',
    this.label,
    this.flagSize = 25,
    this.bottomSheetHeight,
    this.fillColor = Colors.white,
    this.textAlign,
    this.labelText = 'Search',
    this.hintText = 'Start typing to search',
    this.textDirection,
    this.contentPadding,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.enabled = true,
    this.enableRTL = false,
    this.validators,
    this.onSelect,
  });
  @override
  Widget build(BuildContext context) {
    return SuperEditText(
      eController,
      enabled: enabled,
      hint: hint,
      label: label,
      fillColor: fillColor,
      textDirection: textDirection,
      textAlign: textAlign,
      enableRTL: enableRTL,
      focusNode: focusNode,
      nextFocus: nextFocus,
      ontap: enabled
          ? null
          : () {
              cp.showCountryPicker(
                context: Get.context!,
                countryListTheme: cp.CountryListThemeData(
                  flagSize: flagSize,
                  backgroundColor: Colors.white,
                  textStyle: const TextStyle(fontSize: 16, color: Colors.blueGrey),
                  bottomSheetHeight: bottomSheetHeight ?? (0.7.h),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  inputDecoration: const InputDecoration().applyDefaults(Get.theme.inputDecorationTheme).copyWith(
                        contentPadding: contentPadding,
                        labelText: labelText.tr,
                        hintText: hintText.tr,
                      ),
                ),
                onSelect: (cp.Country country) {
                  mPrint('Selected country: (${country.nameLocalized})');
                  eController.text = country.nameLocalized ?? country.name;
                  onSelect?.call(country);
                },
              );
            },
      validators: validators,
    );
  }
}
