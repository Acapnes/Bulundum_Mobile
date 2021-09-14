import 'dart:convert';
import 'package:bulundum_mobile/Buluntu/BuluntuListele.dart';
import 'package:bulundum_mobile/Buluntu/Ekle/FotoBuluntu.dart';
import 'package:bulundum_mobile/FAB/mainFAB.dart';
import 'package:flutter/widgets.dart';
import 'package:bulundum_mobile/BottomNavigationBar/mainBNB.dart';
import 'package:bulundum_mobile/Colors/primaryColors.dart';
import 'package:bulundum_mobile/Drawer/mainDrawer.dart';
import 'package:bulundum_mobile/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class mainProfile extends StatefulWidget {
  @override
  _mainProfileState createState() => _mainProfileState();
}

class _mainProfileState extends State<mainProfile> {
  int status = 1;
  bool Company = false;
  Color statusFontColor = Colors.green;
  bool isChecked = true;
  TextEditingController textFirstNameController = TextEditingController();
  TextEditingController textLastNameController = TextEditingController();
  TextEditingController textEmailController = TextEditingController();
  TextEditingController textPhoneController = TextEditingController();
  TextEditingController textPasswordController = TextEditingController();

  //String Firstname="", Lastname="",Email="",Phone="";

  @override
  void initState() {
    super.initState();
    openProfile();
  }

  openProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.get("CompanyType"));
    final uri = Uri.https("dev.bulundum.com", "/api/v3/profile", {
      'sk1': prefs.get("sk1"),
      'sk2': prefs.get("sk2"),
    });
    var response = await http.get(uri);
    print(response.body);
    var jsonData = jsonDecode(response.body);
    print(jsonData);

    prefs.setString('Firstname', jsonData["Firstname"]);
    prefs.setString('Lastname', jsonData["Lastname"]);
    prefs.setString('Email', jsonData["Email"]);
    prefs.setString('Phone', jsonData["Phone"]);

    setState(() {
      Company = prefs.get("CompanyType") != "ctNone";
      if (jsonData["inOffice"]) {
        status = 1;
        statusFontColor = Colors.green;
      } else {
        status = 0;
        statusFontColor = Colors.red;
      }
      textFirstNameController.text = jsonData["Firstname"];
      textLastNameController.text = jsonData["Lastname"];
      textEmailController.text = jsonData["Email"];
      textPhoneController.text = jsonData["Phone"];
    });
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var body = {
      'sk1': prefs.get("sk1"),
      'sk2': prefs.get("sk2"),
    };
    var response = await http
        .post(Uri.parse("https://dev.bulundum.com/api/v3/logout"), body: body);
    if (response.statusCode == 200) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
      prefs.remove("sk1");
      prefs.remove("sk2");
      prefs.remove("CompanyType");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Hesaptan çıkış işlemi başarısız.")));
    }
  }

  save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Firstname', textFirstNameController.text);
    prefs.setString('Lastname', textLastNameController.text);
    prefs.setString('Email', textEmailController.text);
    prefs.setString('Phone', textPhoneController.text);
    var body = {
      'sk1': prefs.get("sk1"),
      'sk2': prefs.get("sk2"),
      'Firstname': prefs.get("Firstname"),
      'Lastname': prefs.get("Lastname"),
      'Email': prefs.get("Email"),
      'Phone': prefs.get("Phone"),
      'Password': textPasswordController.text,
    };
    var response = await http
        .post(Uri.parse("https://dev.bulundum.com/api/v3/profile"), body: body);
    if (response.statusCode == 200) {
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Hesaptan çıkış işlemi başarısız.")));
    }
  }

  inOffice() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var body = {
      'sk1': prefs.get("sk1"),
      'sk2': prefs.get("sk2"),
      'inOffice': status == 1 ? "1" : "0",
    };

    var response = await http
        .post(Uri.parse("https://dev.bulundum.com/api/v3/profile"), body: body);
    print(response.body);
    print(body);
    if (response.statusCode == 200) {
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Hesaptan çıkış işlemi başarısız.")));
    }
  }

  void _showAction(BuildContext context, int index) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text("s"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('CLOSE'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: MaterialApp(
        theme: ThemeData(
            primaryColor: kPrimaryColor,
            accentColor: kPrimaryColor,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            fontFamily: 'Ubuntu'),
        home: Scaffold(
          floatingActionButton:
               ExpandableFab(
                  distance: 112.0,
                  children: [
                    ActionButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FotoBuluntu()));
                      },
                      icon: const Icon(Icons.add_box),
                      text: "Eşya Ekle",
                      textWidth: 100,
                      textHeight: 30,
                    ),
                    ActionButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainBuluntuList()));
                      },
                      icon: const Icon(Icons.add),
                      text: "Buluntu Ekle",
                      textWidth: 140,
                      textHeight: 30,
                    ),
                  ],
                ),
          drawer: mainDrawer(),
          backgroundColor: kPrimaryColor,
          appBar: AppBar(
            /*leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),*/
            title: Text("Profil"),
            centerTitle: true,
            /*actions: [
              PopupMenuButton(
                  onSelected: (value) {
                    /*if (value == 0) {
                      if (status != "İş Yerindeyim") {
                        setState(() {
                          status = "İş Yerindeyim";
                          statusFontColor = Colors.green;
                        });
                      } else {
                        setState(() {
                          status = "İş Yerinde Değilim";
                          statusFontColor = Colors.red;
                        });
                      }
                    }*/
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
            ],*/
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
                            /*Positioned(
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
                            ),*/
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
                              margin: EdgeInsets.only(),
                              child: Company
                                  ? Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                              margin: EdgeInsets.only(left: 100),
                                              child: status == 1
                                                  ? Text(
                                                      "İş Yerindeyim",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: statusFontColor,
                                                      ),
                                                    )
                                                  : Text(
                                                      "İş Yerinde Değilim",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: statusFontColor,
                                                      ),
                                                    )),
                                          MaterialButton(
                                              child: Container(
                                                  margin: EdgeInsets.only(right: 50),
                                                  child: Icon(Icons
                                                      .swap_horizontal_circle)),
                                              onPressed: () {
                                                if (status != 1) {
                                                  setState(() {
                                                    status = 1;
                                                    statusFontColor =
                                                        Colors.green;
                                                  });
                                                } else {
                                                  setState(() {
                                                    status = 0;
                                                    statusFontColor =
                                                        Colors.red;
                                                  });
                                                }
                                                inOffice();
                                              },
                                            ),
                                        ],
                                      ),
                                    )
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 5, right: 5, bottom: 5),
                        child: Card(
                          child: Column(children: <Widget>[
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(top: 10, left: 5),
                                child: SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.all(10),
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: "İsminiz",
                                            ),
                                            autocorrect: false,
                                            controller: textFirstNameController,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.all(10),
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: "Soyadınız",
                                            ),
                                            autocorrect: false,
                                            controller: textLastNameController,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.all(10),
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: "Email",
                                            ),
                                            autocorrect: false,
                                            controller: textEmailController,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.all(10),
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: "Telefon numaranız",
                                            ),
                                            autocorrect: false,
                                            controller: textPhoneController,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.all(10),
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: "Şifre",
                                            ),
                                            autocorrect: false,
                                            controller: textPasswordController,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 10, left: 10, right: 10),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              save();
                                            },
                                            child: ListTile(
                                              title: Text(
                                                "Kaydet",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18),
                                              ),
                                              trailing: Icon(
                                                Icons.save,
                                                color: Colors.white,
                                                size: 35,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 10, left: 10, right: 10),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.red),
                                            onPressed: () {
                                              logout();
                                            },
                                            child: ListTile(
                                              title: Text(
                                                "Oturumu kapat",
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
