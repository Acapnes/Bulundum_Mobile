import 'package:bulundum_mobile/Buluntu/BuluntuListele.dart';
import 'package:bulundum_mobile/Pages/Login-Register/LoginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Ubuntu'),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  PageController pageController = PageController(initialPage: 0);

  AnimationController _controller;
  String sk1 = "", sk2 = "";
  bool loggedIn = false, animRunn = false;

  int currenrPage=0;

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
    sk1 = sharedPreferences.get("sk1");
    sk2 = sharedPreferences.get("sk2");
    print(sk1);
    print(sk2);
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
      appBar: AppBar(title: Text("Giriş Ekranı"),centerTitle: true,
        actions: [
          IconButton(icon: currenrPage == 0 ? Icon(null) : Icon(Icons.arrow_back_ios),onPressed: (){
            if(currenrPage!=0){
            setState(() {
              currenrPage--;
            });
            }
            pageController.animateToPage(currenrPage, duration: Duration(milliseconds: 500), curve: Curves.easeOutSine);
          },),

          IconButton(icon: Icon(Icons.arrow_forward_ios),onPressed: (){
            if(currenrPage!=2){
              setState(() {
                currenrPage++;
              });
            }
            pageController.animateToPage(currenrPage, duration: Duration(milliseconds: 500), curve: Curves.easeOutSine);
          },),
        ],
      ),
        body: PageView(
      pageSnapping: true,
      controller: pageController,
      onPageChanged: (index) {
        print(index);
        if (index == 2) {
          setState(() {
            if (animRunn == false) {
              _controller = AnimationController(
                duration: const Duration(seconds: 1),
                vsync: this,
              )..forward();
              animRunn = false;
            }
          });
        }
      },
      children: [
        // --- Page 1 ---
        Container(
          margin: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 3,
                margin: EdgeInsets.only(top: 80),
                child: Image(
                  image: AssetImage("img/icon.png"),
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
                    if (prefs.get("sk1") != null && prefs.get("sk2")  != null) {
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
          margin: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 3,
                margin: EdgeInsets.only(top: 80),
                child: Image(
                  image: AssetImage("img/icon.png"),
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
                    if (prefs.get("sk1") != null && prefs.get("sk2")  != null) {
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
        // --- Page 3 ---
        Container(
          margin: EdgeInsets.all(15),
          child: Stack(
            children: <Widget>[
              PositionedTransition(
                rect: _animation,
                child: FadeTransition(
                  opacity: _controller,
                  child: Container(
                    margin: EdgeInsets.only(top: 50),
                    child: Image(
                      image: AssetImage("img/icon.png"),
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
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      if (prefs.get("sk1") != null && prefs.get("sk2")  != null) {
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
      ],
    ));
  }
}
