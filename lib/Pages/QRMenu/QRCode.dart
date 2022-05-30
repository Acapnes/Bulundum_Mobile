import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/rendering.dart';

class mainQRCode extends StatefulWidget {
  String qrData;

  mainQRCode(this.qrData);
  @override
  _mainQRCodeState createState() => _mainQRCodeState();
}

class _mainQRCodeState extends State<mainQRCode> {
  final qrdataFeed = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Qr Kod = "+widget.qrData);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              QrImage(
                //plce where the QR Image will be shown
                data: widget.qrData,
              ),
              SizedBox(
                height: 40.0,
              ),
              Text(
                "Eşyanın QR Kodu",
                style: TextStyle(fontSize: 20.0),
              ),
              TextField(
                enabled: false,
                controller: qrdataFeed,
                decoration: InputDecoration(
                  hintText: widget.qrData,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
