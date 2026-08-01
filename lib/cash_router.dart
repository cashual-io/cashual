import 'package:cash_ui/cash_page_transitions.dart';
import 'package:cashual/cash_main_layout.dart';
import 'package:cashual/cash_shell_transition_container.dart';
import 'package:cashual/features/asset/presentation/screens/cash_asset_screen.dart';
import 'package:cashual/features/contact/presentation/screens/cash_contacts_screen.dart';
import 'package:cashual/features/portfolio/presentation/screens/cash_portfolio_screen.dart';
import 'package:cashual/features/qrcode/presentation/screens/cash_qrcode_scan_screen.dart';
import 'package:cashual/features/qrcode/presentation/widgets/qrcode_hero_shuttle.dart';
import 'package:cashual/features/settings/presentation/screens/cash_settings_screen.dart';
import 'package:go_router/go_router.dart';

GoRouter createRouter() {
  return GoRouter(
    initialLocation: "/contacts",
    routes: [
      StatefulShellRoute(
        builder: (context, state, navigationShell) =>
            CashMainLayout(navigationShell: navigationShell),
        navigatorContainerBuilder: (context, navigationShell, children) =>
            CashShellTransitionContainer(
              currentIndex: navigationShell.currentIndex,
              children: children,
            ),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/portfolio",
                name: "CashPortfolioScreen",
                builder: (context, state) => const CashPortfolioScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/assets",
                name: "CashAssetScreen",
                builder: (context, state) => const CashAssetScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/contacts",
                name: "CashContactsScreen",
                builder: (context, state) => const CashContactsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/settings",
                name: "CashSettingsScreen",
                builder: (context, state) => const CashSettingsScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: "/qrcode-scan",
        name: "CashQrCodeScanScreen",
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const CashQrcodeScanScreen(),
          transitionDuration: const Duration(milliseconds: 450),
          reverseTransitionDuration: const Duration(milliseconds: 400),
          transitionsBuilder: heroCollapsingFadeTransitionsBuilder(
            enterCurve: qrCodeBackgroundFadeInCurve,
            exitCurve: qrCodeBackgroundFadeOutCurve,
          ),
        ),
      ),
    ],
  );
}
