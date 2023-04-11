import 'dart:async';
import 'dart:io';

import 'package:crypt/crypt.dart';
import 'package:dart_extensions/dart_extensions.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:root/root.dart';
import 'package:super_widgets/super_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

Future<String> getPlatformVersion() async {
  if (Platform.isAndroid) {
    var androidInfo = await DeviceInfoPlugin().androidInfo;
    var sdkInt = androidInfo.version.sdkInt;
    return 'Android-$sdkInt';
  }

  if (Platform.isIOS) {
    var iosInfo = await DeviceInfoPlugin().iosInfo;
    var systemName = iosInfo.systemName;
    var version = iosInfo.systemVersion;
    return '$systemName-$version';
  }

  return 'Unknown';
}

Future<bool> isRooted() async {
  try {
    if (GetPlatform.isIOS) return false;
    return (await Root.isRooted()) ?? false;
  } on Exception catch (e) {
    mPrintError('Exception $e');
    return false;
  }
}

Future<bool> isAndroidRealDevice() async {
  if (GetPlatform.isAndroid) return ((await getAndroidDeviceInfo()).isPhysicalDevice);
  return false;
}

Future<bool> isIosRealDevice() async {
  if (GetPlatform.isIOS) return ((await getIOSDeviceInfo()).isPhysicalDevice);
  return false;
}

Future<bool> isRealMobileDevice() async {
  return (kDebugMode || (await isRealMobileDeviceOnly()));
}

