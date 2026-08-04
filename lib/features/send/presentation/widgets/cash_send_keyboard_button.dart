import 'package:cash_ui/cash_surface.dart';
import 'package:cash_ui/cash_tappable.dart';
import 'package:cash_ui/cash_tokens.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class CashSendKeyboardButton extends StatelessWidget {
  const CashSendKeyboardButton({
    super.key,
    required this.child,
    this.onPressed,
  });

  final Widget child;
  final VoidCallback? onPressed;

  void _handleTap() {
    HapticFeedback.lightImpact();
    onPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    return CashTappable(
      onTap: onPressed == null ? null : _handleTap,
      child: CashSurface(
        bordered: false,
        padding: const EdgeInsets.all(16),
        radius: CashRadius.xxl,
        child: child,
      ),
    );
  }
}
