import 'package:flutter/material.dart';
import 'package:get/get.dart';

//ignore: must_be_immutable
class SuperPanel extends StatelessWidget {
  final String title;
  final Widget child;
  final bool enableRTL;
  late EdgeInsets contentPadding;
  bool hasError;
  Color fillColor = Colors.transparent;

  SuperPanel({
    required this.child,
    this.title = '',
    this.fillColor = Colors.transparent,
    this.hasError = false,
    contentPadding,
    this.enableRTL = false,
    super.key,
  }) {
    this.contentPadding = contentPadding ?? const EdgeInsets.all(16);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: enableRTL ? TextDirection.rtl : TextDirection.ltr,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
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
                    decoration: const InputDecoration().applyDefaults(context.theme.inputDecorationTheme).copyWith(
                          isDense: true,
                          alignLabelWithHint: true,
                          contentPadding: contentPadding,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          filled: true,
                          fillColor: fillColor,
                          labelStyle: TextStyle(color: hasError ? Colors.red : (hasFocus ? Colors.blue : Colors.black)),
                          labelText: title,
                          // label: Row(
                          //   mainAxisSize: MainAxisSize.min,
                          //   children: [
                          //     // Image.asset('assets/images/docker_icon.svg',
                          //     //     height: 24, width: 24),
                          //     // const SizedBox(width: 8),
                          //     Text(title ?? '')
                          //   ],
                          // ),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(2), borderSide: BorderSide(color: hasError ? Colors.red : Colors.grey)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(2), borderSide: BorderSide(color: hasError ? Colors.red : Colors.grey)),
                          // : (hasFocus ? Colors.blue : Colors.grey))),
                          // errorBorder: OutlineInputBorder(
                          //     borderRadius: BorderRadius.circular(4),
                          //     borderSide:
                          //         const BorderSide(color: Colors.red, width: 2)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(2), borderSide: BorderSide(color: hasError ? Colors.red : Colors.blue)),
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
