import 'dart:async';
import 'package:crypt/crypt.dart';
import 'package:dart_extensions/dart_extensions.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:root/root.dart';
import 'package:super_widgets/super_widgets.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart' as foundation;

Future<bool> isRooted() async {
  return (await Root.isRooted()) ?? false;
}
Future<bool> isAndroidRealDevice() async {
  return ((await getAndroidDeviceInfo()).isPhysicalDevice);
}

bool isValidHash(String cryptFormatHash, String enteredPlain) {
  try {
    return Crypt(cryptFormatHash).match(enteredPlain);
  } on Exception catch (e) {
    mPrint('Exception $e - ($cryptFormatHash , $enteredPlain)');
    return false;
  }
}

String computeHash(String input) => Crypt.sha256(input).toString();


Future<AndroidDeviceInfo> getAndroidDeviceInfo() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  return await deviceInfo.androidInfo;
}
Future<IosDeviceInfo> getIOSDeviceInfo() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  return await deviceInfo.iosInfo;
}
Future<WebBrowserInfo> getWebBrowserInfo() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  return await deviceInfo.webBrowserInfo;
}
Future<WindowsDeviceInfo> getWindowsBrowserInfo() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  return await deviceInfo.windowsInfo;
}
Future<LinuxDeviceInfo> getLinuxInfo() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  return await deviceInfo.linuxInfo;
}
Future<String> getAndroidDeviceID() async {
  String? deviceId = await PlatformDeviceId.getDeviceId;
  AndroidDeviceInfo androidInfo = await getAndroidDeviceInfo();
  return ('${androidInfo.id}_${androidInfo.device}_$deviceId');
}

String getYoutubeVideoThumbnail(String videoUrl) {
  String vidID = videoUrl.substring(videoUrl.indexOf('?v=') + 3);
  return 'https://img.youtube.com/vi/$vidID/0.jpg';
}

launchStringURL(String link) async {
  if (await canLaunchUrl(Uri.parse(link))) {
    await launchUrl(Uri.parse(link));
  } else {
    mPrintError('Could not launch $link');
  }
}

_getWhatsNum(String phone) {
  String num = phone.replaceAll('+', '').replaceAll(' ', '');
  for (int I = 0; I < num.length; I++) {
    if (num[0] == '0') {
      num = num.substring(1);
    }
  }
  return num;
}

launchWhatsApp(String phone, [String? msg = 'Hello']) async {
  String num = _getWhatsNum(phone);
  // await MylaunchURL(('whatsapp://send?phone=$num&text=hello'));
  // await MylaunchURL("https://api.whatsapp.com/send?phone=${num}&text=${AuthService.to.whatsAppMsg.replaceAll(' ', '%20')}");
  // await MylaunchURL("https://wa.me/$num?text=Hello%2C%20I%20want%20to%20add%20fund%20for%20my%20account%20for%20Dr.%20Hussam%20Abo%20Al-Rob%20Courses");
  await launchStringURL("whatsapp://send?phone=$num&text=$msg");
  // await MylaunchURL("whatsapp://send?phone=$num&text=Hi, I need some help");
  // await MylaunchURL(('https://wa.me/$num'));
  // await MylaunchURL(('https://wa.me/$num?text=${AuthService.to.whatsAppMsg}'));
}

launchFacePage(String fbLink) async {
  if (await canLaunchUrl(Uri.parse('fb://facewebmodal/f?href=$fbLink'))) {
    await launchStringURL('fb://facewebmodal/f?href=$fbLink');
    return true;
  } else {
    if (await canLaunchUrl(Uri.parse(fbLink))) {
      await launchStringURL(fbLink);
      return true;
    } else {
      return false;
    }
  }
}

//Hello %name
String getFormattedString(String x, List vals) {
  String temp = x;
  int argIndex = 0;
  int index = 0;
  while ((index = temp.indexOf('%')) != -1) {
    temp = temp.replaceRange(index + 1, index + 2, '');
    temp = temp.replaceFirst('%', vals[argIndex++]);
  }
  return temp;
}

