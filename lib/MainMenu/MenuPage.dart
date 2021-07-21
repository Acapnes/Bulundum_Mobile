import 'package:bulundum_mobile/Buluntu/BuluntuEkle.dart';
import 'package:bulundum_mobile/Buluntu/BuluntuListele.dart';
import 'package:bulundum_mobile/Drawer/mainDrawer.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: mainDrawer(),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 140,horizontal: 20),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 40),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 6,
                child: RaisedButton(
                  color: Color(0xFF0078CE),
                  child: Text("Bir Şey Mi Buldunuz?",
                      style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => mainBuluntuEkle()));
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 40),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 6,
                child: RaisedButton(
                  color: Color(0xFFF9B217),
                  child: Text("Bir Şey Mi Kaybettiniz?",
                      style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => mainBuluntuEkle()));
                  },
                ),
              ),
            ),
            Center(
              child: Container(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height / 6,
                  child: RaisedButton(
                    color: Color(0xFFF9B217),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    child: Text("Buluntuları Listele",
                        style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainBuluntuList()));
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
