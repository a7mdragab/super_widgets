import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground(
      {Key? key,
      this.gradient = const SweepGradient(
        colors: [
          Color(0xFFFAC303),
          Color(0xFFFFDB71),
          Color(0xFFECD821),
          Color(0xFFFFC20E),
          Color(0xFFFFC20E),
          Color(0xFFFAC303),
        ],
      ),
      required this.child})
      : super(key: key);
  final Gradient gradient;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: gradient,
          ),
        ),
        child,
      ],
    );
  }
}
