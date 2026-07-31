import 'package:flutter/widgets.dart';
import 'cash_tappable.dart';
import 'cash_text.dart';
import 'cash_theme.dart';
import 'cash_tokens.dart';

class CashAvatarWithName extends StatelessWidget {
  const CashAvatarWithName({
    super.key,
    required this.imageUrl,
    required this.name,
    this.isActive = false,
    this.avatarSize = 50,
    this.onTap,
  });

  final String imageUrl;
  final String name;
  final bool isActive;
  final double avatarSize;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = CashTheme.schemeOf(context);

    Widget content = Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.network(
            imageUrl,
            width: avatarSize,
            height: avatarSize,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 6),
        CashText(
          name,
          weight: CashFontWeight.regular,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        SizedBox(
          width: 8,
          height: 8,
          child: isActive
              ? DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: scheme.primary,
                  ),
                )
              : null,
        ),
      ],
    );

    if (onTap != null) {
      content = CashTappable(onTap: onTap!, child: content);
    }

    return content;
  }
}