Future<ImageSource> showImagePickerDialog() async {
  Completer<ImageSource> completer = Completer<ImageSource>();
  await SmartDialog.show(
    clickMaskDismiss: false,
    backDismiss: true,
    alignment: Alignment.center,
    builder: (_) => DecoratedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Txt('Pick image'.tr, fontWeight: FontWeight.w800, fontSize: 18, color: Get.theme.primaryColor),
          vSpace32,
          Txt('Choose the image source.'.tr, fontSize: 16),
          vSpace32,
          Row(
            children: [
              Expanded(
                  child: InkWell(
                      onTap: () {
                        completer.complete(ImageSource.camera);
                        Get.back();
                      },
                      child: Txt('Camera'.tr, fontWeight: FontWeight.bold, color: Get.theme.primaryColor))),
              Expanded(
                  child: InkWell(
                      onTap: () {
                        completer.complete(ImageSource.gallery);
                        Get.back();
                      },
                      child: Txt('Gallery'.tr, fontWeight: FontWeight.bold, color: Get.theme.primaryColor))),
            ],
          ),
        ],
      ),
    ),
  );

  return completer.future;
}
//Hello
showConfirmationDialog({String? msg, String? fullMsg, required Function function}) {
  SmartDialog.show(
    clickMaskDismiss: false,
    backDismiss: true,
    alignment: Alignment.center,
    builder: (_) => DecoratedContainer(
      width: Get.context!.responsiveValue<double>(mobile: Get.width * 0.7, tablet: Get.width * 0.7, desktop: Get.width * 0.5),
      height: Get.context!.responsiveValue<double>(mobile: Get.width * 0.8, tablet: Get.width * 0.7, desktop: Get.width * 0.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Txt('Caution'.tr, fontWeight: FontWeight.w800, fontSize: 18, color: Get.theme.primaryColor),
          vSpace32,
          Expanded(child: Txt(msg != null ? 'Are you sure you want to'.tr + msg.tr : fullMsg ?? 'Are you sure?'.tr, fontSize: 16)),
          Row(
            children: [
              Expanded(
                  child: InkWell(
                      onTap: () {
                        function.call();
                        Get.back();
                      },
                      child: Txt('Yes'.tr, fontWeight: FontWeight.bold, color: Get.theme.primaryColor))),
              Expanded(
                  child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Txt('No'.tr, fontWeight: FontWeight.bold, color: Get.theme.primaryColor))),
            ],
          ),
        ],
      ),
    ),
  );
}

void showPopupMenu(BuildContext context, Map<String, Function> items) async {
  await showMenu(
    context: context,
    position: const RelativeRect.fromLTRB(100, 100, 100, 100),
    items: [
      const PopupMenuItem(
        child: Text("View"),
      ),
      const PopupMenuItem(
        child: Text("Edit"),
      ),
      const PopupMenuItem(
        child: Text("Delete"),
      ),
    ],
    elevation: 8.0,
  );
}

void hideKeyboard(BuildContext context) {
  FocusManager.instance.primaryFocus?.unfocus();
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}

bool isArabic(String text) {
  if (text.isNullOrWhiteSpace) return false;
  // RegExp regExp = new RegExp("/[\u0600-\u06FF]/");
  // print('text $text is ${regExp.allMatches(text)}');

  // print('arabicCharacters =${jsonEncode(arabicCharacters)}');
  return text.anyChar((element) => arabicCharacters.contains(element));
  // print('Result = $x');

  // return regExp.hasMatch(text);
}

bool isValid(String text, [int n = 10]) {
  return text.length >= n;
}

final logger = Logger(
  printer: PrettyPrinter(
      noBoxingByDefault: true,
      methodCount: 2,
      // number of method calls to be displayed
      errorMethodCount: 8,
      // number of method calls if stacktrace is provided
      lineLength: 1000,
      // width of the output
      colors: true,
      // Colorful log messages
      printEmojis: true,
      // Print an emoji for each log message
      printTime: false // Should each log print contain a timestamp
      ),
);

const mShowToast = SmartDialog.showToast;
const mShowLoading = SmartDialog.showLoading;
const mShowAttach = SmartDialog.showAttach;
const mShowDialog = SmartDialog.show;
const mHide = SmartDialog.dismiss;

void mPrint(s) {
  if (foundation.kDebugMode) {
    logger.i('$s');
  }
}

void mPrintError(s) {
  if (foundation.kDebugMode) {
    logger.e('$s');
  }
}

///region Helpers Functions

/// Converts field name to CamelCase format
String toCamelCase(String? fieldName) => fieldName != null
    ? fieldName.length == 1
    ? fieldName.toUpperCase()
    : fieldName.substring(0, 1).toUpperCase() + fieldName.substring(1)
    : '';

/// Converts field name to camelCase format
String tocamelCase(String? fieldName) => fieldName != null
    ? fieldName.length == 1
    ? fieldName.toLowerCase()
    : fieldName.substring(0, 1).toLowerCase() + fieldName.substring(1)
    : '';

/// Convert singular field name to plural format
String toPluralName(String s) => s.endsWith('y')
    ? '${s.substring(0, s.length - 1)}ies'
    : (s.endsWith('s') || s.endsWith('o '))
    ? '${s}es'
    : '${s}s';

/// Convert field name to lowercase plural format
String toPluralLowerName(String s) => s.endsWith('y')
    ? '${s.substring(0, s.length - 1).toLowerCase()}ies'
    : (s.endsWith('s') || s.endsWith('o '))
    ? '${s.toLowerCase()}es'
    : '${s.toLowerCase()}s';

/// Convert field name to singular format
String toSingularName(String s) => s.endsWith('ies')
    ? '${s.substring(0, s.length - 3)}y'
    : s.endsWith('ses') || s.endsWith('oes')
    ? s.substring(0, s.length - 2)
    : s.endsWith('s')
    ? s.substring(0, s.length - 1)
    : s;

/// Convert field name to lowercase singular format
String toSingularLowerName(String s) => toSingularName(s).toLowerCase();

/// Set model name by defined if the model name set null
String toModelName(String? modelName, String definedName) =>
    modelName == null || modelName.isEmpty ? toCamelCase(toSingularName(definedName)) : toCamelCase(modelName);


///endregion