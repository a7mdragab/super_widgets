import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:dart_extensions/dart_extensions.dart';
import 'package:get/get.dart';

import 'super_text_with_hint.dart';
import 'txt.dart';

class Section_View extends StatelessWidget {
  String headerTxt = '';
  Widget widget1;
  Widget? widget2;
  FontWeight? fontWeight = FontWeight.bold;

  bool _isWithHint = false;
  String word = '(إختياري)';
  int _ind = -1;

  Section_View(this.headerTxt, this.widget1, [this.widget2, this.fontWeight]) {
    _ind = headerTxt.indexOf(word);
    _isWithHint = (_ind != -1);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (_isWithHint)
            SuperTextWithHint(headerTxt.substring(0, _ind), word)
          else
            Txt(
              headerTxt,
              textStyle: context.textTheme!.displayMedium,
            ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: widget1),
              if (widget2 != null) ...[
                const SizedBox(width: 6),
                Expanded(child: widget2!),
              ],
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
