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

  //Eşyano - kayıtno - eşyaismi - özeldetaylar - foto

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        drawer: mainDrawer(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.search),
          onPressed: () {},
        ),
        body: ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (context, int index) {
            return GestureDetector(
              onTap: (){
                number = index;
                print(number);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => mainBuluntuDetaylar(number: number)));
              },
              child: Container(
                margin: EdgeInsets.all(15),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Card(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 160,
                          child: Column(
                            children: [
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: Text(data[index]["Title"],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                ),
                              ),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: ListTile(
                                      title:
                                          Text("Eşya : " + data[index]["Title"],style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                      subtitle:
                                          Text("Eşya no : " + data[index]["Id"],style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                      trailing: data[index]["Logo"] == null
                                          ? Image(
                                              image: NetworkImage(
                                                  'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),height: 50,width: 50,)
                                          : Image(
                                              image: NetworkImage(
                                                  data[index]["Logo"])))),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Text("Detaylar",style: TextStyle(fontSize: 18),),
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
            );
          },
        ),
      ),
    );
  }
}