Future<bool> isRealMobileDeviceOnly() async {
  return ((await isAndroidRealDevice()) || (await isIosRealDevice()));
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

Future<AndroidDeviceInfo> getAndroidDeviceInfo() async => await DeviceInfoPlugin().androidInfo;

Future<IosDeviceInfo> getIOSDeviceInfo() async => await DeviceInfoPlugin().iosInfo;

Future<WebBrowserInfo> getWebBrowserInfo() async => await DeviceInfoPlugin().webBrowserInfo;

Future<WindowsDeviceInfo> getWindowsBrowserInfo() async => await DeviceInfoPlugin().windowsInfo;

Future<LinuxDeviceInfo> getLinuxInfo() async => await DeviceInfoPlugin().linuxInfo;

Future<String> getAndroidDeviceID() async {
  String? deviceId = await PlatformDeviceId.getDeviceId;
  AndroidDeviceInfo info = await getAndroidDeviceInfo();
  return ('${info.id}_${info.device}_$deviceId');
}

Future<String> getIOSDeviceID() async {
  String? deviceId = await PlatformDeviceId.getDeviceId;
  IosDeviceInfo info = await getIOSDeviceInfo();
  return ('${info.identifierForVendor}_$deviceId');
}

Future<String> getMobileDeviceID() async {
  if (GetPlatform.isAndroid) {
    return await getAndroidDeviceID();
  } else if (GetPlatform.isIOS) {
    return await getIOSDeviceID();
  }
  mPrintError('Not a mobile');
  return 'Not a mobile';
}

String getYoutubeVideoThumbnail(String videoUrl) {
  String vidID = videoUrl.substring(videoUrl.indexOf('?v=') + 3);
  return 'https://img.youtube.com/vi/$vidID/0.jpg';
}

Future<bool> launchStringURL(String link, {LaunchMode mode = LaunchMode.platformDefault}) async {
  try {
    await launchUrl(Uri.parse(link), mode: mode);
    return true;
  } on Exception catch (e) {
    mPrintError('Could not launch $link');
    return false;
  }
}

String _getWhatsNum(String phone) {
  String num = phone.replaceAll(' ', '');
  // String num = phone.replaceAll('+', '').replaceAll(' ', '');
  for (int I = 0; I < num.length; I++) {
    if (num[0] == '0') {
      num = num.substring(1);
    }
  }
  return num;
}

Future<bool> launchWhatsApp(String phone, [String msg = 'Hello']) async {
  String num = _getWhatsNum(phone);
  String url = '';
  if (GetPlatform.isAndroid) {
    url = "whatsapp://send?phone=$num&text=$msg";
    // url = Uri.encodeFull("https://wa.me/${num}?text=${(msg)}");
  } else {
    url = "https://api.whatsapp.com/send?phone=$num&text=${Uri.encodeFull(msg)}";
  }
  // url="https://api.whatsapp.com/send/?phone=Uri.encodeComponent(phone)&text=Hello&type=phone_number&app_absent=0";
  return await launchStringURL(url);
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

Future<ImageSource?> showImagePickerDialog() async {
  Completer<ImageSource?> completer = Completer<ImageSource?>();
  await SmartDialog.show(
    clickMaskDismiss: true,
    backDismiss: true,
    alignment: Alignment.center,
    builder: (_) => SuperDecoratedContainer(
      color: Colors.white,
      borderRadius: 24,
      width: Get.context!.responsiveValue<double>(mobile: Get.width, tablet: Get.width * 0.9, desktop: Get.width * 0.7),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Align(
            alignment: LanguageService.to.alignment,
            child: IconButton(
                icon: const Icon(Icons.close, color: Colors.red),
                onPressed: () {
                  completer.complete(null);
                  mHide();
                }),
          ),
          Txt('Pick image'.tr, fontWeight: FontWeight.w800, fontSize: 18, color: Get.theme.primaryColor),
          vSpace24,
          Txt('Choose the image source'.tr, fontSize: 16),
          vSpace8,
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              textDirection: LanguageService.to.isArabic ? TextDirection.rtl : TextDirection.ltr,
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.lightGreen)),
                    label: const Txt('Camera', color: Colors.white),
                    icon: const Icon(Icons.camera_alt, color: Colors.white),
                    onPressed: () {
                      completer.complete(ImageSource.camera);
                      mHide();
                    },

                    // child: InkWell(
                    //   onTap: () {
                    //     completer.complete(ImageSource.camera);
                    //     mHide();
                    //   },
                    //   child: const SuperDecoratedContainer(
                    //     borderRadius: 16,
                    //     padding: EdgeInsets.all(8),
                    //     color: Colors.lightGreen,
                    //     child: Center(child: Txt('Camera', color: Colors.white)),
                    //   ),
                    // ),
                  ),
                ),
                hSpace16,
                Expanded(
                  child: ElevatedButton.icon(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
                    label: const Txt('Gallery', color: Colors.white),
                    icon: const Icon(Icons.image, color: Colors.white),
                    onPressed: () {
                      completer.complete(ImageSource.gallery);
                      mHide();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  return completer.future;
}

void showConfirmationDialog({String? msg, String? fullMsg, TextDirection? textDirection, required Function function}) {
  SmartDialog.show(
    clickMaskDismiss: false,
    backDismiss: true,
    alignment: Alignment.center,
    builder: (_) => SuperDecoratedContainer(
      color: Colors.white,
      borderRadius: 24,
      width: Get.context!.responsiveValue<double>(mobile: Get.width, tablet: Get.width * 0.7, desktop: Get.width * 0.5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Align(
            alignment: LanguageService.to.alignment,
            child: const IconButton(icon: Icon(Icons.close, color: Colors.red), onPressed: mHide),
          ),
          Txt('Note'.tr, fontWeight: FontWeight.w800, fontSize: 22, color: Get.theme.primaryColor),
          vSpace24,
          Center(child: Txt(msg != null ? 'Are you sure you want to '.tr + msg.tr : fullMsg ?? 'Are you sure?'.tr, textDirection: textDirection, textAlign: TextAlign.center, fontSize: 16)),
          vSpace8,
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              textDirection: LanguageService.to.isArabic ? TextDirection.rtl : TextDirection.ltr,
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.lightGreen),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
                    ),
                    label: const Txt('Yes', color: Colors.white),
                    icon: const Icon(Icons.done, color: Colors.white),
                    onPressed: () {
                      mHide();
                      function();
                    },
                  ),
                ),
                hSpace16,
                Expanded(
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
                    ),
                    label: const Txt('No', color: Colors.white),
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      mHide();
                    },
                  ),
                ),
              ],
            ),
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

void hideKeyboard(BuildContext? context) {
  FocusManager.instance.primaryFocus?.unfocus();
  if (context != null) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    currentFocus.requestFocus(FocusNode());
  }
}

bool isArabic(String text) {
  if (text.isNullOrWhiteSpace) return false;
  return text.anyChar((element) => arabicCharacters.contains(element));
}

const mShowToast2 = SmartDialog.showToast;
const mShowLoading2 = SmartDialog.showLoading;
const mShowAttach = SmartDialog.showAttach;
const mShowDialog = SmartDialog.show;
const mHide = SmartDialog.dismiss;

