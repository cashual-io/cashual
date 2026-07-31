import 'package:cash_ui/cash_button.dart';
import 'package:cash_ui/cash_colors.dart';
import 'package:cash_ui/cash_fade_edge.dart';
import 'package:cash_ui/cash_modal_popup.dart';
import 'package:cash_ui/cash_pop_in_animation.dart';
import 'package:cash_ui/cash_surface.dart';
import 'package:cash_ui/cash_tappable.dart';
import 'package:cash_ui/cash_text.dart';
import 'package:cash_ui/cash_theme.dart';
import 'package:cash_ui/cash_tokens.dart';
import 'package:cashual/features/asset/widgets/cash_asset_list_item.dart';
import 'package:cashual/features/portfolio/presentation/widgets/cash_portfolio_header.dart';
import 'package:cashual/features/portfolio/presentation/widgets/cash_portfolio_profiles_card.dart';
import 'package:cashual/features/qrcode/presentation/widgets/qrcode_hero_shuttle.dart';
import 'package:cashual/features/send/presentation/widgets/cash_send_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/physics.dart';
import 'package:go_router/go_router.dart';

class CashPortfolioScreen extends StatefulWidget {
  const CashPortfolioScreen({super.key});

  @override
  State<CashPortfolioScreen> createState() => _CashPortfolioScreenState();
}

