import 'package:flutter/widgets.dart';

Tween<Rect?> Function(Rect? begin, Rect? end) curvedHeroRectTween(Curve curve) {
  return (begin, end) => _CurvedRectTween(begin: begin, end: end, curve: curve);
}

class _CurvedRectTween extends RectTween {
  _CurvedRectTween({
    required super.begin,
    required super.end,
    required this.curve,
  });

  final Curve curve;

  @override
  Rect? lerp(double t) => super.lerp(curve.transform(t));
}

HeroFlightShuttleBuilder crossFadeHeroFlightShuttleBuilder({
  required Curve curve,
  required Widget Function(BuildContext context, double t, Widget child)
  shapeBuilder,
}) {
  return (
    flightContext,
    animation,
    flightDirection,
    fromHeroContext,
    toHeroContext,
  ) {
    final fromHero = fromHeroContext.widget as Hero;
    final toHero = toHeroContext.widget as Hero;

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final rawT = flightDirection == HeroFlightDirection.push
            ? animation.value
            : 1 - animation.value;
        final t = curve.transform(rawT).clamp(0.0, 1.0);

        return shapeBuilder(
          context,
          t,
          Stack(
            children: [
              Opacity(
                opacity: (1 - t * 2).clamp(0.0, 1.0),
                child: Center(child: fromHero.child),
              ),
              Opacity(
                opacity: (t * 2 - 1).clamp(0.0, 1.0),
                child: toHero.child,
              ),
            ],
          ),
        );
      },
    );
  };
}
