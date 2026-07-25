import 'package:cash_ui/cash_page_transitions.dart';
import 'package:cashual/features/portfolio/presentation/screens/cash_portfolio_screen.dart';
import 'package:cashual/features/qrcode/presentation/screens/cash_qrcode_scan_screen.dart';
import 'package:cashual/features/qrcode/presentation/widgets/qrcode_hero_shuttle.dart';
import 'package:go_router/go_router.dart';

GoRouter createRouter() {
  return GoRouter(
    initialLocation: "/portfolio",
    routes: [
      GoRoute(
        path: "/portfolio",
        name: "CashPortfolioScreen",
        builder: (context, state) => const CashPortfolioScreen(),
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
