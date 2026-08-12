import 'package:flutter/cupertino.dart';
import 'cash_close_button.dart';
import 'cash_surface.dart';
import 'cash_text.dart';
import 'cash_tokens.dart';

Future<T?> showCashModalPopup<T>({
  required BuildContext context,
  required String title,
  required Widget child,
  List<Widget> actions = const [],
  VoidCallback? onClose,
}) {
  return showCupertinoModalPopup<T>(
    context: context,
    builder: (context) {
      return AnimatedPadding(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: _DraggableDismissible(
          onDismiss: onClose ?? () => Navigator.of(context).pop(),
          child: CashModalSheet(
            title: title,
            onClose: onClose ?? () => Navigator.of(context).pop(),
            actions: actions,
            child: child,
          ),
        ),
      );
    },
  );
}

class _DraggableDismissible extends StatefulWidget {
  const _DraggableDismissible({required this.child, required this.onDismiss});

  final Widget child;
  final VoidCallback onDismiss;

  @override
  State<_DraggableDismissible> createState() => _DraggableDismissibleState();
}

class _DraggableDismissibleState extends State<_DraggableDismissible> {
  double _dragExtent = 0;
  bool _dragging = false;

  static const _dismissDistance = 120.0;
  static const _dismissVelocity = 700.0;

  void _onDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragging = true;
      _dragExtent = (_dragExtent + details.delta.dy).clamp(
        0.0,
        double.infinity,
      );
    });
  }

  void _onDragEnd(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;
    if (_dragExtent > _dismissDistance || velocity > _dismissVelocity) {
      widget.onDismiss();
      return;
    }
    setState(() {
      _dragging = false;
      _dragExtent = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: _onDragUpdate,
      onVerticalDragEnd: _onDragEnd,
      child: AnimatedContainer(
        duration: _dragging ? Duration.zero : const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, _dragExtent, 0),
        child: widget.child,
      ),
    );
  }
}

/// Uses [CashSurfaceVariant.base]; nest content in a [CashSurface] with
/// `.secondary` or `.tertiary` to stay visible against this background.
class CashModalSheet extends StatelessWidget {
  const CashModalSheet({
    super.key,
    required this.title,
    required this.onClose,
    required this.child,
    this.actions = const [],
  });

  final String title;
  final VoidCallback onClose;
  final Widget child;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final maxHeight =
        MediaQuery.sizeOf(context).height * 0.75 -
        MediaQuery.viewInsetsOf(context).bottom;

    return CashSurface(
      width: double.infinity,
      bordered: false,
      radius: CashRadius.xxl,
      variant: CashSurfaceVariant.base,
      padding: const EdgeInsets.all(24),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight),
        child: Column(
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          children: [
            Row(
              mainAxisAlignment: .spaceBetween,
              crossAxisAlignment: .center,
              children: [
                CashText(
                  title,
                  size: CashFontSize.xl,
                  weight: CashFontWeight.medium,
                ),
                CashCloseButton(onTap: onClose),
              ],
            ),
            SizedBox(height: 18),
            Flexible(child: SingleChildScrollView(child: child)),
            if (actions.isNotEmpty) ...[
              SizedBox(height: 16),
              for (final (index, action) in actions.indexed) ...[
                if (index > 0) SizedBox(height: 8),
                action,
              ],
            ],
          ],
        ),
      ),
    );
  }
}
