import 'package:flutter/widgets.dart';
import 'cash_theme.dart';
import 'cash_tokens.dart';

class CashText extends StatelessWidget {
  const CashText(
    this.text, {
    super.key,
    this.size = CashFontSize.md,
    this.weight = CashFontWeight.regular,
    this.color,
    this.align,
    this.maxLines,
    this.overflow,
    this.height,
  });

  final String text;
  final double size;
  final FontWeight weight;
  final Color? color;
  final TextAlign? align;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final theme = CashTheme.of(context);
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        fontFamily: theme.fontFamily,
        fontSize: size,
        fontWeight: weight,
        color: color ?? theme.colorScheme.foreground,
        height: height,
      ),
    );
  }
}