class _CashPortfolioScreenState extends State<CashPortfolioScreen>
    with TickerProviderStateMixin {
  bool _isSending = true;

  static const _spring = SpringDescription(
    mass: 1,
    stiffness: 260,
    damping: 14,
  );

  late final AnimationController _sendingController = AnimationController(
    vsync: this,
    value: 1.0,
  );

  late final AnimationController _fadeController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 180),
    value: 1.0,
  );

  Future<void> _toggleSending() async {
    final hiding = _isSending;
    setState(() => _isSending = !_isSending);

    if (hiding) {
      // Text fades out first, then the space it leaves behind collapses.
      await _fadeController.reverse();
      await _sendingController.animateWith(
        SpringSimulation(_spring, _sendingController.value, 0.0, 0),
      );
    } else {
      // Space opens up first, then the text fades back in.
      await _sendingController.animateWith(
        SpringSimulation(_spring, _sendingController.value, 1.0, 0),
      );
      await _fadeController.forward();
    }
  }

  @override
  void dispose() {
    _sendingController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  Widget _buildBalanceSection(CashColorScheme scheme) {
    return Column(
      crossAxisAlignment: .center,
      children: [
        SizedBox(height: 32),
        CashText("Available balance", color: scheme.muted),
        SizedBox(height: 8),
        Row(
          crossAxisAlignment: .start,
          mainAxisAlignment: .center,
          children: [
            CashText(
              "112,832",
              size: CashFontSize.xxxxxl,
              weight: FontWeight.w400,
              height: 1.0,
            ),
            SizedBox(width: 4),
            Icon(
              CupertinoIcons.bolt_circle_fill,
              color: CashColors.light.warning,
              size: 26,
            ),
          ],
        ),
        SizedBox(height: 16),
        AnimatedBuilder(
          animation: Listenable.merge([_sendingController, _fadeController]),
          builder: (context, child) {
            final heightValue = _sendingController.value;
            return ClipRect(
              child: Align(
                alignment: Alignment.topCenter,
                heightFactor: heightValue.clamp(0.0, double.infinity),
                child: Opacity(
                  opacity: _fadeController.value.clamp(0.0, 1.0),
                  child: child,
                ),
              ),
            );
          },
          child: IgnorePointer(
            ignoring: !_isSending,
            child: CashTappable(
              onTap: _toggleSending,
              child: Row(
                mainAxisAlignment: .center,
                children: [
                  CashText("Incoming"),
                  SizedBox(width: 6),
                  Image.network(
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Bitcoin.svg/3840px-Bitcoin.svg.png",
                    width: 16,
                  ),
                  SizedBox(width: 4),
                  CashText("32"),
                  SizedBox(width: 2),
                  CashText("BTC"),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
        CashPopInAnimation(
          key: ValueKey(_isSending),
          child: Row(
            children: [
              Expanded(
                child: CashButton(
                  label: "Send",
                  size: CashSize.lg,
                  startContent: const Icon(
                    CupertinoIcons.paperplane_fill,
                    size: 16,
                  ),
                  onPressed: () {
                    showCashModalPopup(
                      context: context,
                      title: "Send asset",
                      child: const CashSendCard(),
                    );
                  },
                ),
              ),
              const SizedBox(width: 8),
              CashButton(
                label: 'Receive',
                size: CashSize.lg,
                variant: CashVariant.tertiary,
                startContent: const Icon(
                  CupertinoIcons.arrow_down_circle_fill,
                  size: 16,
                ),
                onPressed: () {},
              ),
              const SizedBox(width: 8),
              Hero(
                tag: qrCodeHeroTag,
                flightShuttleBuilder: qrCodeHeroFlightShuttleBuilder,
                createRectTween: qrCodeHeroRectTween,
                child: CashButton(
                  label: 'Scan',
                  size: CashSize.lg,
                  variant: CashVariant.tertiary,
                  startContent: const Icon(CupertinoIcons.qrcode, size: 16),
                  onPressed: () {
                    context.push("/qrcode-scan");
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = CashTheme.schemeOf(context);

    return CupertinoPageScaffold(
      backgroundColor: scheme.background,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(16),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              CashPortfolioHeader(
                imageUrl: "https://api.dicebear.com/10.x/glyphs/png?seed=Felix",
                portfolioName: "Savings",
                onPortfolioTap: () {
                  showCashModalPopup(
                    context: context,
                    title: "Profiles",
                    actions: [
                      CashButton(
                        isFullWidth: true,
                        variant: .secondary,
                        label: "Manage profiles",
                        size: .lg,
                        startContent: Icon(
                          CupertinoIcons.rectangle_stack_fill,
                          size: 18,
                        ),
                        onPressed: () {},
                      ),
                    ],
                    child: const CashPortfolioProfilesCard(),
                  );
                },
                trailing: CashButton(
                  isIconOnly: true,
                  size: CashSize.md,
                  variant: .tertiary,
                  startContent: const Icon(CupertinoIcons.bell_fill, size: 20),
                  onPressed: () {},
                ),
              ),
              const SizedBox(height: 16),
              _buildBalanceSection(scheme),
              SizedBox(height: 16),
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: .stretch,
                  children: [
                    SizedBox(
                      width: 128,
                      child: CashTappable(
                        onTap: () {},
                        child: CashSurface(
                          bordered: false,
                          width: double.infinity,
                          padding: EdgeInsets.all(16),
                          radius: CashRadius.xxl,
                          child: Placeholder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CashTappable(
                        onTap: () {},
                        child: CashSurface(
                          bordered: false,
                          width: double.infinity,
                          radius: CashRadius.xxl,
                          padding: EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 16,
                          ),
                          child: Column(
                            crossAxisAlignment: .start,
                            children: [
                              CashText(
                                "Transactions:",
                                weight: FontWeight.w500,
                              ),
                              SizedBox(height: 12),
                              CashFadeEdge(
                                axis: Axis.horizontal,
                                fadeStart: false,
                                child: SizedBox(
                                  height: 48,
                                  child: Stack(
                                    children: [
                                      for (final (index, seed) in [
                                        "Felix22231",
                                        "aasFelix22236",
                                        "aasFelix11131",
                                        "test2",
                                        "uuuuu",
                                      ].indexed)
                                        Positioned(
                                          left: index * 32.0,
                                          child: Container(
                                            padding: const EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: scheme.surface,
                                            ),
                                            child: ClipOval(
                                              child: Image.network(
                                                "https://api.dicebear.com/10.x/dylan/png?seed=$seed",
                                                width: 44,
                                                height: 44,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              Row(
                crossAxisAlignment: .center,
                mainAxisAlignment: .spaceBetween,
                children: [
                  CashText(
                    "Assets",
                    weight: FontWeight.w500,
                    size: CashFontSize.xl,
                  ),
                  CashButton(
                    isIconOnly: true,
                    size: CashSize.md,
                    variant: .tertiary,
                    startContent: Icon(
                      CupertinoIcons.slider_horizontal_3,
                      size: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14),
              CashAssetListItem(),
              SizedBox(height: 6),
              CashAssetListItem(),
              SizedBox(height: 6),
              CashAssetListItem(isLoading: true),
            ],
          ),
        ),
      ),
    );
  }
}
