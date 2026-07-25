import 'package:flutter/widgets.dart';

class CashFadeEdge extends StatelessWidget {
  const CashFadeEdge({
    super.key,
    required this.child,
    this.axis = Axis.horizontal,
    this.fadeSize = 24,
    this.fadeStart = true,
    this.fadeEnd = true,
  });

  final Widget child;
  final Axis axis;
  final double fadeSize;
  final bool fadeStart;
  final bool fadeEnd;

  static const _opaque = Color(0xFFFFFFFF);
  static const _transparent = Color(0x00FFFFFF);

  @override
  Widget build(BuildContext context) {
    if (!fadeStart && !fadeEnd) return child;

    return ShaderMask(
      blendMode: BlendMode.dstIn,
      shaderCallback: (bounds) {
        final extent = axis == Axis.horizontal ? bounds.width : bounds.height;
        final fadeFraction = extent > 0
            ? (fadeSize / extent).clamp(0.0, 0.5)
            : 0.0;

        return LinearGradient(
          begin: axis == Axis.horizontal
              ? Alignment.centerLeft
              : Alignment.topCenter,
          end: axis == Axis.horizontal
              ? Alignment.centerRight
              : Alignment.bottomCenter,
          colors: [
            fadeStart ? _transparent : _opaque,
            _opaque,
            _opaque,
            fadeEnd ? _transparent : _opaque,
          ],
          stops: [0.0, fadeFraction, 1.0 - fadeFraction, 1.0],
        ).createShader(bounds);
      },
      child: child,
    );
  }
}
