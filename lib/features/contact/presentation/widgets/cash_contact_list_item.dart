import 'package:cash_ui/cash_tappable.dart';
import 'package:cash_ui/cash_text.dart';
import 'package:cash_ui/cash_theme.dart';
import 'package:cash_ui/cash_tokens.dart';
import 'package:flutter/widgets.dart';

class CashContactListItem extends StatelessWidget {
  const CashContactListItem({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.address,
    this.badgeImageUrl,
    this.onTap,
  });

  final String imageUrl;
  final String name;
  final String address;
  final String? badgeImageUrl;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = CashTheme.schemeOf(context);

    return CashTappable(
      onTap: onTap ?? () {},
      child: Row(
        children: [
          SizedBox(
            width: 44,
            height: 44,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    imageUrl,
                    width: 44,
                    height: 44,
                    fit: BoxFit.cover,
                  ),
                ),
                if (badgeImageUrl != null)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: scheme.surface,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(2.5),
                      child: ClipOval(
                        child: Image.network(badgeImageUrl!, fit: BoxFit.cover),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                CashText(name, weight: .w400, size: CashFontSize.lg),
                SizedBox(height: 2),
                CashText(address, size: CashFontSize.lg, color: scheme.muted),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
