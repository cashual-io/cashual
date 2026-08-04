import 'package:flutter/widgets.dart';

class CashSendBlinkingCursor extends StatefulWidget {
  const CashSendBlinkingCursor({
    super.key,
    required this.color,
    required this.height,
  });

  final Color color;
  final double height;

  @override
  State<CashSendBlinkingCursor> createState() => _CashSendBlinkingCursorState();
}

class _CashSendBlinkingCursorState extends State<CashSendBlinkingCursor>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: Container(
        width: 3,
        height: widget.height,
        margin: const EdgeInsets.only(left: 2),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}
