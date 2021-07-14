import 'package:bulundum_mobile/Login-Register/LoginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

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
  const MyHomePage({Key key}) : super(key: key);

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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginMain()));
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
