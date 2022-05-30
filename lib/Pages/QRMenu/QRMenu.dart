import 'package:bulundum_mobile/Controllers/Colors/primaryColors.dart';
import 'package:bulundum_mobile/Pages/QRMenu/QRCode.dart';
import 'package:bulundum_mobile/Pages/QRMenu/QRScan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QRMenu extends StatefulWidget {
  String qrData;

  QRMenu(this.qrData);
  @override
  _QRBMenuState createState() => _QRBMenuState();
}

class _QRBMenuState extends State<QRMenu> with SingleTickerProviderStateMixin {
  TabController _Tabcontroller;

  @override
  void initState() {
    super.initState();
    _Tabcontroller = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("QR Kod Menu"),centerTitle: true,backgroundColor: kPrimaryColor,
        bottom: TabBar(
          controller: _Tabcontroller,
          indicatorColor: Colors.white,
          tabs: [
            Tab(
              text: "QR Kodu",
            ),
            Tab(
              text: "Qr Tarayıcı",
            ),
          ],
        ),
      ),
      body: TabBarView(
          controller: _Tabcontroller,
          children: [mainQRCode(widget.qrData), QRScan()]),
    );
  }
}
