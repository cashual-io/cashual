import 'package:flutter/cupertino.dart';
import 'cash_colors.dart';
import 'cash_theme.dart';
import 'cash_tokens.dart';

class CashTag extends StatelessWidget {
  const CashTag({
    super.key,
    required this.label,
    this.variant = CashVariant.secondary,
    this.size = CashSize.sm,
    this.startContent,
    this.onClose,
  });

  final String label;
  final CashVariant variant;
  final CashSize size;
  final Widget? startContent;
  final VoidCallback? onClose;

  double get _height => switch (size) {
    CashSize.xs => 18,
    CashSize.sm => 22,
    CashSize.md => 26,
    CashSize.lg => 30,
    CashSize.xl => 34,
  };

  double get _paddingH => switch (size) {
    CashSize.xs => 6,
    CashSize.sm => 8,
    CashSize.md => 10,
    CashSize.lg => 12,
    CashSize.xl => 14,
  };

  double get _fontSize => switch (size) {
    CashSize.xs => 10,
    CashSize.sm => 11,
    CashSize.md => 12,
    CashSize.lg => 13,
    CashSize.xl => 14,
  };

  double get _iconSize => switch (size) {
    CashSize.xs => 10,
    CashSize.sm => 11,
    CashSize.md => 12,
    CashSize.lg => 13,
    CashSize.xl => 14,
  };

  _TagStyle _resolve(CashColorScheme cs) {
    return switch (variant) {
      CashVariant.primary => _TagStyle(
        bg: cs.primary.withAlpha(18),
        fg: cs.primary,
      ),
      CashVariant.secondary => _TagStyle(
        bg: cs.primary.withAlpha(18),
        fg: cs.primary,
      ),
      CashVariant.tertiary => _TagStyle(
        bg: cs.tertiary,
        fg: cs.tertiaryForeground,
      ),
      CashVariant.success => _TagStyle(
        bg: cs.successSubtle,
        fg: cs.successSubtleForeground,
      ),
      CashVariant.warning => _TagStyle(
        bg: cs.warningSubtle,
        fg: cs.warningSubtleForeground,
      ),
      CashVariant.danger => _TagStyle(
        bg: cs.dangerSubtle,
        fg: cs.dangerSubtleForeground,
      ),
      CashVariant.outline => _TagStyle(
        bg: const Color(0x00000000),
        fg: cs.foreground,
        border: cs.border,
      ),
      CashVariant.ghost => _TagStyle(
        bg: const Color(0x00000000),
        fg: cs.muted,
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final scheme = CashTheme.schemeOf(context);
    final theme = CashTheme.of(context);
    final style = _resolve(scheme);
    final height = _height;

    final children = <Widget>[];

    if (startContent != null) {
      children.add(
        IconTheme.merge(
          data: IconThemeData(color: style.fg, size: _iconSize),
          child: startContent!,
        ),
      );
      children.add(const SizedBox(width: 4));
    }

    children.add(
      Text(
        label,
        style: TextStyle(
          fontFamily: theme.fontFamily,
          fontSize: _fontSize,
          fontWeight: CashFontWeight.medium,
          color: style.fg,
          height: 1.0,
        ),
      ),
    );

    if (onClose != null) {
      children.add(const SizedBox(width: 4));
      children.add(
        GestureDetector(
          onTap: onClose,
          child: Icon(
            CupertinoIcons.xmark,
            size: _iconSize,
            color: style.fg.withAlpha(160),
          ),
        ),
      );
    }

    return Container(
      height: height,
      padding: EdgeInsets.symmetric(horizontal: _paddingH),
      decoration: BoxDecoration(
        color: style.bg,
        borderRadius: BorderRadius.circular(CashRadius.full),
        border: style.border != null
            ? Border.all(color: style.border!, width: 1)
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }
}

class _TagStyle {
  const _TagStyle({required this.bg, required this.fg, this.border});
  final Color bg;
  final Color fg;
  final Color? border;
}
