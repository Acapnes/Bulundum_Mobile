import 'package:bulundum_mobile/Controllers/Colors/primaryColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class QRScan extends StatefulWidget {

  @override
  _QRScanState createState() => _QRScanState();
}

class _QRScanState extends State<QRScan> {
  String qrCode = '';

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.blueGrey,
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Tarama Sonucu',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '$qrCode',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 50),
          Container(
            margin: EdgeInsets.only(
                top: 10, left: 10, right: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: kPrimaryColor),
              onPressed: () {
                scanQRCode();
              },
              child: ListTile(
                title: Text(
                  "QR Kodu Tara",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18),
                ),
                trailing: Icon(
                  Icons.qr_code,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  Future<void> scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );

      if (!mounted) return;

      setState(() {
        this.qrCode = qrCode.isEmpty
            ? ''
            : qrCode == '-1'
            ? ''
            : qrCode;
        print(qrCode);
      });
    } on PlatformException {
      qrCode = 'Taramada bir hata oldu.';
    }
  }
}