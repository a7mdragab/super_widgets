import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ready_extensions/ready_extensions.dart';

class LanguageService extends GetxController implements GetxService {
  static LanguageService get to => Get.find();

  final _currentLanguage = 'en'.obs;

  String get currentLanguage => _currentLanguage.value;

  set currentLanguage(String val) => _currentLanguage.value = val;

  @override
  void onReady() async {
    setInitialLocalLanguage();
    super.onReady();
  }

  // Retrieves and Sets language based on device settings
  setInitialLocalLanguage() {
    printInfo(info: 'currentLanguage = $currentLanguage');
    updateLocale(currentLanguage);

    //if based on settings
    // locale= Get.deviceLocale;
    // language= locale.languageCode;

    // updateLanguage(_deviceLanguage);
  }

  //Updates
  Alignment get alignment => isArabic ? Alignment.centerRight : Alignment.centerLeft;
  Alignment get alignmentReverse => !isArabic ? Alignment.centerRight : Alignment.centerLeft;
  TextDirection get textDirection => isArabic ? TextDirection.rtl : TextDirection.ltr;
  TextDirection get textDirectionReverse => !isArabic ? TextDirection.rtl : TextDirection.ltr;
  TextAlign get textAlign => isArabic ? TextAlign.right : TextAlign.left;
  TextAlign get textAlignReverse => !isArabic ? TextAlign.right : TextAlign.left;

  // gets the language locale app is set to
  Locale get getLocale {
    // gets the default language key (from the translation language system)
    return Locale(currentLanguage);
  }

  final String keyIsFirst = 'ISFIRSTKEY';

  // updates the language stored
  Future<void> updateLocale(String value) async {
    if (!value.isNullOrEmptyOrWhiteSpace) {
      upLocale() {
        if (value.isEmpty) value = 'en';
        if (value == "عربى") value = 'ar';
        currentLanguage = value;
        Get.updateLocale(Locale(value));
      }

      GetStorage storage = GetStorage();
      bool isFirst = ((storage.read(keyIsFirst)) ?? true);
      if (isFirst) {
        storage.write(keyIsFirst, false);
        upLocale();
      } else {
        if (value != currentLanguage) {
          upLocale();
        }
      }
    }
  }

  // updates the language stored
  Future<void> toggleLanguage() async {
    currentLanguage = currentLanguage != 'ar' ? 'ar' : 'en';
    Get.updateLocale(Locale(currentLanguage));
  }

  // updates the language stored
  Future<void> updateLanguageToArabic() async {
    currentLanguage = 'ar';
    Get.updateLocale(Locale(currentLanguage));
  }

  // updates the language stored
  Future<void> updateLanguageToEnglish() async {
    currentLanguage = 'en';
    Get.updateLocale(Locale(currentLanguage));
  }

  bool get isArabic => currentLanguage == 'ar';
}
