import 'dart:math';

import 'package:cash_ui/cash_button.dart';
import 'package:cash_ui/cash_close_button.dart';
import 'package:cash_ui/cash_modal_popup.dart';
import 'package:cash_ui/cash_surface.dart';
import 'package:cash_ui/cash_text.dart';
import 'package:cash_ui/cash_theme.dart';
import 'package:cash_ui/cash_tokens.dart';
import 'package:cash_ui/cash_gravity_icons.dart';
import 'package:cashual/features/asset/widgets/cash_asset_list_item.dart';
import 'package:cashual/features/send/presentation/widgets/cash_send_amount_input.dart';
import 'package:cashual/features/send/presentation/widgets/cash_send_background_pattern.dart';
import 'package:cashual/features/send/presentation/widgets/cash_send_confirmation_card.dart';
import 'package:cashual/features/send/presentation/widgets/cash_send_keyboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class CashSendScreen extends StatefulWidget {
  const CashSendScreen({super.key});

  @override
  State<CashSendScreen> createState() => _CashSendScreenState();
}

class _CashSendScreenState extends State<CashSendScreen> {
  final _random = Random();

  // receiving address
  // transaction speed

  // [10%] [25%] [50%] [75%] [100%]

  String _amount = "";
  Offset _patternOffset = Offset.zero;
  bool _isPercentageMode = false;

  void _onKeyPressed(String key) {
    setState(() {
      if (_isPercentageMode) {
        _amount = key;
      } else {
        switch (key) {
          case "clear":
            _amount = _amount.isEmpty
                ? ""
                : _amount.substring(0, _amount.length - 1);
          case ".":
            if (_amount.isEmpty) {
              _amount = "0.";
            } else if (!_amount.contains(".")) {
              _amount = "$_amount.";
            }
          default:
            _amount = _amount == "0" ? key : "$_amount$key";
        }
      }

      _patternOffset = Offset(
        (_random.nextDouble() - 0.5) * 0.08,
        (_random.nextDouble() - 0.5) * 0.08,
      );
    });
  }

  void _togglePercentageMode() {
    HapticFeedback.selectionClick();
    setState(() => _isPercentageMode = !_isPercentageMode);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = CashTheme.schemeOf(context);

    return CupertinoPageScaffold(
      backgroundColor: scheme.background,
      navigationBar: CupertinoNavigationBar(
        leading: CashText(
          "Send",
          size: CashFontSize.xl,
          weight: CashFontWeight.medium,
        ),
        trailing: CashCloseButton(onTap: () {}),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(16),
          child: Column(
            children: [
              Hero(
                tag: "test",
                child: CashAssetListItem(
                  onTap: () => {
                    HapticFeedback.selectionClick(),
                    context.push("/select-asset"),
                  },
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CashSendBackgroundPattern(offset: _patternOffset),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: .center,
                        children: [
                          CashSendAmountInput(amount: _amount),
                          CashSurface(
                            bordered: false,
                            radius: CashRadius.xxl,
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            child: CashText("USD: 3.38193"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: .start,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              "https://api.dicebear.com/10.x/glyphs/png?seed=Amanda",
                              width: 44,
                              height: 44,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: .start,
                            children: [
                              CashText("Amanda Torres", size: CashFontSize.lg),
                              SizedBox(height: 2),
                              CashText("bc1qsr...wrue", color: scheme.muted),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: .end,
                    children: [
                      CashText("Speed", color: scheme.muted),
                      SizedBox(height: 4),
                      CashText("~10secs", size: CashFontSize.lg),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 14),
              Row(
                children: [
                  CashButton(
                    startContent: Icon(
                      _isPercentageMode
                          ? CashGravityIcons.keyboard
                          : CashGravityIcons.percent,
                      size: 18,
                    ),
                    isIconOnly: true,
                    variant: .tertiary,
                    size: .lg,
                    onPressed: _togglePercentageMode,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: CashButton(
                      label: "Confirm",
                      endContent: const Icon(
                        CashGravityIcons.arrowRight,
                        size: 20,
                      ),
                      isFullWidth: true,
                      size: .lg,
                      onPressed: () {
                        showCashModalPopup(
                          context: context,
                          title: "Confirm",
                          child: const CashSendConfirmationCard(),
                          actions: [
                            CashButton(
                              label: "Send",
                              isFullWidth: true,
                              size: .lg,
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14),
              CashSendKeyboard(
                onKeyPressed: _onKeyPressed,
                isPercentageMode: _isPercentageMode,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
