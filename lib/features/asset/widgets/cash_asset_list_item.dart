import 'package:cash_ui/cash_spinner.dart';
import 'package:cash_ui/cash_surface.dart';
import 'package:cash_ui/cash_tappable.dart';
import 'package:cash_ui/cash_text.dart';
import 'package:cash_ui/cash_theme.dart';
import 'package:cash_ui/cash_tokens.dart';
import 'package:flutter/cupertino.dart';

class CashAssetListItem extends StatelessWidget {
  const CashAssetListItem({super.key, this.isLoading = false});

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final scheme = CashTheme.schemeOf(context);

    return CashTappable(
      onTap: () {},
      child: CashSurface(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        radius: CashRadius.xxl,
        bordered: false,
        child: Row(
          mainAxisAlignment: .spaceBetween,
          crossAxisAlignment: .start,
          children: [
            Row(
              crossAxisAlignment: .center,
              children: [
                SizedBox(
                  width: 44,
                  height: 44,
                  child: Stack(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: scheme.tertiary,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Image.network(
                          "https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Bitcoin.svg/3840px-Bitcoin.svg.png",
                        ),
                      ),
                      if (isLoading)
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              color: scheme.surface,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(2.5),
                            child: CashSpinner(size: 13, color: scheme.primary),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: .start,
                  children: [
                    CashText("Bitcoin", size: CashFontSize.lg),
                    SizedBox(height: 2),
                    CashText("89.020003 BTC", color: scheme.muted),
                  ],
                ),
              ],
            ),
            Column(children: [CashText("\$8,282.11", size: CashFontSize.lg)]),
          ],
        ),
      ),
    );
  }
}
