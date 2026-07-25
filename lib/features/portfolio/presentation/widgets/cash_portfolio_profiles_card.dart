import 'package:cash_ui/cash_tappable.dart';
import 'package:cash_ui/cash_text.dart';
import 'package:cash_ui/cash_tokens.dart';
import 'package:flutter/material.dart';

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

  Widget _buildProfileTile(String name, {required bool isActive}) {
    return CashTappable(
      onTap: () {},
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              "https://api.dicebear.com/10.x/glyphs/png?seed=$name",
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 6),
          CashText(
            name,
            weight: CashFontWeight.regular,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4),
          SizedBox(
            width: 8,
            height: 8,
            child: isActive
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.blue,
                    ),
                  )
                : null,
          ),
        ],
      ),
    );
  }

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
                      ? _buildProfileTile(_kProfileNames[j], isActive: j == 0)
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
