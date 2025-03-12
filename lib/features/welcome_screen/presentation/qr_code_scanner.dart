import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:tombola/utils/constants.dart';
import 'package:tombola/utils/extensions.dart';

class QrCodeScanner extends StatefulWidget {
  const QrCodeScanner({
    super.key,
    required this.onDetectCode,
  });

  final void Function(String? detectedCode) onDetectCode;

  @override
  State<QrCodeScanner> createState() => _QrCodeScannerState();
}

class _QrCodeScannerState extends State<QrCodeScanner> {
  Barcode? _detectedCode;

  late final _controller = MobileScannerController(
    formats: [BarcodeFormat.qrCode],
  );

  Timer? _timer;

  @override
  void dispose() {
    unawaited(_controller.dispose());
    _timer?.cancel();
    super.dispose();
  }

  void _setupTimer() {
    _timer?.cancel();
    _timer = Timer(1.seconds, () {
      if (_detectedCode != null && mounted) {
        setState(() {
          _detectedCode = null;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constrants) {
          return Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: MobileScanner(
                  controller: _controller,
                  scanWindow: Rect.fromCenter(
                    center: Offset(
                      constrants.maxWidth / 2,
                      constrants.maxHeight / 2,
                    ),
                    width: constrants.maxWidth,
                    height: constrants.maxHeight,
                  ),
                  onDetect: (capture) {
                    final resCode = capture.barcodes.firstOrNull;
                    if (resCode != null) {
                      setState(() {
                        _detectedCode = resCode;
                      });
                      _setupTimer();
                      return;
                    }

                    setState(() {
                      _detectedCode = null;
                    });
                  },
                ),
              ),
              if (_detectedCode != null) ...[
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.black.withValues(
                      alpha: 0.5,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Text(
                          _detectedCode!.rawValue ?? '',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacing.small.h,
                        FilledButton(
                          onPressed: () {
                            widget.onDetectCode(_detectedCode!.rawValue);
                          },
                          child: const Text('Conferma'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class BarcodePainter extends CustomPainter {
  BarcodePainter(this.corners);

  final List<Offset> corners;

  @override
  void paint(Canvas canvas, Size size) {
    if (corners.isEmpty) return;

    final paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path()..moveTo(corners.first.dx, corners.first.dy);

    for (final corner in corners.skip(1)) {
      path.lineTo(corner.dx, corner.dy);
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
