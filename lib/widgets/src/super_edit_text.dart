import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:dart_extensions/dart_extensions.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:super_widgets/home/home.dart';
import 'package:super_widgets/home/src/theme/theme_service.dart';
import 'txt.dart';

import '../../utils/helpers.dart';

// import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SuperEditText extends StatefulWidget {
  final TextEditingController? eController;
  final String hint;
  final String? eLabel;
  final String? eAsset;

  final Widget? suffixWidget;
  final String? suffixText;
  final IconData? prefixIconData;
  final IconData? postfixIcon;
  final Widget? prefixWidget;
  final String? postfixAsset;

  final bool enableRTL;
  final bool obscureText;

  final void Function()? ontap;

  final bool enableValidate = true;

  final void Function()? onSubmitted;
  final List<String? Function(String?)>? validators;

  final bool enabled;
  final AutovalidateMode autovalidateMode;

  final int? maxLines;

  final void Function(String?)? onChanged;

  final TextInputType keyboardType;
  final TextInputAction? textInputAction;

  final EdgeInsets? contentPadding;

  final Color fillColor;

  final TextDirection? textDirection;
  final TextAlign? textAlign;

  const SuperEditText(
    this.eController, {
    super.key,
    this.hint = '',
    this.eLabel,
    this.eAsset,
    this.fillColor = Colors.white,
    this.keyboardType = TextInputType.text,
    this.textAlign,
    this.textDirection,
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
    this.contentPadding,
    this.autovalidateMode = AutovalidateMode.disabled,
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
    return Directionality(
      textDirection: widget.textDirection ?? (LanguageService.to.isArabic || isArabic(widget.eController!.text) || widget.enableRTL ? TextDirection.rtl : TextDirection.ltr),
      child: FormBuilderTextField(
        // showCursor: true,
        name: widget.hint,
        enabled: widget.enabled,
        maxLines: widget.maxLines,
        autovalidateMode: widget.autovalidateMode,
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
        onTap: widget.ontap ??
            () {
              if (widget.eController!.selection == TextSelection.fromPosition(TextPosition(offset: widget.eController!.text.length - 1))) {
                setState(() {
                  widget.eController!.selection = TextSelection.fromPosition(TextPosition(offset: widget.eController!.text.length));
                });
              }
            },
        style: context.textTheme.bodyMedium!.copyWith(color: context.theme.primaryColor),

        decoration: const InputDecoration().applyDefaults(context.theme.inputDecorationTheme).copyWith(
              contentPadding: widget.contentPadding,

              hintStyle: context.textTheme.bodyMedium!.copyWith(color: Colors.grey),
              floatingLabelStyle: context.textTheme.titleSmall!.copyWith(color: context.theme.primaryColor),
              labelStyle: context.textTheme.bodyMedium!.copyWith(color: context.theme.primaryColor),
              fillColor: widget.fillColor,
              suffixText: widget.suffixText,
              labelText: (widget.eLabel ?? widget.hint).tr,
              hintText: widget.hint.tr,
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
                          icon: Icon(isObscured ? Icons.lock_rounded : Icons.lock_open_rounded, color: context.theme.primaryColor),
                        ))
                      : (widget.suffixText == null
                          ? widget.eController!.text.isNullOrWhiteSpace || !widget.enabled
                              ? null
                              : IconButton(
                                  onPressed: widget.eController!.clear,
                                  icon: const Icon(Icons.close),
                                )
                          : Txt(widget.suffixText))),
              // enabledBorder: OutlineInputBorder(
              //   borderSide: BorderSide(color: ThemeService.to.currentColors!.primary),
              //   // borderRadius: BorderRadius.circular(widget.borderRadius),
              // ),
              // focusedBorder: OutlineInputBorder(
              //     // borderRadius: BorderRadius.circular(widget.borderRadius),
              //     borderSide: BorderSide(color: ThemeService.to.currentColors!.primaryContainer, width: 1)),
              // suffixIconConstraints: const BoxConstraints.tightForFinite(width: 30),
            ),
        textDirection: widget.textDirection ?? (LanguageService.to.isArabic || isArabic(widget.eController!.text) || widget.enableRTL ? TextDirection.rtl : TextDirection.ltr),
        textAlign: widget.textAlign ?? (LanguageService.to.isArabic || isArabic(widget.eController!.text) || widget.enableRTL ? TextAlign.right : TextAlign.left),
        validator: FormBuilderValidators.compose(widget.validators ?? []),
        keyboardType: widget.keyboardType,
      ),
    );
  }
}
