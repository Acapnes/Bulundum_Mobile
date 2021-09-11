import 'package:bulundum_mobile/BottomNavigationBar/mainBNB.dart';
import 'package:bulundum_mobile/Colors/primaryColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class mainProfile extends StatefulWidget {
  @override
  _mainProfileState createState() => _mainProfileState();
}

class _mainProfileState extends State<mainProfile> {
  String status = "İş Yerindeyim";
  Color statusColor;
  Color statusFontColor = Colors.white;
  bool isChecked = true;

  @override
  void initState() {
    super.initState();
    if (status == "İş Yerindeyim") {
      setState(() {
        isChecked = true;
        statusColor = Colors.green;
      });
    } else {
      setState(() {
        statusColor = Colors.red;
        isChecked = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: MaterialApp(
        theme: ThemeData(
            primaryColor: kPrimaryColor,
           // accentColor: kPrimaryColor,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            fontFamily: 'Ubuntu'),
        home: Scaffold(
          backgroundColor: kPrimaryColor,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text("Profil"),
            centerTitle: true,
            actions: [
              PopupMenuButton(
                  onSelected: (value) {
                    if (value == 0) {
                      if (status != "İş Yerindeyim") {
                        setState(() {
                          status = "İş Yerindeyim";
                          statusColor = Colors.greenAccent;
                          statusFontColor = Colors.black;
                        });
                      } else {
                        setState(() {
                          status = "İş Yerinde Değilim";
                          statusColor = Colors.redAccent;
                          statusFontColor = Colors.white;
                        });
                      }
                    }
                  },
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 0,
                          child: Row(
                            children: [
                              Icon(
                                Icons.signal_wifi_statusbar_4_bar,
                                color: Colors.black,
                              ),
                              Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text("Durumu değiştir")),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 1,
                          child: Row(
                            children: [
                              Icon(
                                Icons.help,
                                color: Colors.black,
                              ),
                              Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text("Yardım al")),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 2,
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
                          value: 3,
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
                      elevation: 20,
                      child: Container(
                        height: 175,
                        width: MediaQuery.of(context).size.width - 20,
                        child: Stack(
                          children: [
                            Positioned(
                              right: 0,
                              top: 0,
                              child: PopupMenuButton(
                                  itemBuilder: (context) => [
                                        PopupMenuItem(
                                          child: Row(
                                            children: [
                                              Icon(Icons.photo_camera),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Text("Fotoğraf çek"),
                                              ),
                                            ],
                                          ),
                                          value: 0,
                                        ),
                                      ]),
                            ),
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
                            Container(
                              margin: EdgeInsets.only(bottom: 13, left: 5),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: GestureDetector(
                                  onTap: () {
                                    if (status != "İş Yerindeyim") {
                                      setState(() {
                                        status = "İş Yerindeyim";
                                      });
                                    } else {
                                      setState(() {
                                        status = "İş Yerinde Değilim";
                                      });
                                    }
                                  },
                                  child: Text(
                                    status,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline),
                                  ),
                                ),
                              ),
                            ),
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
                          child: Column(children: <Widget>[
                            TabBar(
                              labelColor: Colors.black,
                              unselectedLabelColor: Colors.grey,
                              tabs: [
                                Tab(
                                  icon: Icon(
                                    Icons.person,
                                    color: Colors.black,
                                  ),
                                  text: "Hesap",
                                ),
                                Tab(
                                  icon: Icon(
                                    Icons.security,
                                    color: Colors.black,
                                  ),
                                  text: "Güvenlik",
                                ),

                              ],
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(top: 10, left: 5),
                                child: TabBarView(
                                  children: [
                                    SingleChildScrollView(
                                      physics: BouncingScrollPhysics(),
                                      child: Container(
                                        child: Column(
                                          children: [
                                            ListTile(
                                              title: Text(
                                                "Kullanıcı adı ve soyadı:",
                                                style: TextStyle(fontSize: 18),
                                              ),
                                              subtitle: Text("adı ve soyadı",
                                                  style:
                                                      TextStyle(fontSize: 15)),
                                            ),
                                            ListTile(
                                              title: Text("Telefon Numarası:",
                                                  style:
                                                      TextStyle(fontSize: 18)),
                                              subtitle: Text("Numara",
                                                  style:
                                                      TextStyle(fontSize: 15)),
                                            ),
                                            ListTile(
                                              title: Text("E-Posta:",
                                                  style:
                                                      TextStyle(fontSize: 18)),
                                              subtitle: Text("Posta",
                                                  style:
                                                      TextStyle(fontSize: 15)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      physics: BouncingScrollPhysics(),
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            top: 10, left: 10, right: 10),
                                        child: Column(
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {},
                                              child: ListTile(
                                                title: Text(
                                                  "Şifre Değiştir",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                ),
                                                trailing: Icon(
                                                  Icons.lock,
                                                  color: Colors.white,
                                                  size: 35,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 15),
                                              child: ElevatedButton(
                                                onPressed: () {},
                                                child: ListTile(
                                                  title: Text(
                                                    "Çıkış Yap",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18),
                                                  ),
                                                  trailing: Icon(
                                                    Icons.logout,
                                                    color: Colors.white,
                                                    size: 35,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
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
      ),
    );
  }
}
