import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRBuluntu extends StatefulWidget {
  const QRBuluntu({Key key}) : super(key: key);

  @override
  _QRBuluntuState createState() => _QRBuluntuState();
}

class _QRBuluntuState extends State<QRBuluntu> {
  TextEditingController _QrController = new TextEditingController();
  String data;
  bool _flashOn = false;
  bool _frontCam = false;
  GlobalKey _qrKey = GlobalKey();
  QRViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          QRView(
            key: _qrKey,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.white,
            ),
            onQRViewCreated: (QRViewController controller) {
              this._controller = controller;
              controller.scannedDataStream.listen((val) {
                if (mounted) {
                  _controller.dispose();
                  Navigator.pop(context, val);
                }
              });
            },
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 80),
              child: Text(
                "QR Kod Okuyucu",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ButtonBar(
              alignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  color: Colors.white,
                  icon: Icon(_flashOn ? Icons.flash_on : Icons.flash_off,
                      size: 35),
                  onPressed: () {
                    setState(() {
                      _flashOn = !_flashOn;
                    });
                    _controller.toggleFlash();
                  },
                ),
                IconButton(
                  color: Colors.white,
                  icon: Icon(_frontCam ? Icons.camera_front : Icons.camera_rear,
                      size: 35),
                  onPressed: () {
                    setState(() {
                      _frontCam = !_frontCam;
                    });
                    _controller.flipCamera();
                  },
                ),
                IconButton(
                  color: Colors.white,
                  icon: Icon(
                    Icons.close,
                    size: 35,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
