import 'package:bulundum_mobile/Buluntu/Ekle/FotoBuluntu.dart';
import 'package:bulundum_mobile/Buluntu/Ekle/QRBuluntu.dart';
import 'package:bulundum_mobile/Buluntu/Ekle/SesliBuluntu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class mainBuluntuEkle extends StatelessWidget {
  const mainBuluntuEkle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 75, left: 30, right: 30),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 30),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 7,
                  child: ElevatedButton(
                    child: ListTile(
                      title: Text(
                        "Normal Buluntu Ekle",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      trailing: Icon(
                        Icons.view_list,
                        size: 60,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 30),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 7,
                  child: ElevatedButton(
                    child: ListTile(
                      title: Text(
                        "Fotoğrafla Buluntu Ekle",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      trailing: Icon(
                        Icons.add_a_photo,
                        size: 60,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FotoBuluntu()));
                    },
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 30),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 7,
                  child: ElevatedButton(
                    child: ListTile(
                      title: Text(
                        "Ses Kaydı ile Buluntu Ekle",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      trailing: Icon(
                        Icons.mic,
                        size: 60,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MainSes()));
                    },
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 30),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 7,
                  child: ElevatedButton(
                    child: ListTile(
                      title: Text(
                        "QR Kod ile Buluntu Ekle",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      trailing: Icon(
                        Icons.qr_code,
                        size: 60,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => QRBuluntu()));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
