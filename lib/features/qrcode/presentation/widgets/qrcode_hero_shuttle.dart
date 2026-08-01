import 'package:cash_ui/cash_colors.dart';
import 'package:cash_ui/cash_hero_morph.dart';
import 'package:cash_ui/cash_surface.dart';
import 'package:cash_ui/cash_theme.dart';
import 'package:cash_ui/cash_tokens.dart';
import 'package:flutter/cupertino.dart';

const Curve qrCodeHeroCurve = Curves.easeOutBack;

const qrCodeHeroTag = "qrcode";

const Curve qrCodeBackgroundFadeInCurve = Interval(
  0.0,
  0.5,
  curve: Curves.easeOut,
);
const Curve qrCodeBackgroundFadeOutCurve = Interval(
  0.5,
  1.0,
  curve: Curves.easeOut,
);

final qrCodeHeroRectTween = curvedHeroRectTween(qrCodeHeroCurve);

// Deliberately doesn't reuse the generic crossFadeHeroFlightShuttleBuilder:
// that one embeds the real destination widget (toHero.child) inside the
// animated/transformed shuttle, and the destination here contains a native
// camera platform view — those render black while being transformed. This
// shuttle only ever renders a plain icon placeholder as content, so the
// actual QRView stays properly offstage during the flight (normal Hero
// behavior) and only appears once it's landed in its static position.
Widget qrCodeHeroFlightShuttleBuilder(
  BuildContext flightContext,
  Animation<double> animation,
  HeroFlightDirection flightDirection,
  BuildContext fromHeroContext,
  BuildContext toHeroContext,
) {
  return AnimatedBuilder(
    animation: animation,
    builder: (context, child) {
      final rawT = flightDirection == HeroFlightDirection.push
          ? animation.value
          : 1 - animation.value;
      final t = qrCodeHeroCurve.transform(rawT).clamp(0.0, 1.0);
      final scheme = CashTheme.schemeOf(context);
      final radius = 20 + (CashRadius.xxl - 20) * t;
      final color = Color.lerp(scheme.tertiary, CashColors.dark.surface, t)!;

      return CashSurface(bordered: false, color: color, radius: radius);
    },
  );
}
