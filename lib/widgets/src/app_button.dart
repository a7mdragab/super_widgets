import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'txt.dart';

class AppButton extends StatelessWidget {
  final String txt;
  final VoidCallback onPressed;
  final double verPadding;
  final double fontSize;
  final double borderRadius;
  final double elevation;
  final Color? fillColor;
  final Color? txtColor;
  final Color? shadowColor;
  final Size? size;

  const AppButton(
      {Key? key,
      required this.onPressed,
      required this.txt,
      this.verPadding = 16,
      this.size,
      this.fontSize = 19,
      this.borderRadius = 16,
      this.elevation = 4,
      this.fillColor,
      this.txtColor,
      this.shadowColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: ButtonStyle(
            fixedSize: MaterialStateProperty.all(size),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius))),
            elevation: MaterialStateProperty.all(elevation),
            shadowColor: MaterialStateProperty.all(shadowColor ?? Colors.grey[900]),
            backgroundColor: MaterialStateProperty.all(fillColor),
            padding: size != null
                ? null
                : MaterialStateProperty.all(
                    EdgeInsets.symmetric(vertical: verPadding, horizontal: verPadding * 4),
                  )),
        onPressed: () {
          FocusScope.of(context).unfocus();
          onPressed.call();
        },
        child: Txt(
          txt,
          textAlign: TextAlign.center,
          color: txtColor ?? Get.theme.primaryColor,
          fontWeight: FontWeight.w600,
          fontSize: fontSize,
        ));
  }
}
