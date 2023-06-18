import 'package:flutter/material.dart';

class SuperDecoratedContainer extends StatelessWidget {
  final double? width;
  final double? height;

  final double? borderRadius;
  final double? borderWidth;
  final Color? borderColor;
  final BoxBorder? border;
  final Color? color;

  /// An image to paint above the background [color] or [gradient].
  ///
  /// If [shape] is [BoxShape.circle] then the image is clipped to the circle's
  /// boundary; if [borderRadiusGeometry] is non-null then the image is clipped to the
  /// given radii.
  final DecorationImage? decorationImage;

  /// A border to draw above the background [color], [gradient], or [decorationImage].
  ///
  /// Follows the [shape] and [borderRadiusGeometry].
  ///
  /// Use [Border] objects to describe borders that do not depend on the reading
  /// direction.
  ///
  /// Use [BoxBorder] objects to describe borders that should flip their left
  /// and right edges based on whether the text is being read left-to-right or
  /// right-to-left.

  /// If non-null, the corners of this box are rounded by this [BorderRadius].
  ///
  /// Applies only to boxes with rectangular shapes; ignored if [shape] is not
  /// [BoxShape.rectangle].
  ///
  /// {@macro flutter.painting.BoxDecoration.clip}
  final BorderRadiusGeometry? borderRadiusGeometry;

  final List<BoxShadow>? boxShadow;

  /// A gradient to use when filling the box.
  ///
  /// If this is specified, [color] has no effect.
  ///
  /// The [gradient] is drawn under the [decorationImage].
  final Gradient? gradient;

  /// The blend mode applied to the [color] or [gradient] background of the box.
  /// If no [color] or [gradient] is provided then the blend mode has no impact.
  final BlendMode? backgroundBlendMode;

  /// [BoxShape.circle] and [RoundedRectangleBorder] instead of
  /// [BoxShape.rectangle].
  ///
  /// {@macro flutter.painting.BoxDecoration.clip}
  final BoxShape shape;
  final Widget? child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double elevation;

  const SuperDecoratedContainer(
      {Key? key,
      this.color,
      this.decorationImage,
      this.borderRadiusGeometry,
      this.boxShadow,
      this.gradient,
      this.backgroundBlendMode,
      this.shape = BoxShape.rectangle,
      this.borderRadius,
      this.width,
      this.height,
      this.margin,
      this.padding,
      this.border,
      this.borderWidth,
      this.borderColor,
      this.elevation = 0,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = this.color ?? Colors.transparent;
    final bool hasBorder = border != null || borderColor != null || borderWidth != null;
    return Material(
      color: color,
      elevation: elevation,
      borderRadius: shape == BoxShape.circle ? null : borderRadiusGeometry ?? BorderRadius.all(Radius.circular(borderRadius ?? 0)),
      child: ClipRRect(
        borderRadius: shape == BoxShape.circle ? BorderRadius.zero : borderRadiusGeometry ?? BorderRadius.all(Radius.circular(borderRadius ?? 0)),
        child: Container(
          height: height,
          width: width,
          margin: margin,
          padding: padding,
          decoration: BoxDecoration(
            color: color,
            shape: shape,
            boxShadow: boxShadow,
            image: decorationImage,
            gradient: gradient,
            backgroundBlendMode: backgroundBlendMode,
            borderRadius: shape == BoxShape.circle ? null : borderRadiusGeometry ?? BorderRadius.all(Radius.circular(borderRadius ?? 0)),
            border: hasBorder ? border ?? (Border.all(color: borderColor ?? const Color(0xFF000000), width: borderWidth ?? 1)) : null,
          ),
          child: child == null
              ? null
              : shape == BoxShape.circle
                  ? ClipOval(child: child)
                  : ClipRRect(
                      borderRadius: shape == BoxShape.circle ? BorderRadius.zero : BorderRadius.all(Radius.circular(borderRadius ?? 0)),
                      child: child,
                    ),
        ),
      ),
    );
  }
}
