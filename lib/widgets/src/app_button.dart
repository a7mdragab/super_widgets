import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'txt.dart';

class AppButton extends StatelessWidget {
  final String txt;
  final VoidCallback onPressed;
  final double verPadding;
  final double fontSize;
  final Color fillColor;
  const AppButton({
    Key? key,
    required this.onPressed,
    required this.txt,
    this.verPadding = 16,
    this.fontSize = 19,
    this.fillColor=const Color(0xFFaaaaaa),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
            elevation: MaterialStateProperty.all(4),
            shadowColor: MaterialStateProperty.all(Colors.grey[400]),
            backgroundColor: MaterialStateProperty.all(fillColor),
            padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(vertical: verPadding, horizontal: verPadding * 4),
            )),
        onPressed: () {
          FocusScope.of(context).unfocus();
          onPressed.call();
        },
        child: Txt(
          txt,
          color: Get.theme.primaryColor,
          fontWeight: FontWeight.w600,
          fontSize: fontSize,
        ));
  }
}
