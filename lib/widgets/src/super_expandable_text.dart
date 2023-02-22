import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:dart_extensions/dart_extensions.dart';
import 'package:get/get.dart';


class SuperExpandableText extends StatefulWidget {
  SuperExpandableText(
    this.text, {super.key,
    required this.expandText,
    required this.collapseText,
    this.expanded = false,
    this.linkColor,
    this.style,
    this.enabled,
    this.onTap,
    this.textDirection,
    this.textAlign,
    this.textScaleFactor,
    this.maxLines = 2,
    this.semanticsLabel,
  })  : assert(text != null),
        assert(expandText != null),
        assert(collapseText != null),
        assert(expanded != null),
        assert(maxLines != null && maxLines > 0) {
    enabled ??= true;
  }

  bool? enabled = true;
  final Function? onTap;
  final String? text;
  final String? expandText;
  final String? collapseText;
  final bool? expanded;
  final Color? linkColor;
  final TextStyle? style;
  final TextDirection? textDirection;
  final TextAlign? textAlign;
  final double? textScaleFactor;
  final int? maxLines;
  final String? semanticsLabel;

  @override
  _SuperExpandableTextState createState() => _SuperExpandableTextState();
}

class _SuperExpandableTextState extends State<SuperExpandableText> {
  bool _expanded = false;
  TapGestureRecognizer _tapGestureRecognizer = TapGestureRecognizer();

  @override
  void initState() {
    super.initState();

    _expanded = widget.expanded!;
    _tapGestureRecognizer = TapGestureRecognizer()..onTap = _toggleExpanded;
  }

  @override
  void dispose() {
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    if (widget.onTap != null) {
      widget.onTap!();
    } else if (widget.enabled!) {
      setState(() => _expanded = !_expanded);
    }
  }

  @override
  Widget build(BuildContext context) {
    final DefaultTextStyle? defaultTextStyle = DefaultTextStyle?.of(context);
    TextStyle? effectiveTextStyle = widget.style;
    if (widget.style == null || widget.style!.inherit) {
      effectiveTextStyle = defaultTextStyle?.style.merge(widget.style);
    }

    final textAlign = widget.textAlign ?? defaultTextStyle?.textAlign ?? TextAlign.start;
    final textDirection = widget.textDirection ?? Directionality.of(context);
    final textScaleFactor = widget.textScaleFactor ?? MediaQuery.textScaleFactorOf(context);
    final locale = Localizations.localeOf(context);

    final linkText = _expanded ? ' ${widget.collapseText}' : '\u2026 ${widget.expandText}';
    final linkColor = widget.linkColor ?? context.theme.colorScheme.secondary;

    final link = TextSpan(
      text: linkText,
      style: effectiveTextStyle!.copyWith(
        fontWeight: FontWeight.bold,
        color: linkColor,
      ),
      recognizer: _tapGestureRecognizer,
    );

    final text = TextSpan(
      text: widget.text,
      style: effectiveTextStyle,
    );

    Widget result = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        assert(constraints.hasBoundedWidth);
        final double? maxWidth = constraints.maxWidth;

        TextPainter textPainter = TextPainter(
          text: link,
          textAlign: textAlign,
          textDirection: textDirection,
          textScaleFactor: textScaleFactor,
          maxLines: widget.maxLines,
          locale: locale,
        );
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: constraints.maxWidth);
        final linkSize = textPainter.size;

        textPainter.text = text;
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: constraints.maxWidth);
        final textSize = textPainter.size;

        final position = textPainter.getPositionForOffset(Offset(
          textSize.width - linkSize.width,
          textSize.height,
        ));
        final endOffset = textPainter.getOffsetBefore(position.offset - 12);

        TextSpan textSpan;
        if (textPainter.didExceedMaxLines) {
          textSpan = TextSpan(
            style: effectiveTextStyle,
            text: _expanded ? widget.text : widget.text!.substring(0, endOffset),
            children: <TextSpan>[
              link,
            ],
          );
        } else {
          textSpan = text;
        }

        return RichText(
          text: textSpan,
          softWrap: true,
          textDirection: textDirection,
          textAlign: textAlign,
          textScaleFactor: textScaleFactor,
          overflow: TextOverflow.clip,
        );
      },
    );

    if (widget.semanticsLabel != null) {
      result = Semantics(
        textDirection: widget.textDirection,
        label: widget.semanticsLabel,
        child: ExcludeSemantics(
          child: result,
        ),
      );
    }

    return result;
  }
}
