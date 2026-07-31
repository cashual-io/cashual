import 'package:cash_ui/cash_tappable.dart';
import 'package:cash_ui/cash_text.dart';
import 'package:cash_ui/cash_theme.dart';
import 'package:cash_ui/cash_tokens.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

typedef _NavItem = ({IconData icon, String label});

const _kNavItems = <_NavItem>[
  (icon: CupertinoIcons.house_fill, label: "Home"),
  (icon: CupertinoIcons.square_stack_3d_down_right_fill, label: "Assets"),
  (icon: CupertinoIcons.person_2_fill, label: "Contacts"),
  (icon: CupertinoIcons.settings, label: "Settings"),
];

class CashMainLayout extends StatelessWidget {
  const CashMainLayout({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _onNavTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = CashTheme.schemeOf(context);

    return CupertinoPageScaffold(
      backgroundColor: scheme.background,
      child: Column(
        children: [
          Expanded(child: navigationShell),
          Container(
            decoration: BoxDecoration(
              color: scheme.surface,
              border: Border(top: BorderSide(color: scheme.border)),
            ),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    for (final (index, item) in _kNavItems.indexed)
                      Expanded(
                        child: CashTappable(
                          onTap: () => _onNavTap(index),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Column(
                              mainAxisSize: .min,
                              crossAxisAlignment: .center,
                              children: [
                                Icon(
                                  item.icon,
                                  size: 26,
                                  color: index == navigationShell.currentIndex
                                      ? scheme.primary
                                      : scheme.muted,
                                ),
                                const SizedBox(height: 4),
                                CashText(
                                  item.label,
                                  size: CashFontSize.sm,
                                  color: index == navigationShell.currentIndex
                                      ? scheme.primary
                                      : scheme.muted,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
