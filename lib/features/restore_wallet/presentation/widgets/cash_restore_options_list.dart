import 'package:cashual/features/restore_wallet/presentation/widgets/cash_restore_option_tile.dart';
import 'package:flutter/widgets.dart';

class CashRestoreOptionsList extends StatelessWidget {
  const CashRestoreOptionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CashRestoreOptionTile(
          leading: Container(),
          title: "Secret recovery phrase",
          description: "Restore using your 12 or 24 word seed phrase",
          onTap: () {},
        ),
        const SizedBox(height: 12),
        CashRestoreOptionTile(
          leading: Container(),
          title: "Hardware wallet",
          description: "Connect a Ledger or other hardware wallet",
          onTap: () {},
        ),
      ],
    );
  }
}
