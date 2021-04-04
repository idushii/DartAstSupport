import 'dart:math';

import 'package:Checkers/imports.dart';
import 'package:Checkers/screens/my_booking_screen.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

const flashOn = 'FLASH ON';
const flashOff = 'FLASH OFF';
const frontCamera = 'FRONT CAMERA';
const backCamera = 'BACK CAMERA';

class QrScanScreen extends StatefulWidget {
  static const route = '/QrScanScreen';

  @override
  _QrScanScreenState createState() => _QrScanScreenState();
}

class _QrScanScreenState extends State<QrScanScreen> {
  var qrText = '';
  var flashState = flashOn;
  var cameraState = frontCamera;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  String warning1 = null;
  bool warning2 = false;

  bool loading = false;

  StreamSubscription _subscription;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Positioned.fill(child: _buildQrView(context)),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SafeArea(
            right: false,
            left: false,
            bottom: false,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, bottom: 14),
                      child: AppBtnCircle(AppIcons.flash, () {
                        setState(() {
                          // flashState = true;
                          controller.toggleFlash();
                        });
                      }),
                    ),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur imperdiet ',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: AppFontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, bottom: 14),
                      child: AppBtnCircle(
                          AppIcons.clear, () => Navigator.pop(context)),
                    ),
                  ],
                ),
                Visibility(
                    visible: warning1 != null,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 11),
                      decoration: BoxDecoration(
                        color: AppColors.additionalRed,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Text(
                        warning1 ?? '',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )),
                Visibility(
                    visible: warning2,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 11),
                      decoration: BoxDecoration(
                        color: AppColors.additionalRed,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur imperdiet ',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ))
              ],
            ),
          ),
        ),
      ],
    ));
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = max(MediaQuery.of(context).size.width * 0.75, 240);
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      cameraFacing: CameraFacing.back,
      onQRViewCreated: _onQRViewCreated,
      formatsAllowed: [BarcodeFormat.qrcode],
      overlay: QrScannerOverlayShape(
        overlayColor: Colors.black.withOpacity(0.4),
        borderColor: Colors.white,
        borderRadius: 0,
        borderLength: 40,
        borderWidth: 4,
        cutOutSize: scanArea,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    _subscription = controller.scannedDataStream?.listen((scanData) async {
      if (loading) return;
      if (_subscription.isPaused) return;
      if (ModalRoute.of(context).isCurrent != true) return;
      var res = jsonDecode(scanData.code);

      setState(() => loading = true);
      try {
        var res1 = await loadBrone(context, res['id']);
        if (res1 is String) {
          showError1(res1);
        }
      } catch (e) {
        showError1('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur imperdiet ');
        print(e);
      }
      setState(() => loading = false);
    });
  }

  showError1(String error) async {
    setState(() => warning1 = error);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => warning1 = null);
  }

  @override
  void dispose() {
    _subscription.pause();
    _subscription.cancel();
    super.dispose();
  }
}

