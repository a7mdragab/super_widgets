import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:dart_extensions/dart_extensions.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'txt.dart';

import '../../utils/helpers.dart';

// import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SuperEditText extends StatefulWidget {
  final TextEditingController? eController;
  final String eHint;
  final String? eAsset;

  final Widget? suffixWidget;
  final String? suffixText;
  final IconData? prefixIconData;
  final IconData? postfixIcon;
  final Widget? prefixWidget;
  final String? postfixAsset;

  final bool enableRTL;
  final bool obscureText;

  final Function? ontap;

  final bool enableValidate = true;

  final void Function()? onSubmitted;
  final List<String? Function(String?)>? validators;

  final bool enabled;

  final int? maxLines;

  final void Function(String?)? onChanged;

  final TextInputType keyboardType;
  final TextInputAction? textInputAction;

  final Color fillColor;

  const SuperEditText(
    this.eController, {
    super.key,
    this.eHint = '',
    this.eAsset,
    this.fillColor = Colors.white,
    this.keyboardType = TextInputType.text,
    this.textInputAction,
    this.prefixIconData,
    this.prefixWidget,
    this.postfixAsset,
    this.postfixIcon,
    this.suffixWidget,
    this.suffixText,
    this.maxLines = 1,
    this.onChanged,
    this.ontap,
    this.enabled = true,
    this.onSubmitted,
    this.obscureText = false,
    this.enableRTL = false,
    this.validators,
  });

  @override
  SuperEditTextState createState() => SuperEditTextState();
}

class SuperEditTextState extends State<SuperEditText> {
  bool isValid = false;
  bool isObscured = false;

  @override
  void initState() {
    isObscured = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Get.theme,
      child: Directionality(
        textDirection: isArabic(widget.eController!.text) || widget.enableRTL ? TextDirection.rtl : TextDirection.ltr,
        child: FormBuilderTextField(
          // showCursor: true,
          name: widget.eHint,
          enabled: widget.enabled,
          maxLines: widget.maxLines,
          // autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: widget.eController,
          obscureText: isObscured,
          textInputAction: widget.textInputAction,

          onChanged: (s) {
            widget.onChanged?.call(s);
            setState(() {});
          },
          // style: const TextStyle(fontSize: 14),
          readOnly: widget.ontap != null,
          onSubmitted: widget.onSubmitted == null
              ? null
              : (s) {
                  widget.onSubmitted?.call();
                },
          onTap: () {
            if (widget.eController!.selection == TextSelection.fromPosition(TextPosition(offset: widget.eController!.text.length - 1))) {
              setState(() {
                widget.eController!.selection = TextSelection.fromPosition(TextPosition(offset: widget.eController!.text.length));
              });
            }
          },

          decoration: const InputDecoration().applyDefaults(Get.theme.inputDecorationTheme).copyWith(
                hintStyle: context.textTheme.labelLarge!.copyWith(color: Colors.grey),
                floatingLabelStyle: context.textTheme.titleSmall!.copyWith(color: context.theme.primaryColor),
                labelStyle: context.textTheme.bodyLarge!.copyWith(color: context.theme.primaryColor),
                fillColor: widget.fillColor,
                suffixText: widget.suffixText,
                labelText: widget.eHint,
                hintText: widget.eHint,
                // prefixIconConstraints: BoxConstraints.tightForFinite(width: 30),
                prefixIcon: widget.prefixIconData == null
                    ? widget.prefixWidget
                    : Icon(
                        widget.prefixIconData,
                        color: context.theme.primaryColor,
                      ),

                suffixIcon: widget.suffixWidget ??
                    (widget.obscureText
                        ? (IconButton(
                            onPressed: () {
                              isObscured = !isObscured;
                              setState(() {});
                            },
                            // icon: Icon(isObscured ? Icons.remove_red_eye : Icons.remove_red_eye_outlined),
                            icon: Icon(isObscured ? Icons.lock_open_rounded : Icons.lock_rounded),
                          ))
                        : (widget.suffixText == null
                            ? widget.eController!.text.isNullOrWhiteSpace
                                ? null
                                : IconButton(
                                    onPressed: widget.eController!.clear,
                                    icon: const Icon(Icons.close),
                                  )
                            : Txt(widget.suffixText))),
                // enabledBorder: OutlineInputBorder(
                //     borderSide: BorderSide(color: ThemeController.to.currentColors!.primary), borderRadius: BorderRadius.circular(widget.borderRadius)),
                // focusedBorder: OutlineInputBorder(
                //     borderRadius: BorderRadius.circular(widget.borderRadius),
                //     borderSide: BorderSide(color: ThemeController.to.currentColors!.primaryContainer, width: 1)),
                // suffixIconConstraints: const BoxConstraints.tightForFinite(width: 30),
              ),
          textDirection: isArabic(widget.eController!.text) || widget.enableRTL ? TextDirection.rtl : TextDirection.ltr,
          textAlign: isArabic(widget.eController!.text) || widget.enableRTL ? TextAlign.right : TextAlign.left,
          validator: FormBuilderValidators.compose(widget.validators ?? []),
          keyboardType: widget.keyboardType,
        ),
      ),
    );
  }
}
