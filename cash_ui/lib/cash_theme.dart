import 'package:flutter/widgets.dart';
import 'cash_colors.dart';

enum CashThemeMode { light, dark, system }

@immutable
class CashThemeData {
  const CashThemeData({
    required this.colorScheme,
    required this.brightness,
    this.fontFamily,
  });

  final CashColorScheme colorScheme;
  final Brightness brightness;
  final String? fontFamily;

  bool get isDark => brightness == Brightness.dark;

  static const CashThemeData light = CashThemeData(
    colorScheme: CashColors.light,
    brightness: Brightness.light,
  );

  static const CashThemeData dark = CashThemeData(
    colorScheme: CashColors.dark,
    brightness: Brightness.dark,
  );

  CashThemeData copyWith({
    CashColorScheme? colorScheme,
    Brightness? brightness,
    String? fontFamily,
  }) {
    return CashThemeData(
      colorScheme: colorScheme ?? this.colorScheme,
      brightness: brightness ?? this.brightness,
      fontFamily: fontFamily ?? this.fontFamily,
    );
  }
}

class _CashThemeScope extends InheritedWidget {
  const _CashThemeScope({required this.data, required super.child});

  final CashThemeData data;

  @override
  bool updateShouldNotify(_CashThemeScope old) => data != old.data;
}

class CashTheme extends StatelessWidget {
  const CashTheme({
    super.key,
    required this.child,
    this.mode = CashThemeMode.system,
    this.light = CashThemeData.light,
    this.dark = CashThemeData.dark,
  });

  final Widget child;
  final CashThemeMode mode;
  final CashThemeData light;
  final CashThemeData dark;

  static CashThemeData of(BuildContext context) {
    return context
            .dependOnInheritedWidgetOfExactType<_CashThemeScope>()
            ?.data ??
        CashThemeData.light;
  }

  static CashColorScheme schemeOf(BuildContext context) {
    return of(context).colorScheme;
  }

  @override
  Widget build(BuildContext context) {
    final systemBrightness = MediaQuery.platformBrightnessOf(context);
    final brightness = switch (mode) {
      CashThemeMode.light => Brightness.light,
      CashThemeMode.dark => Brightness.dark,
      CashThemeMode.system => systemBrightness,
    };
    final data = brightness == Brightness.dark ? dark : light;
    return _CashThemeScope(data: data, child: child);
  }
}
