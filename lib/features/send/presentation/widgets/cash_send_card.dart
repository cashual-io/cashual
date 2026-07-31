import 'package:cash_ui/cash_avatar_with_name.dart';
import 'package:cash_ui/cash_input.dart';
import 'package:cash_ui/cash_text.dart';
import 'package:cash_ui/cash_tokens.dart';
import 'package:flutter/cupertino.dart';

const _kAddressBookNames = [
  "Savings",
  "Checking",
  "Travel",
  "Rent",
  "Groceries",
];

class CashSendCard extends StatelessWidget {
  const CashSendCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      mainAxisSize: .min,
      children: [
        CashInput(
          startContent: Icon(CupertinoIcons.profile_circled),
          placeholder: "Receiver wallet address",
          size: CashSize.lg,
          radius: CashRadius.xxl,
        ),
        SizedBox(height: 16),
        CashText(
          "Contacts:",
          size: CashFontSize.lg,
          weight: CashFontWeight.medium,
        ),
        SizedBox(height: 16),
        Row(
          children: [
            for (final (index, name) in _kAddressBookNames.indexed) ...[
              if (index > 0) SizedBox(width: 8),
              Expanded(
                child: CashAvatarWithName(
                  imageUrl:
                      "https://api.dicebear.com/10.x/glyphs/png?seed=$name",
                  name: name,
                  onTap: () {},
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
