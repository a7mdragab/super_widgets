import 'package:dart_extensions/dart_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/helpers.dart';

class TxtManager {
  static Color defaultColor = Get.theme.primaryColorLight;
}

class Txt extends StatelessWidget {
  final FontStyle? fontStyle;
  final FontWeight? fontWeight;
  final int? maxLines;
  final double? fontSize;
  final double? letterSpacing;
  final Color? color;
  final TextAlign? textAlign;
  final bool useOverflow;
  final bool upperCaseFirst;
  final bool useQuotes;
  final bool useFiler;
  final bool underlined;
  final double underlineHeight;
  final bool fullUpperCase;
  final bool fullLowerCase;
  final TextDecoration? decoration;
  final TextDecorationStyle? decorationStyle;
  final Color? decorationColor;
  final double? decorationThikness;
  final List<Shadow>? shadows;
  final dynamic text;
  final String? fontFamily;
  final TextStyle? textStyle;
  final TextDirection? textDirection;

  const Txt(
    this.text, {
    Key? key,
    this.textStyle,
    this.fontStyle,
    this.fontWeight,
    this.maxLines,
    this.fontSize,
    this.color,
    this.decoration,
    this.decorationStyle,
    this.decorationColor,
    this.shadows,
    this.underlineHeight = 1,
    this.decorationThikness = 1,
    this.textAlign,
    this.letterSpacing,
    this.textDirection,
    this.useOverflow = false,
    this.upperCaseFirst = false,
    this.useQuotes = false,
    this.useFiler = false,
    this.underlined = false,
    this.fullUpperCase = false,
    this.fullLowerCase = false,
    this.fontFamily,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String finalText = "Null";
    bool isString = text is String;
    bool isNumber = text is double || text is int;
    bool isOthers = isString == false && isNumber == false;

    if (isString) {
      finalText = text ?? "";
    } //when you forgot to set a value, "Error" will be shown
    if (isNumber) finalText = '$text';
    if (isOthers) finalText = "$text";

//John → john
    if (fullLowerCase) finalText = finalText.toLowerCase();

//John → JOHN
    if (fullUpperCase) finalText = finalText.toUpperCase();

//JOHN or john → John
    if (upperCaseFirst && finalText.length > 1) {
      finalText = "${finalText[0].toUpperCase()}${finalText.substring(1, finalText.length).toLowerCase()}";
    }

//John → "John"
    if (useQuotes) finalText = "❝$finalText❞";

//John*_-#![] → John
    if (useFiler) {
      finalText = finalText.replaceAll("*", "").replaceAll("_", "").replaceAll("-", "").replaceAll("#", "").replaceAll("\n", "").replaceAll("!", "").replaceAll('[', '').replaceAll(']', '');
    }

    return Text(
      finalText == 'null'
          ? 'N/A'
          : isArabic(finalText)
              ? finalText.tr
              : isArabic(finalText.removeAllWhitespace.tr)
                  ? finalText.removeAllWhitespace.tr
                  : finalText.tr,
      overflow: useOverflow ? TextOverflow.ellipsis : null,
      textAlign: textAlign,
      maxLines: maxLines,
      softWrap: true,
      textScaleFactor: 1,
      textDirection: textDirection ?? (isArabic(finalText) ? TextDirection.rtl : TextDirection.ltr),
      // style: (textStyle ?? context.textTheme.bodyLarge ?? const TextStyle()).copyWith(
      style: (textStyle ?? const TextStyle()).copyWith(
        decoration: decoration ?? (underlined ? TextDecoration.underline : null),
        decorationStyle: decorationStyle,
        decorationColor: decorationColor,
        decorationThickness: decorationThikness,
        color: underlined ? Colors.transparent : (color ?? TxtManager.defaultColor),
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        fontFamily: fontFamily,
        letterSpacing: letterSpacing,
        shadows: shadows ??
            (underlined
                ? [
                    Shadow(offset: Offset(0, -1 * underlineHeight), color: color ?? Colors.black),
                  ]
                : null),
      ),
    );
  }
}
