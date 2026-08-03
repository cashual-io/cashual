import 'package:flutter/widgets.dart';

class CashFadeEdge extends StatefulWidget {
  const CashFadeEdge({
    super.key,
    required this.child,
    this.axis = Axis.horizontal,
    this.fadeSize = 24,
    this.fadeStart = true,
    this.fadeEnd = true,
    this.controller,
  });

  final Widget child;
  final Axis axis;
  final double fadeSize;
  final bool fadeStart;
  final bool fadeEnd;

  /// When provided, fadeStart/fadeEnd are only shown while the controller's
  /// scroll position has actually moved away from that edge, instead of
  /// being applied unconditionally.
  final ScrollController? controller;

  @override
  State<CashFadeEdge> createState() => _CashFadeEdgeState();
}

class _CashFadeEdgeState extends State<CashFadeEdge> {
  bool _fadeStart = false;
  bool _fadeEnd = false;

  @override
  void initState() {
    super.initState();
    _fadeStart = widget.fadeStart;
    _fadeEnd = widget.fadeEnd;
    widget.controller?.addListener(_updateFade);
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateFade());
  }

  @override
  void didUpdateWidget(covariant CashFadeEdge old) {
    super.didUpdateWidget(old);
    if (old.controller != widget.controller) {
      old.controller?.removeListener(_updateFade);
      widget.controller?.addListener(_updateFade);
    }
    if (widget.controller == null) {
      _fadeStart = widget.fadeStart;
      _fadeEnd = widget.fadeEnd;
    } else {
      _updateFade();
    }
  }

  void _updateFade() {
    final controller = widget.controller;
    if (controller == null || !controller.hasClients) return;

    final position = controller.position;
    final fadeStart = widget.fadeStart && position.pixels > 0;
    final fadeEnd =
        widget.fadeEnd && position.pixels < position.maxScrollExtent;
    if (fadeStart != _fadeStart || fadeEnd != _fadeEnd) {
      setState(() {
        _fadeStart = fadeStart;
        _fadeEnd = fadeEnd;
      });
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_updateFade);
    super.dispose();
  }

  static const _opaque = Color(0xFFFFFFFF);
  static const _transparent = Color(0x00FFFFFF);

  @override
  Widget build(BuildContext context) {
    if (!_fadeStart && !_fadeEnd) return widget.child;

    return ShaderMask(
      blendMode: BlendMode.dstIn,
      shaderCallback: (bounds) {
        final extent = widget.axis == Axis.horizontal
            ? bounds.width
            : bounds.height;
        final fadeFraction = extent > 0
            ? (widget.fadeSize / extent).clamp(0.0, 0.5)
            : 0.0;

        return LinearGradient(
          begin: widget.axis == Axis.horizontal
              ? Alignment.centerLeft
              : Alignment.topCenter,
          end: widget.axis == Axis.horizontal
              ? Alignment.centerRight
              : Alignment.bottomCenter,
          colors: [
            _fadeStart ? _transparent : _opaque,
            _opaque,
            _opaque,
            _fadeEnd ? _transparent : _opaque,
          ],
          stops: [0.0, fadeFraction, 1.0 - fadeFraction, 1.0],
        ).createShader(bounds);
      },
      child: widget.child,
    );
  }
}
