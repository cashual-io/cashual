import 'package:flutter/widgets.dart';
import 'cash_colors.dart';
import 'cash_theme.dart';
import 'cash_tokens.dart';
import 'cash_tappable.dart';
import 'cash_spinner.dart';
import 'cash_vibration.dart' show CashVibrationLevel;

class CashButton extends StatefulWidget {
  const CashButton({
    super.key,
    this.label,
    this.child,
    this.onPressed,
    this.variant = CashVariant.primary,
    this.size = CashSize.md,
    this.radius,
    this.isDisabled = false,
    this.isLoading = false,
    this.isFullWidth = false,
    this.isIconOnly = false,
    this.startContent,
    this.endContent,
    this.vibrationLevel = CashVibrationLevel.light,
    this.isVibrationEnabled = true,
  }) : assert(
         isIconOnly || label != null || child != null,
         'Provide label, child, or set isIconOnly.',
       );

  final String? label;
  final Widget? child;
  final VoidCallback? onPressed;
  final CashVariant variant;
  final CashSize size;
  final double? radius;
  final bool isDisabled;
  final bool isLoading;
  final bool isFullWidth;
  final bool isIconOnly;
  final Widget? startContent;
  final Widget? endContent;
  final CashVibrationLevel vibrationLevel;
  final bool isVibrationEnabled;

  @override
  State<CashButton> createState() => _CashButtonState();
}

class _CashButtonState extends State<CashButton> {
  bool _hovered = false;

  bool get _interactive =>
      !widget.isDisabled && !widget.isLoading && widget.onPressed != null;

  _Style _resolve(CashColorScheme cs) {
    final h = _hovered && _interactive;
    return switch (widget.variant) {
      CashVariant.primary => _Style(
        bg: h ? cs.primaryHover : cs.primary,
        fg: cs.primaryForeground,
      ),
      CashVariant.secondary => _Style(
        bg: cs.primary.withAlpha(h ? 35 : 18),
        fg: cs.primary,
      ),
      CashVariant.tertiary => _Style(
        bg: h ? cs.tertiaryHover : cs.tertiary,
        fg: cs.tertiaryForeground,
      ),
      CashVariant.success => _Style(
        bg: h ? cs.success.withAlpha(220) : cs.success,
        fg: cs.successForeground,
      ),
      CashVariant.warning => _Style(
        bg: h ? cs.warning.withAlpha(220) : cs.warning,
        fg: cs.warningForeground,
      ),
      CashVariant.danger => _Style(
        bg: h ? cs.danger.withAlpha(220) : cs.danger,
        fg: cs.dangerForeground,
      ),
      CashVariant.outline => _Style(
        bg: h ? cs.primary.withAlpha(20) : const Color(0x00000000),
        fg: cs.primary,
        border: cs.primary.withAlpha(100),
      ),
      CashVariant.ghost => _Style(
        bg: h ? cs.primary.withAlpha(20) : const Color(0x00000000),
        fg: cs.primary,
      ),
    };
  }

  double _height() => switch (widget.size) {
    CashSize.xs => 28,
    CashSize.sm => 32,
    CashSize.md => 40,
    CashSize.lg => 48,
    CashSize.xl => 56,
  };

  double _paddingH() => switch (widget.size) {
    CashSize.xs => 10,
    CashSize.sm => 12,
    CashSize.md => 16,
    CashSize.lg => 20,
    CashSize.xl => 24,
  };

  double _fontSize() => switch (widget.size) {
    CashSize.xs => CashFontSize.xs,
    CashSize.sm => CashFontSize.sm,
    CashSize.md => CashFontSize.md,
    CashSize.lg => CashFontSize.lg,
    CashSize.xl => CashFontSize.xl,
  };

  double _spinnerSize() => switch (widget.size) {
    CashSize.xs => 12,
    CashSize.sm => 14,
    CashSize.md => 16,
    CashSize.lg => 18,
    CashSize.xl => 20,
  };

  Widget _buildContent(_Style style, CashThemeData theme) {
    final textStyle = TextStyle(
      fontFamily: theme.fontFamily,
      fontSize: _fontSize(),
      fontWeight: CashFontWeight.medium,
      color: style.fg,
      height: 1.2,
    );

    if (widget.isIconOnly) {
      final icon = widget.startContent ?? widget.endContent ?? widget.child;
      return widget.isLoading
          ? CashSpinner(size: _spinnerSize(), color: style.fg)
          : _tinted(icon ?? const SizedBox.shrink(), style.fg);
    }

    final parts = <Widget>[];
    if (widget.isLoading) {
      parts.add(CashSpinner(size: _spinnerSize(), color: style.fg));
      parts.add(const SizedBox(width: 6));
    } else if (widget.startContent != null) {
      parts.add(_tinted(widget.startContent!, style.fg));
      parts.add(const SizedBox(width: 6));
    }
    parts.add(
      widget.child ??
          Flexible(
            child: Text(
              widget.label!,
              style: textStyle,
              maxLines: 1,
              softWrap: false,
              overflow: TextOverflow.clip,
            ),
          ),
    );
    if (!widget.isLoading && widget.endContent != null) {
      parts.add(const SizedBox(width: 6));
      parts.add(_tinted(widget.endContent!, style.fg));
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: parts,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = CashTheme.of(context);
    final cs = theme.colorScheme;
    final style = _resolve(cs);
    final height = _height();
    final cornerRadius = widget.radius ?? CashRadius.full;

    Widget button = MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: CashTappable(
        onTap: widget.onPressed,
        isDisabled: !_interactive,
        vibrationLevel: widget.vibrationLevel,
        isVibrationEnabled: widget.isVibrationEnabled,
        cursor: _interactive
            ? SystemMouseCursors.click
            : SystemMouseCursors.forbidden,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          height: height,
          width: widget.isIconOnly ? height : null,
          padding: EdgeInsets.symmetric(
            horizontal: widget.isIconOnly ? 0 : _paddingH(),
          ),
          decoration: BoxDecoration(
            color: style.bg,
            borderRadius: BorderRadius.circular(cornerRadius),
            border: style.border != null
                ? Border.all(color: style.border!, width: 1.5)
                : null,
          ),
          child: widget.isIconOnly
              ? Center(child: _buildContent(style, theme))
              : Align(
                  alignment: Alignment.center,
                  widthFactor: 1.0,
                  child: _buildContent(style, theme),
                ),
        ),
      ),
    );

    if (widget.isDisabled) {
      button = Opacity(opacity: 0.5, child: button);
    }

    if (widget.isFullWidth) {
      button = SizedBox(width: double.infinity, child: button);
    }

    return button;
  }
}

Widget _tinted(Widget child, Color color) {
  return IconTheme.merge(
    data: IconThemeData(color: color),
    child: ColorFiltered(
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      child: child,
    ),
  );
}

class _Style {
  const _Style({required this.bg, required this.fg, this.border});
  final Color bg;
  final Color fg;
  final Color? border;
}
