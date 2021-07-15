import 'package:bulundum_mobile/Login-Register/LoginPage.dart';
import 'package:bulundum_mobile/MainMenu/MenuPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  String sk1="",sk2="";
  bool LoggedIn = false;

  @override
  void initState(){
    getData();

  }

  getData() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sk1 = sharedPreferences.get("Username");
    sk2 = sharedPreferences.get("Password");
    print(sk1);
    print(sk2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 80),
              child: Image(
                image: AssetImage("img/bulundum_logo.png"),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                    Container(
                      color: Color(0xFF0078CE),
                      child: RaisedButton(
                        padding: EdgeInsets.all(20),
                        child: Text("Tap",style: TextStyle(color: Colors.white),),
                      ),
                    ),
                    Container(
                      color: Color(0xFF0078CE),
                      child: RaisedButton(
                        padding: EdgeInsets.all(20),
                        child: Text("Tap",style: TextStyle(color: Colors.white),),
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 70,
                  height: 90,
                  child: GestureDetector(
                    onTap: (){

                      initState();
                      if(sk1!=null && sk2 !=null){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MainMenu()));
                      }
                      else{
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => LoginMain()));
                      }
                    },
                    child: Container(
                      child: Image(image: AssetImage("img/right_arrow.png") ,)
                    ),
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
