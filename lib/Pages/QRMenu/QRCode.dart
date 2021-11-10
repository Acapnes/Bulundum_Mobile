import 'package:bulundum_mobile/Controllers/Colors/primaryColors.dart';
import 'package:flutter/material.dart';

class mainQRCode extends StatefulWidget {

  @override
  _mainQRCodeState createState() => _mainQRCodeState();
}

class _mainQRCodeState extends State<mainQRCode> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
          children: [
            Center(
              child: Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  border: Border.all(width: 2,color: kPrimaryColor),
                ),
                child: Center(
                  child: Container(
                    height: 200,
                    width: 200,
                    child: Image(image: AssetImage("assets/icon-v1.png"),),
                  ),
                ),
              ),
            ),
          ],
        ),
    );
  }
}
