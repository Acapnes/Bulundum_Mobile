import 'package:bulundum_mobile/Buluntu/QRMenu/QRCode.dart';
import 'package:bulundum_mobile/Buluntu/QRMenu/QRScan.dart';
import 'package:bulundum_mobile/Controllers/Colors/primaryColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QRMenu extends StatefulWidget {

  @override
  _QRBMenuState createState() => _QRBMenuState();
}

class _QRBMenuState extends State<QRMenu> with SingleTickerProviderStateMixin {
  TabController _Tabcontroller;

  @override
  void initState() {
    super.initState();
    _Tabcontroller = TabController(length: 2, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("QR Kod"),centerTitle: true,backgroundColor: kPrimaryColor,
        bottom: TabBar(
          controller: _Tabcontroller,
          indicatorColor: Colors.white,
          tabs: [
            Tab(
              text: "QR KODUM",
            ),
            Tab(
              text: "KODU TARA",
            ),
          ],
        ),
      ),
      body: TabBarView(
          controller: _Tabcontroller,
          children: [mainQRCode(), QRScan()]),
    );
  }
}
