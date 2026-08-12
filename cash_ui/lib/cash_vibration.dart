import 'package:flutter/services.dart';

enum CashVibrationLevel { light, medium, heavy, selection }

void triggerCashVibration(CashVibrationLevel level) {
  switch (level) {
    case CashVibrationLevel.light:
      HapticFeedback.lightImpact();
    case CashVibrationLevel.medium:
      HapticFeedback.mediumImpact();
    case CashVibrationLevel.heavy:
      HapticFeedback.heavyImpact();
    case CashVibrationLevel.selection:
      HapticFeedback.selectionClick();
  }
}
