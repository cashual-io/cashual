import 'package:cash_ui/cash_colors.dart';
import 'package:cash_ui/cash_text.dart';
import 'package:cash_ui/cash_theme.dart';
import 'package:cash_ui/cash_tokens.dart';
import 'package:flutter/cupertino.dart';

const _kGridRowCount = 4;
const _kGridLeftFlex = 3;
const _kGridRightFlex = 7;

const _kEthLogo =
    "https://upload.wikimedia.org/wikipedia/commons/f/fd/Ethereum_Logo.png";

class CashSendConfirmationCard extends StatelessWidget {
  const CashSendConfirmationCard({super.key});

  Widget _gridCell({
    required CashColorScheme scheme,
    required int row,
    required int flex,
    required bool isLastColumn,
    required Widget child,
  }) {
    final borderSide = BorderSide(color: scheme.muted.withAlpha(50), width: .5);

    return Expanded(
      flex: flex,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          border: Border(
            right: isLastColumn ? BorderSide.none : borderSide,
            bottom: row < _kGridRowCount - 1 ? borderSide : BorderSide.none,
          ),
        ),
        child: Align(alignment: Alignment.centerLeft, child: child),
      ),
    );
  }

  Widget _gridRow({
    required CashColorScheme scheme,
    required int row,
    required Widget left,
    required Widget right,
  }) {
    return SizedBox(
      height: 46,
      child: Row(
        children: [
          _gridCell(
            scheme: scheme,
            row: row,
            flex: _kGridLeftFlex,
            isLastColumn: false,
            child: left,
          ),
          _gridCell(
            scheme: scheme,
            row: row,
            flex: _kGridRightFlex,
            isLastColumn: true,
            child: right,
          ),
        ],
      ),
    );
  }

  Widget _value(String value, {Color? color}) {
    return CashText(
      value,
      size: CashFontSize.lg,
      weight: CashFontWeight.regular,
      color: color,
    );
  }

  Widget _valueWithLeading({required Widget leading, required String value}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        leading,
        const SizedBox(width: 8),
        Flexible(child: _value(value)),
      ],
    );
  }

  Widget _addressAvatar(String seed) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Image.network(
        "https://api.dicebear.com/10.x/glyphs/png?seed=$seed",
        width: 24,
        height: 24,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _assetLogo(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Image.network(url, width: 24, height: 24, fit: BoxFit.cover),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = CashTheme.schemeOf(context);

    return Column(
      children: [
        _gridRow(
          scheme: scheme,
          row: 0,
          left: _value("Sender", color: scheme.muted),
          right: _valueWithLeading(
            leading: _addressAvatar("Sender"),
            value: "0x0000...0000",
          ),
        ),
        _gridRow(
          scheme: scheme,
          row: 1,
          left: _value("Receiver", color: scheme.muted),
          right: _valueWithLeading(
            leading: _addressAvatar("Receiver"),
            value: "0x0000...00000",
          ),
        ),
        _gridRow(
          scheme: scheme,
          row: 2,
          left: _value("Amount", color: scheme.muted),
          right: _valueWithLeading(
            leading: _assetLogo(_kEthLogo),
            value: "0.00213 ETH",
          ),
        ),
        _gridRow(
          scheme: scheme,
          row: 3,
          left: _value("Fee", color: scheme.muted),
          right: _valueWithLeading(
            leading: _assetLogo(_kEthLogo),
            value: "0.00004 ETH",
          ),
        ),
      ],
    );
  }
}
