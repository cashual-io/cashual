import 'package:flutter/widgets.dart';

@immutable
class CashColorScheme {
  const CashColorScheme({
    required this.background,
    required this.foreground,
    required this.surface,
    required this.surfaceForeground,
    required this.surfaceSecondary,
    required this.surfaceSecondaryForeground,
    required this.surfaceTertiary,
    required this.surfaceTertiaryForeground,
    required this.overlay,
    required this.overlayForeground,
    required this.primary,
    required this.primaryForeground,
    required this.primaryHover,
    required this.secondary,
    required this.secondaryForeground,
    required this.tertiary,
    required this.tertiaryForeground,
    required this.tertiaryHover,
    required this.success,
    required this.successForeground,
    required this.successSubtle,
    required this.successSubtleForeground,
    required this.warning,
    required this.warningForeground,
    required this.warningSubtle,
    required this.warningSubtleForeground,
    required this.danger,
    required this.dangerForeground,
    required this.dangerSubtle,
    required this.dangerSubtleForeground,
    required this.inputBackground,
    required this.inputForeground,
    required this.inputBorder,
    required this.inputPlaceholder,
    required this.muted,
    required this.border,
    required this.focus,
    required this.disabled,
    required this.disabledForeground,
    required this.backdrop,
  });

  final Color background;
  final Color foreground;

  final Color surface;
  final Color surfaceForeground;

  final Color surfaceSecondary;
  final Color surfaceSecondaryForeground;

  final Color surfaceTertiary;
  final Color surfaceTertiaryForeground;

  final Color overlay;
  final Color overlayForeground;

  final Color primary;
  final Color primaryForeground;
  final Color primaryHover;

  final Color secondary;
  final Color secondaryForeground;

  final Color tertiary;
  final Color tertiaryForeground;
  final Color tertiaryHover;

  final Color success;
  final Color successForeground;
  final Color successSubtle;
  final Color successSubtleForeground;

  final Color warning;
  final Color warningForeground;
  final Color warningSubtle;
  final Color warningSubtleForeground;

  final Color danger;
  final Color dangerForeground;
  final Color dangerSubtle;
  final Color dangerSubtleForeground;

  final Color inputBackground;
  final Color inputForeground;
  final Color inputBorder;
  final Color inputPlaceholder;

  final Color muted;
  final Color border;
  final Color focus;
  final Color disabled;
  final Color disabledForeground;
  final Color backdrop;

  CashColorScheme copyWith({
    Color? background,
    Color? foreground,
    Color? surface,
    Color? surfaceForeground,
    Color? surfaceSecondary,
    Color? surfaceSecondaryForeground,
    Color? surfaceTertiary,
    Color? surfaceTertiaryForeground,
    Color? overlay,
    Color? overlayForeground,
    Color? primary,
    Color? primaryForeground,
    Color? primaryHover,
    Color? secondary,
    Color? secondaryForeground,
    Color? tertiary,
    Color? tertiaryForeground,
    Color? tertiaryHover,
    Color? success,
    Color? successForeground,
    Color? successSubtle,
    Color? successSubtleForeground,
    Color? warning,
    Color? warningForeground,
    Color? warningSubtle,
    Color? warningSubtleForeground,
    Color? danger,
    Color? dangerForeground,
    Color? dangerSubtle,
    Color? dangerSubtleForeground,
    Color? inputBackground,
    Color? inputForeground,
    Color? inputBorder,
    Color? inputPlaceholder,
    Color? muted,
    Color? border,
    Color? focus,
    Color? disabled,
    Color? disabledForeground,
    Color? backdrop,
  }) {
    return CashColorScheme(
      background: background ?? this.background,
      foreground: foreground ?? this.foreground,
      surface: surface ?? this.surface,
      surfaceForeground: surfaceForeground ?? this.surfaceForeground,
      surfaceSecondary: surfaceSecondary ?? this.surfaceSecondary,
      surfaceSecondaryForeground:
          surfaceSecondaryForeground ?? this.surfaceSecondaryForeground,
      surfaceTertiary: surfaceTertiary ?? this.surfaceTertiary,
      surfaceTertiaryForeground:
          surfaceTertiaryForeground ?? this.surfaceTertiaryForeground,
      overlay: overlay ?? this.overlay,
      overlayForeground: overlayForeground ?? this.overlayForeground,
      primary: primary ?? this.primary,
      primaryForeground: primaryForeground ?? this.primaryForeground,
      primaryHover: primaryHover ?? this.primaryHover,
      secondary: secondary ?? this.secondary,
      secondaryForeground: secondaryForeground ?? this.secondaryForeground,
      tertiary: tertiary ?? this.tertiary,
      tertiaryForeground: tertiaryForeground ?? this.tertiaryForeground,
      tertiaryHover: tertiaryHover ?? this.tertiaryHover,
      success: success ?? this.success,
      successForeground: successForeground ?? this.successForeground,
      successSubtle: successSubtle ?? this.successSubtle,
      successSubtleForeground:
          successSubtleForeground ?? this.successSubtleForeground,
      warning: warning ?? this.warning,
      warningForeground: warningForeground ?? this.warningForeground,
      warningSubtle: warningSubtle ?? this.warningSubtle,
      warningSubtleForeground:
          warningSubtleForeground ?? this.warningSubtleForeground,
      danger: danger ?? this.danger,
      dangerForeground: dangerForeground ?? this.dangerForeground,
      dangerSubtle: dangerSubtle ?? this.dangerSubtle,
      dangerSubtleForeground:
          dangerSubtleForeground ?? this.dangerSubtleForeground,
      inputBackground: inputBackground ?? this.inputBackground,
      inputForeground: inputForeground ?? this.inputForeground,
      inputBorder: inputBorder ?? this.inputBorder,
      inputPlaceholder: inputPlaceholder ?? this.inputPlaceholder,
      muted: muted ?? this.muted,
      border: border ?? this.border,
      focus: focus ?? this.focus,
      disabled: disabled ?? this.disabled,
      disabledForeground: disabledForeground ?? this.disabledForeground,
      backdrop: backdrop ?? this.backdrop,
    );
  }
}

