import 'package:flutter/widgets.dart';

/// Mimics [IndexedStack] (all branches stay mounted so their state/scroll
/// position survives switching away and back), but slides the outgoing and
/// incoming branch directionally based on whether the new index is higher or
/// lower than the previous one, instead of an instant cut.
class CashShellTransitionContainer extends StatefulWidget {
  const CashShellTransitionContainer({
    super.key,
    required this.currentIndex,
    required this.children,
  });

  final int currentIndex;
  final List<Widget> children;

  @override
  State<CashShellTransitionContainer> createState() =>
      _CashShellTransitionContainerState();
}

class _CashShellTransitionContainerState
    extends State<CashShellTransitionContainer>
    with SingleTickerProviderStateMixin {
  static const _shiftDistance = 24.0;
  static const _minScale = 0.95;

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 160),
    value: 1.0,
  );
  late final CurvedAnimation _curved = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  );

  late int _currentIndex = widget.currentIndex;
  int? _previousIndex;

  @override
  void didUpdateWidget(covariant CashShellTransitionContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentIndex != _currentIndex) {
      setState(() {
        _previousIndex = _currentIndex;
        _currentIndex = widget.currentIndex;
      });
      _controller
        ..value = 0
        ..forward().whenComplete(() {
          if (mounted) setState(() => _previousIndex = null);
        });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final previousIndex = _previousIndex;

    return Stack(
      children: [
        for (var i = 0; i < widget.children.length; i++)
          if (i == _currentIndex || i == previousIndex)
            _buildTransitioningChild(i, previousIndex)
          else
            Positioned.fill(
              child: Offstage(
                offstage: true,
                child: TickerMode(enabled: false, child: widget.children[i]),
              ),
            ),
      ],
    );
  }

  Widget _buildTransitioningChild(int index, int? previousIndex) {
    if (previousIndex == null) {
      return Positioned.fill(
        child: TickerMode(enabled: true, child: widget.children[index]),
      );
    }

    final forward = _currentIndex > previousIndex;
    final isEntering = index == _currentIndex;
    final dx = isEntering
        ? (forward ? _shiftDistance : -_shiftDistance)
        : (forward ? -_shiftDistance : _shiftDistance);
    final offsetTween = isEntering
        ? Tween<double>(begin: dx, end: 0)
        : Tween<double>(begin: 0, end: dx);
    final opacityTween = isEntering
        ? Tween<double>(begin: 0, end: 1)
        : Tween<double>(begin: 1, end: 0);
    final scaleTween = isEntering
        ? Tween<double>(begin: _minScale, end: 1.0)
        : Tween<double>(begin: 1.0, end: _minScale);

    return Positioned.fill(
      child: IgnorePointer(
        ignoring: !isEntering,
        child: AnimatedBuilder(
          animation: _curved,
          builder: (context, child) {
            return Opacity(
              opacity: opacityTween.evaluate(_curved),
              child: Transform.translate(
                offset: Offset(offsetTween.evaluate(_curved), 0),
                child: Transform.scale(
                  scale: scaleTween.evaluate(_curved),
                  child: child,
                ),
              ),
            );
          },
          child: TickerMode(enabled: isEntering, child: widget.children[index]),
        ),
      ),
    );
  }
}
