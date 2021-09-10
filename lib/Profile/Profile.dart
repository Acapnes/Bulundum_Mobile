import 'package:bulundum_mobile/BottomNavigationBar/mainBNB.dart';
import 'package:bulundum_mobile/Colors/primaryColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class mainProfile extends StatefulWidget {
  @override
  _mainProfileState createState() => _mainProfileState();
}

class _mainProfileState extends State<mainProfile> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Ubuntu'),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Profil"),
          centerTitle: true,
          actions: [
            PopupMenuButton(
                itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Row(
                          children: [
                            Icon(
                              Icons.settings,
                              color: Colors.black,
                            ),
                            Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Text("Ayarlar")),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        child: Row(
                          children: [
                            Icon(
                              Icons.logout,
                              color: Colors.black,
                            ),
                            Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Text("Çıkış yap")),
                          ],
                        ),
                      ),
                    ])
          ],
        ),
        bottomNavigationBar: mainBNB(),
        body: SafeArea(
          child: Container(
            color: kPrimaryColor,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Container(
              margin: EdgeInsets.only(top: 20),
              child: Column(
                children: <Widget>[
                  Card(
                    child: Container(
                      height: 175,
                      width: MediaQuery.of(context).size.width - 50,
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 30),
                            child: Center(
                              child: SizedBox(
                                height: 125,
                                width: 125,
                                child: CircleAvatar(
                                  maxRadius: 20,
                                  backgroundImage:
                                      AssetImage("img/circle-avatar.jpg"),
                                ),
                              ),
                            ),
                          ),
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: Text(
                                    "Kullanıcı adı ve soyadı",
                                    style: TextStyle(fontSize: 18),
                                  ))),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 440,
                    width: MediaQuery.of(context).size.width - 10,
                    child: Card(
                      child: DefaultTabController(
                        length: 2,
                        child: Column(children: <Widget>[TabBar(
                              tabs: [
                                Tab(icon: Icon(Icons.person,color: Colors.black,),text: "Kullanıcı",),
                                Tab(icon: Icon(Icons.security,color: Colors.black)),
                              ],
                            ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(10),
                              child: TabBarView(
                                  children: [
                                    Container(
                                      child: Text("araba"),
                                    ),
                                    Container(
                                      child: Text("araba2"),
                                    ),
                                  ],
                                ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
