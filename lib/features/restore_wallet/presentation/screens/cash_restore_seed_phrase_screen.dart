import 'package:cash_ui/cash_button.dart';
import 'package:cash_ui/cash_colors.dart';
import 'package:cash_ui/cash_gravity_icons.dart';
import 'package:cash_ui/cash_input.dart';
import 'package:cash_ui/cash_pop_in_animation.dart';
import 'package:cash_ui/cash_surface.dart';
import 'package:cash_ui/cash_text.dart';
import 'package:cash_ui/cash_theme.dart';
import 'package:cash_ui/cash_tokens.dart';

import 'package:flutter/cupertino.dart';

const _kSeedWords = <String>[
  "zoo",
  "wisdom",
  "gravity",
  "energy",
  "carpet",
  "narrow",
  "outdoor",
  "silver",
  "planet",
  "jungle",
  "flame",
  "bronze",
];

class CashRestoreSeedPhraseScreen extends StatelessWidget {
  const CashRestoreSeedPhraseScreen({super.key});

  Widget _wordPill(CashColorScheme scheme, String index, String word) {
    return CashSurface(
      bordered: false,
      radius: CashRadius.full,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CashText("$index:", color: scheme.muted),
          SizedBox(width: 4),
          CashText(word),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = CashTheme.schemeOf(context);

    return CupertinoPageScaffold(
      backgroundColor: scheme.background,
      resizeToAvoidBottomInset: true,
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CashSurface(
                      width: 96,
                      height: 96,
                      radius: CashRadius.xxl,
                      bordered: false,
                    ),
                    SizedBox(height: 16),
                    CashText(
                      "Secret recovery phrase",
                      size: CashFontSize.xxl,
                      weight: .w500,
                    ),
                    SizedBox(height: 8),

                    CashText(
                      "Recover your wallet using your 12- or 24-word seed phrase. Make sure nobody is around watching you.",
                      align: .center,
                      color: scheme.muted,
                    ),

                    SizedBox(height: 16),

                    CashPopInAnimation(
                      child: CashSurface(
                        bordered: false,
                        radius: CashRadius.xxl,
                        width: double.infinity,
                        padding: EdgeInsets.all(18),
                        child: Column(
                          children: [
                            CashText(
                              "A seed phrase was detected in your clipboard. Would you like to continue with it?",
                            ),

                            SizedBox(height: 16),

                            Row(
                              children: [
                                Expanded(
                                  child: CashButton(
                                    label: "Yes",
                                    onPressed: () {},
                                  ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: CashButton(
                                    label: "Dismiss",
                                    variant: .tertiary,
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 16),

                    Align(
                      alignment: Alignment.center,
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          for (final (i, word) in _kSeedWords.indexed)
                            _wordPill(scheme, "${i + 1}", word),
                        ],
                      ),
                    ),

                    SizedBox(height: 12),

                    CashInput(
                      size: .lg,
                      radius: CashRadius.xxl,
                      startContent: Icon(CashGravityIcons.pencil),
                      placeholder: "Please enter the word #13",
                      isClearable: true,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: CashButton(
                label: "Confirm",
                isFullWidth: true,
                variant: .tertiary,
                isDisabled: true,
                size: .lg,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
