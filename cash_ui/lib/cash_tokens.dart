import 'package:flutter/widgets.dart';

enum CashSize { xs, sm, md, lg, xl }

enum CashVariant {
  primary,
  secondary,
  tertiary,
  success,
  warning,
  danger,
  outline,
  ghost,
}

class CashRadius {
  CashRadius._();

  static const double none = 0;
  static const double xs = 2;
  static const double sm = 4;
  static const double md = 8;
  static const double lg = 12;
  static const double xl = 16;
  static const double xxl = 24;
  static const double full = 9999;
}

class CashSpacing {
  CashSpacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;
}

class CashFontSize {
  CashFontSize._();

  static const double xs = 11;
  static const double sm = 13;
  static const double md = 16;
  static const double lg = 17;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 30;
  static const double xxxxl = 36;
  static const double xxxxxl = 42;
}

class CashFontWeight {
  CashFontWeight._();

  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semibold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
}
