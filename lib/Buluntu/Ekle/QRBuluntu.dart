import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRBuluntu extends StatefulWidget {
  const QRBuluntu({Key key}) : super(key: key);

  @override
  _QRBuluntuState createState() => _QRBuluntuState();
}

class _QRBuluntuState extends State<QRBuluntu> {

  TextEditingController _QrController = new TextEditingController();
  String data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 125,horizontal: 20),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: QrImage(
                version: QrVersions.auto,
                size: (MediaQuery.of(context).size.width/1.3),
                data: '$data',
              ),
            ),
            TextFormField(
              controller: _QrController,
              decoration: InputDecoration(
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                  borderSide: new BorderSide(),
                ),
                hintText: "Veriyi Giriniz",hintStyle: TextStyle(fontSize: 20),
              ),
            ),
            ElevatedButton(
              onPressed: (){
                setState(() {
                  data = _QrController.text;
                });
              },
              child: Text("Tamamla"),
            ),
          ],
        ),
      ),
    );
  }
}
