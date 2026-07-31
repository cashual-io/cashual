import 'package:flutter/cupertino.dart';
import 'cash_colors.dart';
import 'cash_theme.dart';
import 'cash_tokens.dart';

enum CashInputVariant { flat, bordered, faded, underlined }

enum CashInputLabelPlacement { inside, outside, outsideLeft }

class CashInput extends StatefulWidget {
  const CashInput({
    super.key,
    this.controller,
    this.focusNode,
    this.label,
    this.placeholder,
    this.description,
    this.errorMessage,
    this.variant = CashInputVariant.flat,
    this.size = CashSize.md,
    this.labelPlacement = CashInputLabelPlacement.outside,
    this.isDisabled = false,
    this.isReadOnly = false,
    this.isRequired = false,
    this.isInvalid = false,
    this.isClearable = false,
    this.isFullWidth = true,
    this.obscureText = false,
    this.startContent,
    this.endContent,
    this.radius,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.keyboardType,
    this.textInputAction,
    this.maxLines = 1,
    this.autofocus = false,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? label;
  final String? placeholder;
  final String? description;
  final String? errorMessage;
  final CashInputVariant variant;
  final CashSize size;
  final CashInputLabelPlacement labelPlacement;
  final bool isDisabled;
  final bool isReadOnly;
  final bool isRequired;
  final bool isInvalid;
  final bool isClearable;
  final bool isFullWidth;
  final bool obscureText;
  final Widget? startContent;
  final Widget? endContent;
  final double? radius;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final bool autofocus;

  @override
  State<CashInput> createState() => _CashInputState();
}

class _CashInputState extends State<CashInput> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool _isHovered = false;
  bool _ownsController = false;
  bool _ownsFocusNode = false;

  bool get _hasInsideLabel =>
      widget.label != null &&
      widget.labelPlacement == CashInputLabelPlacement.inside;

  bool get _hasValue => _controller.text.isNotEmpty;

  bool get _showFloatingLabel => _hasInsideLabel && (_isFocused || _hasValue);

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      _controller = widget.controller!;
    } else {
      _controller = TextEditingController();
      _ownsController = true;
    }
    if (widget.focusNode != null) {
      _focusNode = widget.focusNode!;
    } else {
      _focusNode = FocusNode();
      _ownsFocusNode = true;
    }
    _focusNode.addListener(_onFocusChanged);
    _controller.addListener(_onTextChanged);
  }

  @override
  void didUpdateWidget(CashInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      if (_ownsController) {
        _controller.removeListener(_onTextChanged);
        _controller.dispose();
      }
      if (widget.controller != null) {
        _controller = widget.controller!;
        _ownsController = false;
      } else {
        _controller = TextEditingController();
        _ownsController = true;
      }
      _controller.addListener(_onTextChanged);
    }
    if (widget.focusNode != oldWidget.focusNode) {
      _focusNode.removeListener(_onFocusChanged);
      if (_ownsFocusNode) _focusNode.dispose();
      if (widget.focusNode != null) {
        _focusNode = widget.focusNode!;
        _ownsFocusNode = false;
      } else {
        _focusNode = FocusNode();
        _ownsFocusNode = true;
      }
      _focusNode.addListener(_onFocusChanged);
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChanged);
    if (_ownsFocusNode) _focusNode.dispose();
    _controller.removeListener(_onTextChanged);
    if (_ownsController) _controller.dispose();
    super.dispose();
  }

  void _onFocusChanged() => setState(() => _isFocused = _focusNode.hasFocus);

  void _onTextChanged() => setState(() {});

  void _handleClear() {
    _controller.clear();
    widget.onChanged?.call('');
  }

  double _height() => switch (widget.size) {
    CashSize.xs => 28,
    CashSize.sm => 32,
    CashSize.md => 40,
    CashSize.lg => 48,
    CashSize.xl => 56,
  };

  double _heightWithLabel() => _height() + 14;

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

  double _labelFontSize() => switch (widget.size) {
    CashSize.xs => CashFontSize.xs,
    CashSize.sm => CashFontSize.xs,
    CashSize.md => CashFontSize.sm,
    CashSize.lg => CashFontSize.sm,
    CashSize.xl => CashFontSize.md,
  };

  double _radius() => switch (widget.size) {
    CashSize.xs => CashRadius.sm,
    CashSize.sm => CashRadius.md,
    CashSize.md => CashRadius.md,
    CashSize.lg => CashRadius.lg,
    CashSize.xl => CashRadius.lg,
  };

  double _iconSize() => switch (widget.size) {
    CashSize.xs => 14,
    CashSize.sm => 16,
    CashSize.md => 18,
    CashSize.lg => 20,
    CashSize.xl => 22,
  };

  _InputStyle _resolve(CashColorScheme scheme) {
    final invalid = widget.isInvalid || widget.errorMessage != null;
    final focusColor = invalid ? scheme.danger : scheme.focus;

    return switch (widget.variant) {
      CashInputVariant.flat => _InputStyle(
        background: scheme.inputBackground,
        foreground: scheme.inputForeground,
        border: _isFocused ? focusColor : const Color(0x00000000),
        borderWidth: 2.0,
        placeholder: scheme.inputPlaceholder,
        useBottomBorderOnly: false,
      ),
      CashInputVariant.bordered => _InputStyle(
        background: const Color(0x00000000),
        foreground: scheme.inputForeground,
        border: _isFocused
            ? focusColor
            : (_isHovered ? scheme.foreground : scheme.inputBorder),
        borderWidth: 2.0,
        placeholder: scheme.inputPlaceholder,
        useBottomBorderOnly: false,
      ),
      CashInputVariant.faded => _InputStyle(
        background: scheme.inputBackground,
        foreground: scheme.inputForeground,
        border: _isFocused
            ? focusColor
            : (_isHovered ? scheme.foreground : scheme.inputBorder),
        borderWidth: 2.0,
        placeholder: scheme.inputPlaceholder,
        useBottomBorderOnly: false,
      ),
      CashInputVariant.underlined => _InputStyle(
        background: const Color(0x00000000),
        foreground: scheme.inputForeground,
        border: _isFocused
            ? focusColor
            : (_isHovered ? scheme.foreground : scheme.inputBorder),
        borderWidth: _isFocused ? 2.0 : 1.0,
        placeholder: scheme.inputPlaceholder,
        useBottomBorderOnly: true,
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final scheme = CashTheme.schemeOf(context);
    final style = _resolve(scheme);
    final invalid = widget.isInvalid || widget.errorMessage != null;

    final fontSize = _fontSize();
    final labelFontSize = _labelFontSize();
    final cornerRadius = widget.radius ?? _radius();
    final wrapperHeight = _hasInsideLabel ? _heightWithLabel() : _height();
    final horizontalPadding = _paddingH();

    Widget inputField = CupertinoTextField(
      controller: _controller,
      focusNode: _focusNode,
      placeholder: _showFloatingLabel ? null : widget.placeholder,
      placeholderStyle: TextStyle(
        fontSize: fontSize,
        color: style.placeholder,
        fontWeight: FontWeight.w400,
      ),
      style: TextStyle(
        fontSize: fontSize,
        color: style.foreground,
        fontWeight: FontWeight.w400,
      ),
      enabled: !widget.isDisabled,
      readOnly: widget.isReadOnly,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      maxLines: widget.maxLines,
      autofocus: widget.autofocus,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      onTapOutside: (_) => _focusNode.unfocus(),
      padding: EdgeInsets.zero,
      decoration: const BoxDecoration(color: Color(0x00000000)),
    );

    if (_hasInsideLabel) {
      inputField = Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 150),
            style: TextStyle(
              fontSize: _showFloatingLabel ? labelFontSize : fontSize,
              color: _isFocused && !invalid ? scheme.focus : style.placeholder,
              fontWeight: FontWeight.w400,
            ),
            child: _buildLabelText(scheme),
          ),
          if (_showFloatingLabel) ...[const SizedBox(height: 2), inputField],
        ],
      );
    }

    final parts = <Widget>[];

    if (widget.startContent != null) {
      parts.add(
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: DefaultTextStyle.merge(
            style: TextStyle(color: style.placeholder),
            child: IconTheme.merge(
              data: IconThemeData(color: style.placeholder, size: _iconSize()),
              child: widget.startContent!,
            ),
          ),
        ),
      );
    }

    parts.add(Expanded(child: inputField));

    if (widget.isClearable && _hasValue && !widget.isDisabled) {
      parts.add(
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: GestureDetector(
            onTap: _handleClear,
            child: Icon(
              CupertinoIcons.clear_circled_solid,
              size: _iconSize(),
              color: style.placeholder,
            ),
          ),
        ),
      );
    }

    if (widget.endContent != null) {
      parts.add(
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: DefaultTextStyle.merge(
            style: TextStyle(color: style.placeholder),
            child: IconTheme.merge(
              data: IconThemeData(color: style.placeholder, size: _iconSize()),
              child: widget.endContent!,
            ),
          ),
        ),
      );
    }

    final borderRadius = widget.variant == CashInputVariant.underlined
        ? BorderRadius.zero
        : BorderRadius.circular(cornerRadius);

    final border = style.border != null
        ? (style.useBottomBorderOnly
              ? Border(
                  bottom: BorderSide(
                    color: style.border!,
                    width: style.borderWidth,
                  ),
                )
              : Border.all(color: style.border!, width: style.borderWidth))
        : null;

    Widget wrapper = MouseRegion(
      cursor: widget.isDisabled
          ? SystemMouseCursors.forbidden
          : SystemMouseCursors.text,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          if (!widget.isDisabled) {
            _focusNode.requestFocus();
            widget.onTap?.call();
          }
        },
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: wrapperHeight,
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          decoration: BoxDecoration(
            color: style.background,
            borderRadius: borderRadius,
            border: border,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: parts,
          ),
        ),
      ),
    );

    if (widget.isDisabled) {
      wrapper = Opacity(opacity: 0.5, child: wrapper);
    }

    final hasOutsideLabel =
        widget.label != null &&
        widget.labelPlacement != CashInputLabelPlacement.inside;
    final hasBottomText =
        widget.description != null || widget.errorMessage != null;

    if (!hasOutsideLabel && !hasBottomText) {
      return widget.isFullWidth
          ? SizedBox(width: double.infinity, child: wrapper)
          : wrapper;
    }

    Widget result;

    if (widget.labelPlacement == CashInputLabelPlacement.outsideLeft &&
        widget.label != null) {
      result = Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: _buildLabelText(scheme),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [wrapper, if (hasBottomText) _buildBottomText(scheme)],
            ),
          ),
        ],
      );
    } else {
      final children = <Widget>[];
      if (hasOutsideLabel) {
        children.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: _buildLabelText(scheme),
          ),
        );
      }
      children.add(wrapper);
      if (hasBottomText) children.add(_buildBottomText(scheme));

      result = Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      );
    }

    if (widget.isFullWidth) {
      result = SizedBox(width: double.infinity, child: result);
    }

    return result;
  }

  Widget _buildLabelText(CashColorScheme scheme) {
    final invalid = widget.isInvalid || widget.errorMessage != null;
    final fontSize = widget.labelPlacement == CashInputLabelPlacement.inside
        ? (_showFloatingLabel ? _labelFontSize() : _fontSize())
        : _fontSize();

    final color = _isFocused && !invalid ? scheme.focus : scheme.foreground;

    return Text.rich(
      TextSpan(
        text: widget.label,
        children: [
          if (widget.isRequired)
            TextSpan(
              text: ' *',
              style: TextStyle(color: scheme.danger),
            ),
        ],
      ),
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        color: widget.labelPlacement == CashInputLabelPlacement.inside
            ? (_isFocused && !invalid ? scheme.focus : scheme.inputPlaceholder)
            : color,
      ),
    );
  }

  Widget _buildBottomText(CashColorScheme scheme) {
    final invalid = widget.isInvalid || widget.errorMessage != null;
    final text = invalid ? widget.errorMessage : widget.description;
    if (text == null) return const SizedBox.shrink();

    final descFontSize = switch (widget.size) {
      CashSize.xs => CashFontSize.xs,
      CashSize.sm => CashFontSize.xs,
      CashSize.md => CashFontSize.sm,
      CashSize.lg => CashFontSize.sm,
      CashSize.xl => CashFontSize.md,
    };

    return Padding(
      padding: const EdgeInsets.only(top: 4, left: 4),
      child: Text(
        text,
        style: TextStyle(
          fontSize: descFontSize,
          color: invalid ? scheme.danger : scheme.muted,
        ),
      ),
    );
  }
}

class _InputStyle {
  const _InputStyle({
    required this.background,
    required this.foreground,
    required this.border,
    required this.borderWidth,
    required this.placeholder,
    required this.useBottomBorderOnly,
  });

  final Color background;
  final Color foreground;
  final Color? border;
  final double borderWidth;
  final Color placeholder;
  final bool useBottomBorderOnly;
}
