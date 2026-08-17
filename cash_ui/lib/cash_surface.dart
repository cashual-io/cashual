import 'package:flutter/widgets.dart';
import 'cash_colors.dart';
import 'cash_theme.dart';
import 'cash_tokens.dart';

enum CashSurfaceVariant { base, secondary, tertiary }

class CashSurface extends StatelessWidget {
  const CashSurface({
    super.key,
    this.child,
    this.padding,
    this.radius = CashRadius.lg,
    this.variant = CashSurfaceVariant.base,
    this.color,
    this.bordered = false,
    this.borderColor,
    this.borderWidth = 1.0,
    this.width,
    this.height,
    this.shadow = true,
  });

  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final double radius;
  final CashSurfaceVariant variant;
  final Color? color;
  final bool bordered;
  final Color? borderColor;
  final double borderWidth;
  final double? width;
  final double? height;
  final bool shadow;

  static const _shadow = BoxShadow(
    color: Color(0x0D000000),
    blurRadius: 2,
    offset: Offset(0, 1),
  );

  Color _resolveBackground(CashColorScheme scheme) {
    if (color != null) return color!;
    return switch (variant) {
      CashSurfaceVariant.base => scheme.surface,
      CashSurfaceVariant.secondary => scheme.surfaceSecondary,
      CashSurfaceVariant.tertiary => scheme.surfaceTertiary,
    };
  }

  @override
  Widget build(BuildContext context) {
    final scheme = CashTheme.schemeOf(context);
    final bg = _resolveBackground(scheme);
    final border = bordered
        ? Border.all(color: borderColor ?? scheme.border, width: borderWidth)
        : null;

    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(radius),
        border: border,
        boxShadow: shadow ? const [_shadow] : null,
      ),
      child: child,
    );
  }
}
