import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bulundum_mobile/Buluntu/BuluntuListele.dart';
import 'package:bulundum_mobile/Pages/Login-Register/LoginPage.dart';
import 'package:bulundum_mobile/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class mainLoadingPage extends StatefulWidget {
  @override
  _mainLoadingPageState createState() => _mainLoadingPageState();
}

class _mainLoadingPageState extends State<mainLoadingPage>
    with TickerProviderStateMixin {
  PageController pageController = PageController(initialPage: 0);
  AnimationController _controller;
  bool animRunn = false;
  int currenrPage = 0;

  @override
  void initState() {
    if (animRunn == false) {
      _controller = AnimationController(
        duration: const Duration(seconds: 1),
        vsync: this,
      )..forward();
      animRunn = false;
    }
    getData();
  }

  getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    globals.sk1 = sharedPreferences.get("sk1") ?? "";
    globals.sk2 = sharedPreferences.get("sk2") ?? "";
    if (globals.sk1 != "" && globals.sk2 != "") {
      await Future.delayed(Duration(milliseconds: 1500));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainBuluntuList()));
    } else {
      await Future.delayed(Duration(milliseconds: 1500));
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
    }
  }

  saveGlobals() async {
    final uri = Uri.https("dev.bulundum.com", "/api/v3/founditems", {
      /*'sk1': prefs.get("sk1"),
      'sk2': prefs.get("sk2"),
      'Page': "$pageNumber"*/
    });
    var response = await http.get(uri);
    var jsonData = jsonDecode(response.body);
    if(response.statusCode==200){
      print("Başarılı");
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Animation<RelativeRect> _animation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(0, 0, 0, MediaQuery.of(context).size.height),
      end: RelativeRect.fromLTRB(
          0, 0, 0, MediaQuery.of(context).size.height / 3),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    Animation<RelativeRect> _animation2 = RelativeRectTween(
      begin:
          RelativeRect.fromLTRB(0, 0, 0, -MediaQuery.of(context).size.height),
      end: RelativeRect.fromLTRB(
          0, 0, 0, -MediaQuery.of(context).size.height / 4),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Stack(
          children: <Widget>[
            PositionedTransition(
              rect: _animation,
              child: FadeTransition(
                opacity: _controller,
                child: Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Image(
                    image: AssetImage("assets/icon-v1.png"),
                  ),
                ),
              ),
            ),
            PositionedTransition(
              rect: _animation2,
              child: FadeTransition(
                opacity: _controller,
                child: Container(
                  margin: EdgeInsets.only(top: 80),
                  child: Image(
                    image: AssetImage("img/bulundum-yazi.png"),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 70,
                height: 90,
                child: GestureDetector(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    if (prefs.get("sk1") != null && prefs.get("sk2") != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MainBuluntuList())); //***MainBuluntuList
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  LoginMain())); //***LoginMain
                    }
                  },
                  child: Container(
                      child: Image(
                    image: AssetImage("img/right_arrow.png"),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
