import 'package:cash_ui/cash_surface.dart';
import 'package:cash_ui/cash_tappable.dart';
import 'package:cash_ui/cash_text.dart';
import 'package:cash_ui/cash_theme.dart';
import 'package:cash_ui/cash_tokens.dart';
import 'package:flutter/widgets.dart';

class CashRestoreOptionTile extends StatelessWidget {
  const CashRestoreOptionTile({
    super.key,
    required this.leading,
    required this.title,
    required this.description,
    this.onTap,
  });

  final Widget leading;
  final String title;
  final String description;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = CashTheme.schemeOf(context);

    return CashTappable(
      onTap: onTap,
      child: CashSurface(
        bordered: false,
        padding: const EdgeInsets.all(12),
        variant: .base,
        radius: CashRadius.xxl,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CashSurface(
              padding: const EdgeInsets.all(8),
              bordered: false,
              width: 70,
              height: 70,
              radius: CashRadius.xxl,
              color: scheme.tertiary,
              child: leading,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CashText(title, size: CashFontSize.md),
                  const SizedBox(height: 6),
                  CashText(description, color: scheme.muted),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
