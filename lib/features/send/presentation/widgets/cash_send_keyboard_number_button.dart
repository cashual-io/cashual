import 'package:cash_ui/cash_text.dart';
import 'package:cash_ui/cash_tokens.dart';
import 'package:cashual/features/send/presentation/widgets/cash_send_keyboard_button.dart';
import 'package:flutter/widgets.dart';

class CashSendKeyboardNumberButton extends StatelessWidget {
  const CashSendKeyboardNumberButton({
    super.key,
    required this.number,
    this.onPressed,
    this.size = CashFontSize.xxl,
  });

  final String number;
  final VoidCallback? onPressed;
  final double size;

  @override
  Widget build(BuildContext context) {
    return CashSendKeyboardButton(
      onPressed: onPressed,
      child: CashText(
        number,
        size: size,
        weight: CashFontWeight.medium,
        align: TextAlign.center,
      ),
    );
  }
}
