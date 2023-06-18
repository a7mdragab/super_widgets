import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';
import 'super_decorated_container.dart';
import 'txt.dart';

class SuperLabeledCheckbox extends StatelessWidget {
  const SuperLabeledCheckbox({
    this.title,
    this.titleWidget,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
    this.value = false,
    this.onChanged,
    this.activeColor,
    this.txtColor,
    this.fontSize,
    this.gap = 4.0,
    this.bold = false,
    this.enabled = true,
    this.borderRadius,
    this.borderWidth,
    this.borderColor,
    this.border,
    super.key,
  });

  final String? title;
  final Widget? titleWidget;
  final EdgeInsets contentPadding;
  final bool value;
  final Function(bool)? onChanged;
  final Color? activeColor;
  final Color? txtColor;
  final double? fontSize;
  final double gap;
  final bool bold;
  final bool enabled;

  final BoxBorder? border;
  final double? borderRadius;
  final double? borderWidth;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    // Color? activeColor = this.activeColor?? Get.theme.checkboxTheme.checkColor;
    return GestureDetector(
      onTap: enabled ? () => onChanged?.call(!value) : null,
      child: SuperDecoratedContainer(
        padding: contentPadding,
        border: border,
        borderRadius: borderRadius,
        borderWidth: borderWidth,
        borderColor: borderColor,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Checkbox(
              value: value,
              activeColor: activeColor,
              visualDensity: VisualDensity.compact,
              onChanged: enabled ? (val) => onChanged?.call(val ?? false) : null,
            ),
            hSpace(gap),
            Flexible(
              child: titleWidget ??
                  Txt(
                    title,
                    color: txtColor,
                    fontSize: fontSize,
                    fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
