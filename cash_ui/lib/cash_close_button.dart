import 'package:flutter/cupertino.dart';
import 'cash_tappable.dart';
import 'cash_theme.dart';

class CashCloseButton extends StatelessWidget {
  const CashCloseButton({super.key, required this.onTap, this.size = 28});

  final VoidCallback onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    final scheme = CashTheme.schemeOf(context);

    return CashTappable(
      onTap: onTap,
      child: Icon(
        CupertinoIcons.xmark_circle_fill,
        size: size,
        color: scheme.muted,
      ),
    );
  }
}
