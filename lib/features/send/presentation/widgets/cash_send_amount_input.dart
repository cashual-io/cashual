import 'package:cash_ui/cash_text.dart';
import 'package:cash_ui/cash_theme.dart';
import 'package:cashual/features/send/presentation/widgets/cash_send_amount_display.dart';
import 'package:cashual/features/send/presentation/widgets/cash_send_blinking_cursor.dart';
import 'package:flutter/cupertino.dart';

class CashSendAmountInput extends StatelessWidget {
  const CashSendAmountInput({
    super.key,
    required this.amount,
    this.unit = "BTC",
  });

  final String amount;
  final String unit;

  static const _blockHeight = 72.0;

  @override
  Widget build(BuildContext context) {
    final scheme = CashTheme.schemeOf(context);

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: _blockHeight,
            child: Center(
              child: amount.isEmpty
                  ? CashText("0", size: 60, height: 1, color: scheme.muted)
                  : CashSendAmountDisplay(
                      value: amount,
                      color: scheme.foreground,
                    ),
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -6),
            child: CashSendBlinkingCursor(color: scheme.primary, height: 50),
          ),
          const SizedBox(width: 8),
          SizedBox(
            height: _blockHeight,
            child: Align(
              alignment: const Alignment(0, -0.7),
              child: CashText(unit, height: 1),
            ),
          ),
        ],
      ),
    );
  }
}
