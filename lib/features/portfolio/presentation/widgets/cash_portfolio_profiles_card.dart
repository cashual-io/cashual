import 'package:cash_ui/cash_avatar_with_name.dart';
import 'package:flutter/widgets.dart';

const _kProfileNames = [
  "Savings",
  "Checking",
  "Travel",
  "Rent",
  "Groceries",
  "Business",
  "Emergency",
  "Gifts",
  "Investing",
  "Vacation",
  "Savings",
];

class CashPortfolioProfilesCard extends StatelessWidget {
  const CashPortfolioProfilesCard({super.key});

  static const _crossAxisCount = 4;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < _kProfileNames.length; i += _crossAxisCount) ...[
          if (i > 0) SizedBox(height: 16),
          Row(
            children: [
              for (var j = i; j < i + _crossAxisCount; j++) ...[
                if (j > i) SizedBox(width: 8),
                Expanded(
                  child: j < _kProfileNames.length
                      ? CashAvatarWithName(
                          imageUrl:
                              "https://api.dicebear.com/10.x/glyphs/png?seed=${_kProfileNames[j]}",
                          name: _kProfileNames[j],
                          isActive: j == 0,
                          onTap: () {},
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ],
          ),
        ],
      ],
    );
  }
}