class CustomToast extends StatelessWidget {
  const CustomToast(this.msg,
      {this.alignment,
      this.color = Colors.black87,
      this.txtColor = Colors.white,
      this.margin = const EdgeInsets.only(bottom: 30, top: 30),
      this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      Key? key})
      : super(key: key);
  final AlignmentGeometry? alignment;
  final String msg;
  final Color? color, txtColor;
  final EdgeInsets? margin, padding;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment ?? Alignment.center,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 0.9.w),
        child: SuperDecoratedContainer(
          borderRadius: 16,
          // margin: margin,
          padding: padding,
          color: color,
          child: Txt(
            msg,
            color: txtColor,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

bool get isDialogShown => SmartDialog.config.isExist;

void mShowDialog2({required Widget Function(BuildContext) builder}) {
  showDialog(context: Get.context!, builder: builder);
}

void mShowLoading(
    {String msg = 'loading...',
    SmartDialogController? controller,
    AlignmentGeometry? alignment,
    bool? clickMaskDismiss,
    SmartAnimationType? animationType,
    List<SmartNonAnimationType>? nonAnimationTypes,
    Widget Function(AnimationController, Widget, AnimationParam)? animationBuilder,
    bool? usePenetrate,
    bool? useAnimation,
    Duration? animationTime,
    Color? maskColor,
    Widget? maskWidget,
    VoidCallback? onDismiss,
    VoidCallback? onMask,
    Duration? displayTime,
    bool? backDismiss,
    WidgetBuilder? builder}) {
  SmartDialog.showLoading(
      msg: msg.tr,
      alignment: alignment,
      animationBuilder: animationBuilder,
      animationTime: animationTime,
      animationType: animationType,
      backDismiss: backDismiss,
      builder: builder,
      clickMaskDismiss: clickMaskDismiss,
      controller: controller,
      displayTime: displayTime,
      maskColor: maskColor,
      maskWidget: maskWidget,
      nonAnimationTypes: nonAnimationTypes,
      onDismiss: onDismiss,
      onMask: onMask,
      useAnimation: useAnimation,
      usePenetrate: usePenetrate);
}

void mShowToast(String msg,
    {Color? color = Colors.black87,
    Color? txtColor = Colors.white,
    EdgeInsets? margin = const EdgeInsets.only(bottom: 30, top: 30),
    EdgeInsets? padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    SmartDialogController? controller,
    Duration? displayTime,
    AlignmentGeometry? alignment,
    bool? clickMaskDismiss,
    SmartAnimationType? animationType,
    bool? usePenetrate,
    bool? useAnimation,
    Duration? animationTime,
    Color? maskColor,
    Widget? maskWidget,
    bool? consumeEvent,
    bool? debounce,
    SmartToastType? displayType}) {
  mShowToast2(msg.tr,
      alignment: alignment,
      controller: controller,
      animationTime: animationTime,
      animationType: animationType,
      clickMaskDismiss: clickMaskDismiss,
      consumeEvent: consumeEvent,
      debounce: debounce,
      displayType: displayType,
      displayTime: displayTime,
      maskColor: maskColor,
      maskWidget: maskWidget,
      useAnimation: useAnimation,
      usePenetrate: usePenetrate, builder: (context) {
    return CustomToast(msg, color: color, alignment: alignment, padding: padding, margin: margin, txtColor: txtColor);
  });
}

final logger = Logger(
  printer: PrettyPrinter(
      noBoxingByDefault: true,
      stackTraceBeginIndex: 0,
      methodCount: 3,
      // number of method calls to be displayed
      errorMethodCount: 5,
      // number of method calls if stacktrace is provided
      lineLength: 3000,
      // width of the output
      colors: true,
      // Colorful log messages
      printEmojis: true,
      // Print an emoji for each log message
      printTime: false // Should each log print contain a timestamp
      ),
);

void mPrint(s) {
  // SmartDialog.showToast('',)
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
String toModelName(String? modelName, String definedName) => modelName == null || modelName.isEmpty ? toCamelCase(toSingularName(definedName)) : toCamelCase(modelName);

///endregion

bool isDateInRange(DateTime start, DateTime end, DateTime date) {
  return ((date == start || date.isAfter(start)) && (date == end || date.isBefore(end)));
}

DateTime getDateOnly(DateTime dateTime) {
  List<String> partsStart = dateTime.toString().split(" ").first.split("-");
  return DateTime.parse("${partsStart.first}-${partsStart[1].padLeft(2, '0')}-${partsStart[2].padLeft(2, '0')} 00:00:00.000");
}

String formatDurationTime(Duration duration) {
  String hours = duration.inHours.toString().padLeft(0, '2');
  String minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
  String seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
  return "$hours:$minutes:$seconds";
}

PackageInfo? packageInfo;

Future<String?> getAppVersionNum() async {
  packageInfo ??= await PackageInfo.fromPlatform();
  return packageInfo?.version;
}

Future<String?> getAppBuildNum() async {
  packageInfo ??= await PackageInfo.fromPlatform();
  return packageInfo?.buildNumber;
}
