import 'package:cash_ui/cash_theme.dart';
import 'package:cashual/features/send/presentation/widgets/cash_send_keyboard_button.dart';
import 'package:flutter/cupertino.dart';

class CashSendKeyboardClearButton extends StatelessWidget {
  const CashSendKeyboardClearButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final scheme = CashTheme.schemeOf(context);

    return CashSendKeyboardButton(
      onPressed: onPressed,
      child: Icon(
        CupertinoIcons.delete_left_fill,
        size: 24,
        color: scheme.foreground,
      ),
    );
  }
}
