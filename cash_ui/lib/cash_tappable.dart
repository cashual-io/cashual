import 'package:flutter/widgets.dart';
import 'cash_vibration.dart';

class CashTappable extends StatefulWidget {
  const CashTappable({
    super.key,
    required this.child,
    this.onTap,
    this.isDisabled = false,
    this.scale = 0.97,
    this.duration = const Duration(milliseconds: 80),
    this.behavior = HitTestBehavior.opaque,
    this.cursor,
    this.vibrationLevel = CashVibrationLevel.light,
    this.isVibrationEnabled = true,
  });

  final Widget child;
  final VoidCallback? onTap;
  final bool isDisabled;
  final double scale;
  final Duration duration;
  final HitTestBehavior behavior;
  final MouseCursor? cursor;
  final CashVibrationLevel vibrationLevel;
  final bool isVibrationEnabled;

  @override
  State<CashTappable> createState() => _CashTappableState();
}

class _CashTappableState extends State<CashTappable>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      lowerBound: widget.scale,
      upperBound: 1.0,
      value: 1.0,
    );
  }

  @override
  void didUpdateWidget(CashTappable old) {
    super.didUpdateWidget(old);
    if (widget.duration != old.duration) {
      _controller.duration = widget.duration;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _interactive => !widget.isDisabled && widget.onTap != null;

  void _press() {
    if (_interactive) _controller.reverse();
  }

  void _release() {
    if (_interactive) _controller.forward();
  }

  void _handleTap() {
    if (widget.isVibrationEnabled) {
      triggerCashVibration(widget.vibrationLevel);
    }
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    final cursor =
        widget.cursor ??
        (_interactive ? SystemMouseCursors.click : SystemMouseCursors.basic);

    return MouseRegion(
      cursor: cursor,
      child: Listener(
        onPointerDown: (_) => _press(),
        onPointerUp: (_) => _release(),
        onPointerCancel: (_) => _release(),
        onPointerMove: (e) {
          // cancel the press animation as soon as horizontal movement is detected
          // so Slidable (or any horizontal swipe) doesn't cause a visible glitch
          if (e.delta.dx.abs() > e.delta.dy.abs() && e.delta.dx.abs() > 1.5) {
            _release();
          }
        },
        child: GestureDetector(
          onTap: _interactive ? _handleTap : null,
          behavior: widget.behavior,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (_, child) =>
                Transform.scale(scale: _controller.value, child: child),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
