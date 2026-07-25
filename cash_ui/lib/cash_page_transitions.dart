import 'package:flutter/widgets.dart';

RouteTransitionsBuilder heroCollapsingFadeTransitionsBuilder({
  required Curve enterCurve,
  required Curve exitCurve,
}) {
  return (context, animation, secondaryAnimation, child) {
    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (context, child) {
        final reversing = animation.status == AnimationStatus.reverse;
        final curve = reversing ? exitCurve : enterCurve;
        final opacity = curve.transform(animation.value);
        return Opacity(opacity: opacity.clamp(0.0, 1.0), child: child);
      },
    );
  };
}
