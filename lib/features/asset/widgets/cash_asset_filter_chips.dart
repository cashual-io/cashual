import 'package:cash_ui/cash_chip.dart';
import 'package:cash_ui/cash_fade_edge.dart';
import 'package:flutter/widgets.dart';

typedef CashAssetFilter = ({String label, String? imageUrl});

class CashAssetFilterChips extends StatefulWidget {
  const CashAssetFilterChips({
    super.key,
    required this.filters,
    required this.activeLabel,
    required this.onChanged,
  });

  final List<CashAssetFilter> filters;
  final String activeLabel;
  final ValueChanged<String> onChanged;

  @override
  State<CashAssetFilterChips> createState() => _CashAssetFilterChipsState();
}

class _CashAssetFilterChipsState extends State<CashAssetFilterChips> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: CashFadeEdge(
        axis: Axis.horizontal,
        controller: _scrollController,
        child: ListView.separated(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: widget.filters.length,
          separatorBuilder: (context, index) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            final filter = widget.filters[index];
            return CashChip(
              label: filter.label,
              imageUrl: filter.imageUrl,
              isActive: widget.activeLabel == filter.label,
              onTap: () => widget.onChanged(filter.label),
            );
          },
        ),
      ),
    );
  }
}
