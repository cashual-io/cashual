import 'dart:io';

import 'package:cash_ui/cash_button.dart';
import 'package:cash_ui/cash_colors.dart';
import 'package:cash_ui/cash_surface.dart';
import 'package:cash_ui/cash_tappable.dart';
import 'package:cash_ui/cash_text.dart';
import 'package:cash_ui/cash_tokens.dart';
import 'package:cashual/features/qrcode/presentation/widgets/qrcode_hero_shuttle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class CashQrcodeScanScreen extends StatefulWidget {
  const CashQrcodeScanScreen({super.key});

  @override
  State<CashQrcodeScanScreen> createState() => _CashQrcodeScanScreenState();
}

class _CashQrcodeScanScreenState extends State<CashQrcodeScanScreen> {
  QRViewController? controller;
  Barcode? result;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  bool _isFlashOn = false;
  CameraFacing _cameraFacing = CameraFacing.back;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }

    controller!.resumeCamera();
  }

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
                    // padding: const EdgeInsets.all(16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(CashRadius.xxl),
                      child: _buildQrView(context),
                    ),
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
                    variant: _isFlashOn ? .primary : .tertiary,
                    startContent: Icon(CupertinoIcons.lightbulb_fill, size: 20),
                    size: CashSize.md,
                    onPressed: _toggleFlash,
                    child: CashText(
                      _isFlashOn ? "Flashlight: on" : "Flashlight: off",
                    ),
                  ),
                  SizedBox(width: 16),
                  CashButton(
                    variant: .tertiary,
                    startContent: Icon(
                      CupertinoIcons.camera_rotate_fill,
                      size: 20,
                    ),
                    size: CashSize.md,
                    onPressed: _flipCamera,
                    child: CashText(
                      _cameraFacing == CameraFacing.front
                          ? "Front camera"
                          : "Back camera",
                    ),
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

  Widget _buildQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
    controller.getCameraInfo().then((facing) {
      if (mounted) setState(() => _cameraFacing = facing);
    });
  }

  Future<void> _toggleFlash() async {
    await controller!.toggleFlash();
    final isOn = await controller!.getFlashStatus();
    if (mounted) setState(() => _isFlashOn = isOn ?? false);
  }

  Future<void> _flipCamera() async {
    final facing = await controller!.flipCamera();
    if (mounted) setState(() => _cameraFacing = facing);
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('no Permission')));
    }
  }
}
