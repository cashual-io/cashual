import 'package:cash_ui/cash_text.dart';
import 'package:cash_ui/cash_tokens.dart';
import 'package:cashual/features/send/presentation/widgets/cash_send_keyboard_button.dart';
import 'package:flutter/widgets.dart';

class CashSendKeyboardDotButton extends StatelessWidget {
  const CashSendKeyboardDotButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CashSendKeyboardButton(
      onPressed: onPressed,
      child: const CashText(
        ".",
        size: CashFontSize.xxl,
        weight: CashFontWeight.medium,
        align: TextAlign.center,
      ),
    );
  }
}
