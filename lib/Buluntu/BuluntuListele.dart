import 'dart:io';

import 'package:bulundum_mobile/Buluntu/BuluntuDetaylar.dart';
import 'package:bulundum_mobile/Drawer/mainDrawer.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MainBuluntuList extends StatefulWidget {

  @override
  _MainBuluntuListState createState() => _MainBuluntuListState();
}

class _MainBuluntuListState extends State<MainBuluntuList> {
  int number;
  List data;

  Future<String> ListFoundItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final uri = Uri.https("dev.bulundum.com", "/api/v3/founditems", {'sk1': prefs.get("sk1"), 'sk2': prefs.get("sk2")});
    var response = await http.get(uri);
    var jsonData = jsonDecode(response.body);
    data = jsonData["Records"];
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
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.search),
          onPressed: () {
            ListFoundItems();
          },
        ),
        body: ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (context,int index){
            return Container(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Card(
                      child: Container(
                          child : Text(data[0]["Slug"]),
                        padding: EdgeInsets.all(20),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class User {
  final String Id, Title, Slug;

  User(this.Id, this.Title, this.Slug);
}
