import 'package:cash_ui/cash_button.dart';
import 'package:cash_ui/cash_gravity_icons.dart';
import 'package:cash_ui/cash_surface.dart';
import 'package:cash_ui/cash_theme.dart';
import 'package:cashual/features/welcome/presentation/widgets/cash_welcome_surface.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

final _kWelcomeSurfaceItems = <CashWelcomeSurfaceItem>[
  (
    leading: Container(),
    title: "Fully open-source",
    description:
        "There are many variations of passages of Lorem Ipsum available",
  ),
  (
    leading: Container(),
    title: "Bitcoin only & multichain",
    description:
        "There are many variations of passages of Lorem Ipsum available",
  ),
  (
    leading: Container(),
    title: "Seamless transactions",
    description:
        "There are many variations of passages of Lorem Ipsum available",
  ),
  (
    leading: Container(),
    title: "Real-time notifications",
    description:
        "There are many variations of passages of Lorem Ipsum available",
  ),
];

class CashWelcomeScreen extends StatelessWidget {
  const CashWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = CashTheme.schemeOf(context);

    return CupertinoPageScaffold(
      backgroundColor: scheme.background,
      child: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: .start,
          children: [
            CashSurface(
              bordered: false,
              radius: 0,
              height: 256,
              width: double.infinity,
              child: Container(),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsGeometry.all(16),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    CashWelcomeSurface(items: _kWelcomeSurfaceItems),
                    Expanded(child: Container()),
                    SizedBox(height: 32),
                    CashButton(
                      label: "Create new wallet",
                      isFullWidth: true,
                      size: .lg,
                      startContent: Icon(CashGravityIcons.plus, size: 20),
                      onPressed: () {},
                    ),
                    SizedBox(height: 12),
                    CashButton(
                      label: "Restore existing wallet",
                      variant: .tertiary,
                      isFullWidth: true,
                      size: .lg,
                      startContent: Icon(
                        CashGravityIcons.arrowRotateLeft,
                        size: 20,
                      ),
                      onPressed: () => context.push("/restore-wallet"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
