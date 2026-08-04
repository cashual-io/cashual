import 'package:cashual/features/send/presentation/widgets/cash_send_keyboard_clear_button.dart';
import 'package:cashual/features/send/presentation/widgets/cash_send_keyboard_dot_button.dart';
import 'package:cashual/features/send/presentation/widgets/cash_send_keyboard_number_button.dart';
import 'package:flutter/widgets.dart';

const _kKeyboardRows = <List<String>>[
  ["1", "2", "3"],
  ["4", "5", "6"],
  ["7", "8", "9"],
  [".", "0", "clear"],
];

const _kPercentageLabels = <String, String>{
  "1": "10%",
  "2": "20%",
  "3": "30%",
  "4": "40%",
  "5": "50%",
  "6": "60%",
  "7": "70%",
  "8": "80%",
  "9": "90%",
  "0": "100%",
};

class CashSendKeyboard extends StatelessWidget {
  const CashSendKeyboard({
    super.key,
    this.onKeyPressed,
    this.isPercentageMode = false,
  });

  final ValueChanged<String>? onKeyPressed;
  final bool isPercentageMode;

  Widget _buildKey(String key) {
    if (isPercentageMode) {
      final percentageLabel = _kPercentageLabels[key];
      if (percentageLabel != null) {
        return CashSendKeyboardNumberButton(
          number: percentageLabel,
          onPressed: () => onKeyPressed?.call(percentageLabel),
        );
      }
    }

    switch (key) {
      case ".":
        return CashSendKeyboardDotButton(
          onPressed: () => onKeyPressed?.call(key),
        );
      case "clear":
        return CashSendKeyboardClearButton(
          onPressed: () => onKeyPressed?.call(key),
        );
      default:
        return CashSendKeyboardNumberButton(
          number: key,
          onPressed: () => onKeyPressed?.call(key),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final (index, row) in _kKeyboardRows.indexed) ...[
          if (index > 0) const SizedBox(height: 8),
          Row(
            children: [
              for (final (keyIndex, key) in row.indexed) ...[
                if (keyIndex > 0) const SizedBox(width: 8),
                Expanded(child: _buildKey(key)),
              ],
            ],
          ),
        ],
      ],
    );
  }
}
