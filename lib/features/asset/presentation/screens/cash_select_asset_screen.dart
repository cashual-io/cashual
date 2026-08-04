import 'package:cash_ui/cash_close_button.dart';
import 'package:cash_ui/cash_fade_edge.dart';
import 'package:cash_ui/cash_gravity_icons.dart';
import 'package:cash_ui/cash_input.dart';
import 'package:cash_ui/cash_text.dart';
import 'package:cash_ui/cash_theme.dart';
import 'package:cash_ui/cash_tokens.dart';
import 'package:cashual/features/asset/widgets/cash_asset_filter_chips.dart';
import 'package:cashual/features/asset/widgets/cash_asset_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

const _kAssetFilters = <CashAssetFilter>[
  (label: "All", imageUrl: null),
  (
    label: "Bitcoin",
    imageUrl:
        "https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Bitcoin.svg/3840px-Bitcoin.svg.png",
  ),
  (
    label: "EVM",
    imageUrl:
        "https://upload.wikimedia.org/wikipedia/commons/f/fd/Ethereum_Logo.png",
  ),
  (
    label: "Solana",
    imageUrl:
        "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5b/Solana_cryptocurrency.svg/250px-Solana_cryptocurrency.svg.png",
  ),
  (
    label: "EVM",
    imageUrl:
        "https://upload.wikimedia.org/wikipedia/commons/f/fd/Ethereum_Logo.png",
  ),
];

class CashSelectAssetScreen extends StatefulWidget {
  const CashSelectAssetScreen({super.key});

  @override
  State<CashSelectAssetScreen> createState() => _CashSelectAssetScreenState();
}

class _CashSelectAssetScreenState extends State<CashSelectAssetScreen> {
  String _activeFilter = "All";

  final _listScrollController = ScrollController();

  @override
  void dispose() {
    _listScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = CashTheme.schemeOf(context);

    return CupertinoPageScaffold(
      backgroundColor: scheme.background,
      navigationBar: CupertinoNavigationBar(
        border: null,
        backgroundColor: scheme.background,
        leading: CashText(
          "Select Wallet",
          size: CashFontSize.xl,
          weight: CashFontWeight.medium,
        ),
        trailing: CashCloseButton(onTap: () => context.pop()),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CashInput(
                placeholder: "Enter asset name",
                startContent: Icon(CashGravityIcons.magnifier),
                radius: CashRadius.xxl,
                isClearable: true,
                size: .lg,
              ),
              SizedBox(height: 12),
              CashAssetFilterChips(
                filters: _kAssetFilters,
                activeLabel: _activeFilter,
                onChanged: (label) => setState(() => _activeFilter = label),
              ),
              SizedBox(height: 16),
              Expanded(
                child: CashFadeEdge(
                  axis: Axis.vertical,
                  controller: _listScrollController,
                  child: ListView.separated(
                    controller: _listScrollController,
                    itemCount: 16,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final item = CashAssetListItem(onTap: () => {});
                      if (index == 5) {
                        return Hero(tag: "test", child: item);
                      }
                      return item;
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
