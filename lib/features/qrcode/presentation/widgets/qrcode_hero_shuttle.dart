import 'package:cash_ui/cash_colors.dart';
import 'package:cash_ui/cash_hero_morph.dart';
import 'package:cash_ui/cash_surface.dart';
import 'package:cash_ui/cash_theme.dart';
import 'package:cash_ui/cash_tokens.dart';
import 'package:flutter/widgets.dart';

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

final HeroFlightShuttleBuilder qrCodeHeroFlightShuttleBuilder =
    crossFadeHeroFlightShuttleBuilder(
      curve: qrCodeHeroCurve,
      shapeBuilder: (context, t, child) {
        final scheme = CashTheme.schemeOf(context);
        final radius = 20 + (CashRadius.xxl - 20) * t;
        final color = Color.lerp(scheme.tertiary, CashColors.dark.surface, t)!;

        return CashSurface(
          bordered: false,
          color: color,
          radius: radius,
          child: child,
        );
      },
    );
