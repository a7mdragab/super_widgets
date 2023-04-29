import 'package:dart_extensions/dart_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ready_extensions/ready_extensions.dart';
import 'package:super_widgets/home/home.dart';
import 'package:super_widgets/utils/helpers.dart';

//ignore: must_be_immutable
class SuperPanel extends StatelessWidget {
  final String title;
  final Widget child;
  final bool enableRTL;
  final double bottomMargin;
  late EdgeInsets contentPadding;
  bool hasError;
  Color fillColor = Colors.transparent;

  SuperPanel({
    required this.child,
    this.title = '',
    this.fillColor = Colors.transparent,
    this.hasError = false,
    this.bottomMargin = 8,
    contentPadding,
    this.enableRTL = false,
    super.key,
  }) {
    this.contentPadding = contentPadding ?? const EdgeInsets.all(16);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ((title.isNullOrEmptyOrWhiteSpace ? false : isArabic(title)) && LanguageService.to.isArabic) || enableRTL ? TextDirection.rtl : TextDirection.ltr,
      child: Container(
        margin: EdgeInsets.only(bottom: bottomMargin),
        child: FocusScope(
          debugLabel: 'Scope',
          autofocus: true,
          child: Focus(
            child: Builder(builder: (context) {
              final FocusNode focusNode = Focus.of(context);
              final bool hasFocus = focusNode.hasFocus;
              return GestureDetector(
                onTap: focusNode.requestFocus,
                child: InputDecorator(
                    isFocused: hasFocus,
                    textAlign: LanguageService.to.textAlign,
                    decoration: const InputDecoration().applyDefaults(context.theme.inputDecorationTheme).copyWith(
                          contentPadding: contentPadding,
                          fillColor: fillColor,
                          labelStyle: TextStyle(color: hasError ? Colors.red : (hasFocus ? Colors.blue : Colors.black)),
                          labelText: title.tr,
                        ),
                    child: child),
              );
            }),
          ),
        ),
      ),
    );
  }
}
