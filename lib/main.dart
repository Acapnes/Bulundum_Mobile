import 'package:bulundum_mobile/Buluntu/BuluntuListele.dart';
import 'package:bulundum_mobile/Pages/Other/LoadingPage.dart';
import 'package:bulundum_mobile/Pages/Login-Register/LoginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Init {
  getSK() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.get("username") != null && sharedPreferences.get("password") != null)
      print(sharedPreferences.get("username"));
  }

  Init._();
  static final instance = Init._();
  Future initialize() async {
    /// Uygulama açılırken çekilecek kodlar buraya yazılacak.
    getSK();
    await Future.delayed(Duration(milliseconds: 2000));
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Init.instance.initialize(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(home: mainLoadingPage());
        } else {
          return MaterialApp(home: MainBuluntuList());
        }
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  PageController pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          pageSnapping: true,
          controller: pageController,
          children: [
            // --- Page 1 ---
            Container(
              margin: EdgeInsets.only(top: 60),
              child: Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    margin: EdgeInsets.only(top: 80),
                    child: Image(
                      image: AssetImage("assets/lost_item.png"),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 40, left: 25, right: 25),
                      child: Text(
                        "Artık eşyanıza kavuşmanın ve eşyaları sahiplerine kavuşturmanın etkili bir yolu var.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 25, fontFamily: "Ubuntu"),
                      )),
                  Container(
                    height: 50,
                    width: 80,
                    margin:EdgeInsets.only(top: 80),
                    child: ElevatedButton(
                      onPressed: () async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        if (prefs.get("username") != null && prefs.get("password")  != null) {
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
                      child: Text("Atla",style: TextStyle(fontSize: 18,fontFamily: "Ubuntu"),),
                    ),
                  ),
                ],
              ),
            ),
            // --- Page 2 ---
            Container(
              margin: EdgeInsets.only(top: 60),
              child: Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    margin: EdgeInsets.only(top: 80),
                    child: Image(
                      image: AssetImage("assets/lost_item.png"),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 40, left: 25, right: 25),
                      child: Text(
                        "Kolay, hızlı ve sıkıntısız.\n\nBuluntu kaydı\nKayıp eşya bildirme",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 25, fontFamily: "Ubuntu"),
                      )),
                  Container(
                    height: 50,
                    width: 80,
                    margin:EdgeInsets.only(top: 80),
                    child: ElevatedButton(
                      onPressed: ()async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        if (prefs.get("username") != null && prefs.get("password")  != null) {
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
                      child: Text("Atla",style: TextStyle(fontSize: 18,fontFamily: "Ubuntu"),),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
