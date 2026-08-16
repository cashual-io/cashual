import 'dart:async';

import 'package:cash_ui/cash_surface.dart';
import 'package:cash_ui/cash_text.dart';
import 'package:cash_ui/cash_theme.dart';
import 'package:cash_ui/cash_tokens.dart';
import 'package:flutter/widgets.dart';

typedef CashWelcomeSurfaceItem = ({
  Widget leading,
  String title,
  String description,
});

class CashWelcomeSurface extends StatefulWidget {
  const CashWelcomeSurface({
    super.key,
    required this.items,
    this.interval = const Duration(seconds: 2),
  });

  final List<CashWelcomeSurfaceItem> items;
  final Duration interval;

  @override
  State<CashWelcomeSurface> createState() => _CashWelcomeSurfaceState();
}

class _CashWelcomeSurfaceState extends State<CashWelcomeSurface> {
  int _activeIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(widget.interval, (_) {
      setState(() => _activeIndex = (_activeIndex + 1) % widget.items.length);
    });
  }

  @override
  void didUpdateWidget(covariant CashWelcomeSurface old) {
    super.didUpdateWidget(old);
    if (old.interval != widget.interval ||
        old.items.length != widget.items.length) {
      _timer?.cancel();
      _activeIndex = 0;
      _startTimer();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = CashTheme.schemeOf(context);
    final item = widget.items[_activeIndex];

    return CashSurface(
      bordered: false,
      padding: const EdgeInsets.all(12),
      radius: CashRadius.xxl,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        transitionBuilder: (child, animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: Row(
          key: ValueKey(_activeIndex),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CashSurface(
              padding: const EdgeInsets.all(8),
              bordered: false,
              width: 70,
              height: 70,
              radius: CashRadius.xxl,
              color: scheme.tertiary,
              child: item.leading,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CashText(item.title, size: CashFontSize.md),
                  const SizedBox(height: 6),
                  CashText(item.description, color: scheme.muted),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
