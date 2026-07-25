import 'package:cash_ui/cash_button.dart';
import 'package:cash_ui/cash_colors.dart';
import 'package:cash_ui/cash_surface.dart';
import 'package:cash_ui/cash_tappable.dart';
import 'package:cash_ui/cash_text.dart';
import 'package:cash_ui/cash_tokens.dart';
import 'package:cashual/features/qrcode/presentation/widgets/qrcode_hero_shuttle.dart';
import 'package:flutter/cupertino.dart';

class CashQrcodeScanScreen extends StatefulWidget {
  const CashQrcodeScanScreen({super.key});

  @override
  State<CashQrcodeScanScreen> createState() => _CashQrcodeScanScreenState();
}

class _CashQrcodeScanScreenState extends State<CashQrcodeScanScreen> {
  @override
  Widget build(BuildContext context) {
    const darkScheme = CashColors.dark;

    return CupertinoPageScaffold(
      backgroundColor: darkScheme.background,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Hero(
                tag: qrCodeHeroTag,
                flightShuttleBuilder: qrCodeHeroFlightShuttleBuilder,
                createRectTween: qrCodeHeroRectTween,
                child: CashTappable(
                  onTap: () {},
                  child: CashSurface(
                    bordered: false,
                    color: darkScheme.surface,
                    radius: CashRadius.xxl,
                    width: double.infinity,
                    height: 360,
                    padding: const EdgeInsets.all(16),
                    child: Container(),
                  ),
                ),
              ),
              SizedBox(height: 26),
              CashText("Point the camera to the QR code"),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: .center,
                children: [
                  CashButton(
                    variant: .tertiary,
                    startContent: Icon(CupertinoIcons.lightbulb_fill, size: 20),
                    size: CashSize.md,
                    onPressed: () {},
                    child: CashText("Flashlight: off"),
                  ),
                  SizedBox(width: 16),
                  CashButton(
                    variant: .tertiary,
                    startContent: Icon(
                      CupertinoIcons.camera_rotate_fill,
                      size: 20,
                    ),
                    size: CashSize.md,
                    onPressed: () {},
                    child: CashText("Front camera"),
                  ),
                ],
              ),
              Expanded(child: Container()),
              CashButton(
                size: CashSize.lg,
                isFullWidth: true,
                variant: .tertiary,
                onPressed: () => Navigator.of(context).pop(),
                child: CashText("Cancel"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
