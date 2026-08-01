import 'package:cash_ui/cash_text.dart';
import 'package:cash_ui/cash_theme.dart';
import 'package:cash_ui/cash_tokens.dart';
import 'package:flutter/widgets.dart';

class CashContactSectionHeader extends StatelessWidget {
  const CashContactSectionHeader({super.key, required this.letter});

  final String letter;

  @override
  Widget build(BuildContext context) {
    final scheme = CashTheme.schemeOf(context);

    return Container(
      width: double.infinity,
      color: scheme.background,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: CashText(
        letter,
        size: CashFontSize.lg,
        color: scheme.muted,
        weight: CashFontWeight.medium,
      ),
    );
  }
}
