// import 'package:country_calling_code_picker/country.dart';
// import 'package:country_calling_code_picker/functions.dart';
import 'package:flutter/material.dart';

import 'package:flutter_sim_country_code/flutter_sim_country_code.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:list_ext/list_ext.dart';
import 'package:ready_extensions/ready_extensions.dart';
import 'package:super_widgets/utils/country.dart';

import '../../utils/helpers.dart';

class SuperPhoneField extends StatefulWidget {
  final String? eLabel;
  final String eHint;
  final Color fillColor;

  final bool enabled;
  final bool readOnly;
  final bool enableValidate;
  final bool enableDebug;
  final bool useSimIfAvailable;

  final InputDecoration? inputDecoration;
  final EdgeInsets? contentPadding;

  final void Function()? onTap;
  final void Function(String?)? onSubmitted;
  final void Function(String?)? onPhoneChanged, onCountryChanged, onFullPhoneChanged;
  final List<String? Function(PhoneNumber?)>? validators;

  final String? initialCountryCode;
  final String initialDialCode;
  final TextEditingController phoneController;

  const SuperPhoneField(
    this.phoneController, {
    super.key,
    this.initialDialCode = '+20',
    this.initialCountryCode,
    this.eHint = 'Phone number',
    this.eLabel,
    this.fillColor = Colors.white,
    this.onPhoneChanged,
    this.onCountryChanged,
    this.onFullPhoneChanged,
    this.onSubmitted,
    this.onTap,
    this.useSimIfAvailable = true,
    this.enableDebug = false,
    this.enabled = true,
    this.readOnly = false,
    this.enableValidate = true,
    this.contentPadding,
    this.inputDecoration,
    this.validators,
  });

  @override
  SuperPhoneFieldState createState() => SuperPhoneFieldState();
}

class SuperPhoneFieldState extends State<SuperPhoneField> {
  PhoneNumber? phoneNum;
  Country? country;

  void initCountry() async {
    try {
      if (widget.useSimIfAvailable) {
        String? simCode = await FlutterSimCountryCode.simCountryCode;
        if (!simCode.isNullOrEmptyOrWhiteSpace) {
          country ??= getCountryByCountryCode(simCode!);
          if (country != null) mPrint('Got from simCode');
        }
      }
      if (country == null) {
        if (!widget.initialDialCode.isNullOrEmptyOrWhiteSpace) {
          country ??= getCountryByCallingCode(widget.initialDialCode);
          if (country != null) mPrint('Got from initialDialCode');
        } else if (!widget.initialCountryCode.isNullOrEmptyOrWhiteSpace) {
          country ??= getCountryByCountryCode(widget.initialCountryCode!);
          if (country != null) mPrint('Got from initialCountryCode');
        }
      }
      mPrint('Selected country: ${country?.toMap()}');
    } on Exception catch (e) {
      if (widget.enableDebug == true) {
        mPrintError('Exception $e');
      }
    }
    country ??= egyptCountry;

    if (widget.enableDebug == true) {
      mPrint('Initial country: ${country?.toMap()}');
    }
    if (country != null) {
      phoneNum = PhoneNumber(countryISOCode: country!.code, countryCode: country!.dialCode, number: '');
    }
  }

  @override
  void initState() {
    initCountry();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      controller: widget.phoneController,
      initialCountryCode: country?.dialCode,
      onChanged: (phone) {
        if (widget.enableDebug == true) {
          mPrint('onChanged: $phone');
        }
        phoneNum = phone;
        widget.onPhoneChanged?.call(phoneNum!.number);
        widget.onFullPhoneChanged?.call(phoneNum!.completeNumber);
      },
      onCountryChanged: (country) {
        if (widget.enableDebug == true) {
          mPrint('onCountryChanged: ${country.name}-${country.flag}-${country.dialCode}-${country.code}');
        }
        phoneNum?.countryCode = '+${country.dialCode}';
        widget.onCountryChanged?.call(phoneNum!.countryCode);
        widget.onFullPhoneChanged?.call(phoneNum!.completeNumber);
      },
      readOnly: widget.readOnly,
      enabled: widget.enabled,
      onTap: widget.onTap,
      onSubmitted: widget.onSubmitted == null
          ? null
          : (s) {
              widget.onSubmitted?.call(s);
            },
      textAlign: TextAlign.left,
      validator: !widget.enableValidate || widget.validators.isNullOrEmpty ? null : FormBuilderValidators.compose(widget.validators ?? []),
      keyboardType: TextInputType.phone,

      ///region Decoration
      decoration: widget.inputDecoration ??
          const InputDecoration().applyDefaults(Get.theme.inputDecorationTheme).copyWith(
                isDense: true,
                isCollapsed: true,
                alignLabelWithHint: true,
                filled: true,
                contentPadding: widget.contentPadding ?? const EdgeInsets.all(20),
                hintStyle: Get.textTheme.labelLarge!.copyWith(color: Colors.grey),
                floatingLabelStyle: Get.textTheme.titleSmall!.copyWith(color: Get.theme.primaryColor),
                labelStyle: Get.textTheme.bodyLarge!.copyWith(color: Get.theme.primaryColor),
                fillColor: widget.fillColor,
                labelText: widget.eLabel ?? widget.eHint,
                hintText: widget.eHint,
              ),

      ///endregion Decoration
    );
  }
}