class CashColors {
  CashColors._();

  static const CashColorScheme light = CashColorScheme(
    background: Color(0xFFF5F5F5),
    foreground: Color(0xFF1C1C1F),

    surface: Color(0xFFFFFFFF),
    surfaceForeground: Color(0xFF1C1C1F),

    surfaceSecondary: Color(0xFFEFEFF0),
    surfaceSecondaryForeground: Color(0xFF1C1C1F),

    surfaceTertiary: Color(0xFFEAEAEB),
    surfaceTertiaryForeground: Color(0xFF1C1C1F),

    overlay: Color(0xFFF4F4F5),
    overlayForeground: Color(0xFF1C1C1F),

    primary: Color(0xFF3B82F6),
    primaryForeground: Color(0xFFFFFFFF),
    primaryHover: Color(0xFF2563EB),

    secondary: Color(0xFFEFF6FF),
    secondaryForeground: Color(0xFF1D4ED8),

    tertiary: Color(0xFFEBEBEC),
    tertiaryForeground: Color(0xFF52525B),
    tertiaryHover: Color(0xFFDFDFE0),

    success: Color(0xFF10B981),
    successForeground: Color(0xFFFFFFFF),
    successSubtle: Color(0xFFECFDF5),
    successSubtleForeground: Color(0xFF047857),

    warning: Color(0xFFEAB308),
    warningForeground: Color(0xFFFFFFFF),
    warningSubtle: Color(0xFFFEFCE8),
    warningSubtleForeground: Color(0xFFA16207),

    danger: Color(0xFFEF4444),
    dangerForeground: Color(0xFFFFFFFF),
    dangerSubtle: Color(0xFFFEF2F2),
    dangerSubtleForeground: Color(0xFFB91C1C),

    inputBackground: Color(0xFFF4F4F5),
    inputForeground: Color(0xFF1C1C1F),
    inputBorder: Color(0xFFE4E4E7),
    inputPlaceholder: Color(0xFF9090A0),

    muted: Color(0xFF71717A),
    border: Color(0x1F11181C),
    focus: Color(0xFF3B82F6),
    disabled: Color(0xFFD4D4D8),
    disabledForeground: Color(0xFF9090A0),
    backdrop: Color(0x66000000),
  );

  static const CashColorScheme dark = CashColorScheme(
    background: Color(0xFF0F0F11),
    foreground: Color(0xFFF0F0F2),

    surface: Color(0xFF1A1A1F),
    surfaceForeground: Color(0xFFF0F0F2),

    surfaceSecondary: Color(0xFF232325),
    surfaceSecondaryForeground: Color(0xFFF0F0F2),

    surfaceTertiary: Color(0xFF262728),
    surfaceTertiaryForeground: Color(0xFFF0F0F2),

    overlay: Color(0xFF27272A),
    overlayForeground: Color(0xFFF0F0F2),

    primary: Color(0xFF3B82F6),
    primaryForeground: Color(0xFFFFFFFF),
    primaryHover: Color(0xFF60A5FA),

    secondary: Color(0xFF172554),
    secondaryForeground: Color(0xFF60A5FA),

    tertiary: Color(0xFF27272A),
    tertiaryForeground: Color(0xFFA1A1AA),
    tertiaryHover: Color(0xFF3F3F46),

    success: Color(0xFF10B981),
    successForeground: Color(0xFFFFFFFF),
    successSubtle: Color(0xFF022C22),
    successSubtleForeground: Color(0xFF34D399),

    warning: Color(0xFFEAB308),
    warningForeground: Color(0xFFFFFFFF),
    warningSubtle: Color(0xFF1C1200),
    warningSubtleForeground: Color(0xFFFACC15),

    danger: Color(0xFFEF4444),
    dangerForeground: Color(0xFFFFFFFF),
    dangerSubtle: Color(0xFF450A0A),
    dangerSubtleForeground: Color(0xFFF87171),

    inputBackground: Color(0xFF27272A),
    inputForeground: Color(0xFFF0F0F2),
    inputBorder: Color(0xFF3F3F46),
    inputPlaceholder: Color(0xFF71717A),

    muted: Color(0xFF71717A),
    border: Color(0x1FFFFFFF),
    focus: Color(0xFF3B82F6),
    disabled: Color(0xFF3F3F46),
    disabledForeground: Color(0xFF71717A),
    backdrop: Color(0x99000000),
  );
}
