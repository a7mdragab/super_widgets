import 'package:flutter/material.dart';

import 'package:dart_extensions/dart_extensions.dart';
import 'package:get/get.dart';

class GredientButton extends StatelessWidget {
  String txt = '';
  double? fontSize;
  FontWeight? fontWeight;
  Color? color;
  Widget? ch;

  TextAlign? tAlign;

  GredientButton(
    this.ch, {
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * 0.3,
      height: context.width * 0.3,
      decoration: BoxDecoration(
          color: (color)!.withOpacity(0.5),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.5),
              spreadRadius: 10,
              blurRadius: 15,
              offset: Offset(0, 5), // changes position of shadow
            )
          ],
          border: Border.all(color: Colors.white),
          shape: BoxShape.circle),
      child: Center(child: ch ?? Container()),
    );
  }
}
