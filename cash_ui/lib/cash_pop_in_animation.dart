import 'package:flutter/widgets.dart';

class CashPopInAnimation extends StatelessWidget {
  const CashPopInAnimation({
    super.key,
    required this.child,
    this.beginScale = 1.1,
    this.duration = const Duration(milliseconds: 1000),
    this.curve = Curves.elasticOut,
  });

  final Widget child;
  final double beginScale;
  final Duration duration;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: beginScale, end: 1.0),
      duration: duration,
      curve: curve,
      builder: (context, value, child) => Opacity(
        opacity: value.clamp(0.0, 1.0),
        child: Transform.scale(scale: value, child: child),
      ),
      child: child,
    );
  }
}
