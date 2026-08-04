import 'package:flutter/widgets.dart';
import 'cash_surface.dart';
import 'cash_tappable.dart';
import 'cash_text.dart';
import 'cash_theme.dart';
import 'cash_tokens.dart';

class CashChip extends StatelessWidget {
  const CashChip({
    super.key,
    required this.label,
    this.icon,
    this.imageUrl,
    this.isActive = false,
    this.onTap,
  });

  final String label;
  final IconData? icon;
  final String? imageUrl;
  final bool isActive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = CashTheme.schemeOf(context);
    final hasLeading = icon != null || imageUrl != null;
    final fg = isActive ? scheme.primaryForeground : scheme.foreground;

    return CashTappable(
      onTap: onTap,
      child: CashSurface(
        bordered: false,
        color: isActive ? scheme.primary : scheme.surface,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        radius: CashRadius.xxl,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) Icon(icon, size: 16, color: fg),
            if (imageUrl != null)
              ClipOval(
                child: Image.network(
                  imageUrl!,
                  width: 16,
                  height: 16,
                  fit: BoxFit.contain,
                ),
              ),
            if (hasLeading) const SizedBox(width: 6),
            CashText(label, size: CashFontSize.md, color: fg),
          ],
        ),
      ),
    );
  }
}
