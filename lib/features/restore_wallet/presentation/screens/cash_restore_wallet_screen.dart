import 'package:cash_ui/cash_close_button.dart';
import 'package:cash_ui/cash_text.dart';
import 'package:cash_ui/cash_theme.dart';
import 'package:cash_ui/cash_tokens.dart';
import 'package:cashual/features/restore_wallet/presentation/widgets/cash_restore_option_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class CashRestoreWalletScreen extends StatelessWidget {
  const CashRestoreWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = CashTheme.schemeOf(context);

    return CupertinoPageScaffold(
      backgroundColor: scheme.background,
      navigationBar: CupertinoNavigationBar(
        border: null,
        backgroundColor: scheme.background,
        leading: CashText(
          "Restore wallet",
          size: CashFontSize.xl,
          weight: CashFontWeight.medium,
        ),
        trailing: CashCloseButton(onTap: () => context.pop()),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              CashText("Please select one of these options:"),
              SizedBox(height: 12),
              CashRestoreOptionTile(
                leading: Container(),
                title: "Secret recovery phrase",
                description: "Restore using your 12 or 24 word seed phrase",
                onTap: () => context.push("/restore-wallet/seed-phrase"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
