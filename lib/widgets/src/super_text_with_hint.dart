import 'package:flutter/material.dart';

import 'package:dart_extensions/dart_extensions.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SuperTextWithHint extends StatelessWidget {
  final String hint;
  final String eText;
  final Color? color;

  const SuperTextWithHint(this.eText, this.hint, {super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Text.rich(TextSpan(children: [
        TextSpan(
          text: eText,
          style: context.textTheme.displayMedium,
        ),
        TextSpan(text: hint, style: context.textTheme.bodyMedium),
      ])),
    );
  }
}
