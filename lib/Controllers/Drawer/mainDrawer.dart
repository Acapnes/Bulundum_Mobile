import 'package:bulundum_mobile/Controllers/Colors/primaryColors.dart';
import 'package:bulundum_mobile/KayipEsya/Kay%C4%B1pEsyaListele.dart';
import 'package:bulundum_mobile/Pages/Login-Register/LoginPage.dart';
import 'package:bulundum_mobile/main.dart';
import 'package:flutter/material.dart';

class mainDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateFulDrawer();
  }
}

class StateFulDrawer extends State {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all((20)),
            color: kPrimaryColor,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(top: 10, bottom: 15),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/icon-v1.png'),
                          fit: BoxFit.cover,
                        ),
                      )),
                  Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Bulundum",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )),
                  Text(
                    "Bulundum@hotmail.com",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.event_note),
            title: Text("Giriş Ekranı"),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyApp()));
            },
          ),
        ],
      ),
    );
  }
}
