import 'dart:convert';

import 'package:bulundum_mobile/Buluntu/BuluntuListele.dart';
import 'package:bulundum_mobile/Drawer/mainDrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class mainBuluntuDetaylar extends StatefulWidget {
  final int number;

  const mainBuluntuDetaylar({Key key, this.number}) : super(key: key);

  @override
  _mainBuluntuDetaylarState createState() => _mainBuluntuDetaylarState(number);
}

class _mainBuluntuDetaylarState extends State<mainBuluntuDetaylar> {
  int number;
  List data;

  _mainBuluntuDetaylarState(this.number);

  Future<String> ListFoundItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final uri = Uri.https("dev.bulundum.com", "/api/v3/founditems",
        {'sk1': prefs.get("sk1"), 'sk2': prefs.get("sk2")});
    var response = await http.get(uri);
    setState(() {
      var jsonData = jsonDecode(response.body);
      data = jsonData["Records"];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.ListFoundItems();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        drawer: mainDrawer(),
        body: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, int index) {
            return Container(
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3,
                    decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        )),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 25),
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            data[number]["Title"],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ))),
                  Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Eşya numarası :",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Text(
                                      data[number]["Id"],
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Kayıt numarası :",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Text(
                                      data[number]["Slug"],
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Oluşturma tarihi :",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Text(
                                      data[number]["dtCreate"],
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Eşya durumu :",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Text(
                                      data[number]["Type"],
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Envanter numarasıg :",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                    Text(
                                      data[number]["InventoryNo"].toString(),
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ))),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
/*
data[number]["Logo"] == null
? Image(
image: NetworkImage(
'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
height: 50,
width: 50,
)
: Image(
image: NetworkImage(
data[number]["Logo"])))),
*/
