import 'package:cashual/cash_screen.dart';
import 'package:go_router/go_router.dart';

GoRouter createRouter() {
  return GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(
        path: "/",
        name: "CashScreen",
        builder: (context, state) => const CashScreen(),
      ),
    ],
  );
}
