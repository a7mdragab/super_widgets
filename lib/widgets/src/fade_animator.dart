import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:simple_animations/animation_builder/play_animation_builder.dart';

class FadeAnimator extends HookWidget {
  final double delay;
  final Widget child;

  const FadeAnimator({super.key, this.delay = 1, required this.child});

  @override
  Widget build(BuildContext context) {
    AnimationController opacityController = useAnimationController(duration: 500.milliseconds);

    AnimationController translateController = useAnimationController(duration: 1500.milliseconds);

    final opacityTween = Tween<double>(begin: 0.0, end: 1.0);
    // Tween<double>(begin: 0.0, end: 1.0).animate(opacityController);
    final translateTween =
        // Tween<double>(begin: -30.0, end: 1.0);
        Tween<double>(begin: -30.0, end: 1.0).animate(translateController);
    // final tween = MultiTrackTween([
    //   Track("opacity")
    //       .add(Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),
    //   Track("translateY").add(
    //       Duration(milliseconds: 500), Tween(begin: -30.0, end: 0.0),
    //       curve: Curves.easeOut)
    // ]);

    return PlayAnimationBuilder<double>(
      delay: Duration(milliseconds: (200 * delay).round()),
      duration: 500.milliseconds,
      tween: opacityTween,
      child: child,
      builder: (context, opacity, child) => Opacity(
        opacity: opacity,
        child: Transform.translate(offset: Offset(0, translateTween.value), child: child),
      ),
    );
  }
}
