import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'cash_text.dart';
import 'cash_theme.dart';
import 'cash_tokens.dart';

/// A translucent, blurred header meant to sit in a [Stack] above scrolling
/// content (via [Positioned]), replacing [CupertinoPageScaffold]'s built-in
/// `navigationBar`. Using one shared [BackdropFilter] for the title and any
/// [bottom] content (e.g. a search field) avoids the seam you get from
/// stacking separate blurred regions that don't share the same pixels.
///
/// Pad your scrollable content by [CashGlassHeader.totalHeight] so it starts
/// below the header instead of underneath it.
class CashGlassHeader extends StatelessWidget {
  const CashGlassHeader({
    super.key,
    required this.title,
    this.bottom,
    this.blurSigma = 16,
  });

  final String title;
  final Widget? bottom;
  final double blurSigma;

  static const titleBarHeight = kMinInteractiveDimensionCupertino;

  static double totalHeight(BuildContext context, {double bottomHeight = 0}) {
    return MediaQuery.paddingOf(context).top + titleBarHeight + bottomHeight;
  }

  @override
  Widget build(BuildContext context) {
    final scheme = CashTheme.schemeOf(context);
    final statusBarHeight = MediaQuery.paddingOf(context).top;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: Container(
          color: scheme.background.withValues(alpha: 0.6),
          child: Column(
            children: [
              SizedBox(height: statusBarHeight),
              SizedBox(
                height: titleBarHeight,
                child: Center(
                  child: CashText(
                    title,
                    size: CashFontSize.lg,
                    weight: CashFontWeight.medium,
                  ),
                ),
              ),
              ?bottom,
            ],
          ),
        ),
      ),
    );
  }
}
