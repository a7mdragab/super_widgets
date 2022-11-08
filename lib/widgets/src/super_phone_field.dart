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

class SuperPhoneField extends StatelessWidget {
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

  final String initialPhone;
  final String? initialCountryCode;
  final String initialDialCode;
  final TextEditingController phoneController;

  SuperPhoneField(
    this.phoneController, {
    super.key,
    this.initialDialCode = '+20',
    this.initialCountryCode,
    this.initialPhone = '',
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
  }) {
    initCountry();
  }

  final Rxn<PhoneNumber> _phoneNum = Rxn<PhoneNumber>();

  PhoneNumber? get phoneNum => _phoneNum.value;

  set phoneNum(PhoneNumber? val) => _phoneNum.value = val;

  final Rxn<Country> _country = Rxn<Country>();

  Country? get country => _country.value;

  set country(Country? val) => _country.value = val;

  void initCountry() async {
    try {
      if (!initialPhone.isNullOrEmptyOrWhiteSpace) {
        country = getCountryFromPhoneNum(initialPhone);
      }
      if (country == null && useSimIfAvailable) {
        String? simCode = await FlutterSimCountryCode.simCountryCode;
        if (!simCode.isNullOrEmptyOrWhiteSpace) {
          if (enableDebug == true) mPrint('Getting from simCode');
          country ??= getCountryByCountryCode(simCode!);
          if (enableDebug == true && country != null) mPrint('Got from simCode');
        }
      }
      if (country == null) {
        if (!initialDialCode.isNullOrEmptyOrWhiteSpace) {
          if (enableDebug == true) mPrint('Getting from initialDialCode');
          country ??= getCountryByCallingCode(initialDialCode);
          if (enableDebug == true) if (country != null) mPrint('Got from initialDialCode');
        } else if (!initialCountryCode.isNullOrEmptyOrWhiteSpace) {
          if (enableDebug == true) mPrint('Getting from initialCountryCode');
          country ??= getCountryByCountryCode(initialCountryCode!);
          if (enableDebug == true && country != null) mPrint('Got from initialCountryCode');
        }
      }
      if (enableDebug == true) mPrint('Selected country: ${country?.toMap()}');
    } on Exception catch (e) {
      if (enableDebug == true) {
        mPrintError('Exception $e');
      }
    }
    country ??= egyptCountry;
    _country.update((val) {
      val = country;
    });

    if (enableDebug == true) {
      mPrint('Initial country: ${country?.toMap()}');
    }
    if (country != null) {
      phoneNum = PhoneNumber(countryISOCode: country!.code, countryCode: '+${country!.dialCode}', number: initialPhone);
      phoneController.text = initialPhone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return country == null
          ? const SizedBox()
          : IntlPhoneField(
              controller: phoneController,
              initialCountryCode: country?.code,
              // initialCountryCode: country?.code,
              onChanged: (phone) {
                if (enableDebug == true) {
                  mPrint('onChanged: $phone');
                }
                phoneNum = phone;
                onPhoneChanged?.call(phoneNum!.number);
                onFullPhoneChanged?.call(phoneNum!.completeNumber);
              },
              onCountryChanged: (country) {
                if (enableDebug == true) {
                  mPrint('onCountryChanged: ${country.name}-${country.flag}-${country.dialCode}-${country.code}');
                }
                phoneNum?.countryCode = '+${country.dialCode}';
                onCountryChanged?.call(phoneNum!.countryCode);
                onFullPhoneChanged?.call(phoneNum!.completeNumber);
              },
              readOnly: readOnly,
              enabled: enabled,
              onTap: onTap,
              onSubmitted: onSubmitted == null
                  ? null
                  : (s) {
                      onSubmitted?.call(s);
                    },
              textAlign: TextAlign.left,
              validator: !enableValidate || validators.isNullOrEmpty ? null : FormBuilderValidators.compose(validators ?? []),
              keyboardType: TextInputType.phone,

              ///region Decoration
              decoration: inputDecoration ??
                  const InputDecoration().applyDefaults(Get.theme.inputDecorationTheme).copyWith(
                        isDense: true,
                        isCollapsed: true,
                        alignLabelWithHint: true,
                        filled: true,
                        contentPadding: contentPadding ?? const EdgeInsets.all(20),
                        hintStyle: Get.textTheme.labelLarge!.copyWith(color: Colors.grey),
                        floatingLabelStyle: Get.textTheme.titleSmall!.copyWith(color: Get.theme.primaryColor),
                        labelStyle: Get.textTheme.bodyLarge!.copyWith(color: Get.theme.primaryColor),
                        fillColor: fillColor,
                        labelText: eLabel ?? eHint,
                        hintText: eHint,
                      ),

              ///endregion Decoration
            );
    });
  }
}
