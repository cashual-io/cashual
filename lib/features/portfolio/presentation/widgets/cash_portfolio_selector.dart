import 'package:cash_ui/cash_tappable.dart';
import 'package:cash_ui/cash_text.dart';
import 'package:cash_ui/cash_tokens.dart';
import 'package:flutter/cupertino.dart';

class CashPortfolioSelector extends StatelessWidget {
  const CashPortfolioSelector({
    super.key,
    required this.imageUrl,
    required this.portfolioName,
    this.onTap,
  });

  final String imageUrl;
  final String portfolioName;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return CashTappable(
      onTap: onTap,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              imageUrl,
              width: 42,
              height: 42,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: .start,
            children: [
              CashText(
                portfolioName,
                size: CashFontSize.xl,
                weight: CashFontWeight.medium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
