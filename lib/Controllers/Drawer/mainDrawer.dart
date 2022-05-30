import 'package:bulundum_mobile/Buluntu/BuluntuListele.dart';
import 'package:bulundum_mobile/Buluntu/FotoBuluntuEkle.dart';
import 'package:bulundum_mobile/Controllers/Colors/primaryColors.dart';
import 'package:bulundum_mobile/Pages/Login-Register/LoginPage.dart';
import 'package:bulundum_mobile/Pages/Profile/Profile.dart';
import 'package:bulundum_mobile/main.dart';
import 'package:flutter/cupertino.dart';
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
            padding: EdgeInsets.all(20),
            color: kPrimaryColor,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                      width: 200,
                      height: 200,
                      margin: EdgeInsets.only(top: 10, bottom: 15),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/lost_item.png'),
                          fit: BoxFit.cover,
                        ),
                      )),
                  Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Buluntu - Kayıp Eşya",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )),
                  Text(
                    "Alper@hotmail.com",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text("Listeleme Ekranı"),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MainBuluntuList()));
            },
          ),
          ListTile(
            leading: Icon(Icons.add_box),
            title: Text("Eşya Ekleme"),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MainFoto()));
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Kullanıcı Profili"),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MainProfile()));
            },
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text("Yardım"),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MainProfile()));
            },
          ),
          SizedBox(height: 10),
          Text("Developer's Drawer",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
          SizedBox(height: 10),
          DropdownMenuItem(
            child: ListTile(
              leading: Icon(Icons.developer_board),
              title: Text("Giriş Ekranı"),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyHomePage()));
              },
            ),
          ),
          DropdownMenuItem(
            child: ListTile(
              leading: Icon(Icons.developer_board),
              title: Text("Login Ekranı"),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => LoginMain()));
              },
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Tüm Hakları saklıdır.",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500,color: kPrimaryColor)),
                          Icon(Icons.privacy_tip,size: 40,color: kPrimaryColor,)
                        ],
                      ),
                  )],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
