import 'package:cash_ui/cash_pop_in_animation.dart';
import 'package:flutter/widgets.dart';

import 'cash_portfolio_selector.dart';

class CashPortfolioHeader extends StatelessWidget {
  const CashPortfolioHeader({
    super.key,
    required this.imageUrl,
    required this.portfolioName,
    this.onPortfolioTap,
    this.trailing,
  });

  final String imageUrl;
  final String portfolioName;
  final VoidCallback? onPortfolioTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CashPopInAnimation(
          child: CashPortfolioSelector(
            imageUrl: imageUrl,
            portfolioName: portfolioName,
            onTap: onPortfolioTap,
          ),
        ),
        ?trailing,
      ],
    );
  }
}
