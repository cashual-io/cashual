import 'package:cash_ui/cash_text.dart';
import 'package:cash_ui/cash_tokens.dart';
import 'package:flutter/widgets.dart';

class CashSendAmountDisplay extends StatefulWidget {
  const CashSendAmountDisplay({
    super.key,
    required this.value,
    required this.color,
    this.size = 60,
  });

  final String value;
  final Color color;
  final double size;

  @override
  State<CashSendAmountDisplay> createState() => _CashSendAmountDisplayState();
}

class _CashSendAmountDisplayState extends State<CashSendAmountDisplay> {
  static const _duration = Duration(milliseconds: 180);

  final _listKey = GlobalKey<AnimatedListState>();
  late List<String> _chars;

  @override
  void initState() {
    super.initState();
    _chars = widget.value.split("");
  }

  @override
  void didUpdateWidget(covariant CashSendAmountDisplay old) {
    super.didUpdateWidget(old);
    if (old.value == widget.value) return;

    final newChars = widget.value.split("");
    var prefix = 0;
    while (prefix < _chars.length &&
        prefix < newChars.length &&
        _chars[prefix] == newChars[prefix]) {
      prefix++;
    }

    for (var i = _chars.length - 1; i >= prefix; i--) {
      final removed = _chars.removeAt(i);
      _listKey.currentState?.removeItem(
        i,
        (context, animation) => _buildChar(removed, animation),
        duration: _duration,
      );
    }

    for (var i = prefix; i < newChars.length; i++) {
      _chars.insert(i, newChars[i]);
      _listKey.currentState?.insertItem(i, duration: _duration);
    }
  }

  Widget _buildChar(String char, Animation<double> animation) {
    return SizeTransition(
      axis: Axis.horizontal,
      sizeFactor: CurvedAnimation(parent: animation, curve: Curves.easeOut),
      child: FadeTransition(
        opacity: animation,
        child: Center(
          child: CashText(
            char,
            size: widget.size,
            weight: CashFontWeight.regular,
            color: widget.color,
            height: 1,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size * 1.2,
      child: AnimatedList(
        key: _listKey,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        initialItemCount: _chars.length,
        itemBuilder: (context, index, animation) =>
            _buildChar(_chars[index], animation),
      ),
    );
  }
}
