import 'dart:io';

import 'package:bulundum_mobile/Buluntu/BuluntuDetaylar.dart';
import 'package:bulundum_mobile/Drawer/mainDrawer.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:motion_tab_bar/motiontabbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainBuluntuList extends StatefulWidget {
  @override
  _MainBuluntuListState createState() => _MainBuluntuListState();
}

class _MainBuluntuListState extends State<MainBuluntuList> {
  int Selectedindex;
  List<Buluntu> buluntular = new List<Buluntu>();
  ScrollController _scrollController = ScrollController();
  int PageNumber = 1;
  bool first = true;

  Future<List<Buluntu>> ListFoundItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final uri = Uri.https("dev.bulundum.com", "/api/v3/founditems", {
      'sk1': prefs.get("sk1"),
      'sk2': prefs.get("sk2"),
      'Page': "$PageNumber"
    });
    var response = await http.get(uri);
    var jsonData = jsonDecode(response.body);
    var buluntudata = jsonData["Records"];
    List<Buluntu> buluntular = [];
    for (var buluntu in buluntudata) {
      Buluntu newBuluntu = Buluntu(
          buluntu["Title"], buluntu["Slug"], buluntu["Id"], buluntu["Image"]);
      buluntular.add(newBuluntu);
    }
    print(buluntular[10].Title);
    return buluntular;
  }

  @override
  void initState() {
    super.initState();
    ListFoundItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: MotionTabBar(
          labels: ["Eski Buluntular", "Ara", "Yeni Buluntular"],
          initialSelectedTab: "Ara",
          tabIconColor: Colors.green,
          tabSelectedColor: Colors.red,
          onTabItemSelected: (int value) {
            print(value);
            setState(() {});
            if (value == 2) {
              Future.delayed(
                  const Duration(seconds: 2),
                  () => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Sonraki Buluntular Getirildi"))));
              PageNumber++;
            } else if (value == 1) {
              print("Arama Kodu");
            } else if (PageNumber >= 2) {
              Future.delayed(
                  const Duration(seconds: 2),
                  () => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Önceki Buluntular Getirildi"))));
              PageNumber--;
            }
          },
          icons: [
            Icons.keyboard_arrow_left_outlined,
            Icons.search,
            Icons.keyboard_arrow_right_outlined
          ],
          textStyle: TextStyle(color: Colors.red),
        ),
        appBar: AppBar(),
        drawer: mainDrawer(),
        body: Container(
          child: FutureBuilder(
            future: ListFoundItems(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Text("Loading"),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
                    Selectedindex = i;
                    return Slidable(
                      actionPane: SlidableScrollActionPane(),
                      actions: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) =>
                                        mainBuluntuDetaylar(snapshot.data[i])));
                            print(snapshot.data[i].Title);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Container(
                              height: 125,
                              decoration: BoxDecoration(
                                  color: Colors.greenAccent,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Icon(
                                Icons.more,
                                color: Colors.white,
                                size: 45,
                              ),
                            ),
                          ),
                        )
                      ],
                      secondaryActions: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: Container(
                            height: 125,
                            decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(20)),
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 45,
                            ),
                          ),
                        )
                      ],
                      child: Card(
                        margin: EdgeInsets.all(10),
                        child: Container(
                          height: 125,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.orangeAccent, width: 3),
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Center(
                                    child: Text(
                                  snapshot.data[i].Title,
                                  style: TextStyle(fontSize: 18),
                                )),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: ListTile(
                                  title:
                                      Text("Eşya no : " + snapshot.data[i].Id),
                                  subtitle:
                                      Text("Slug  : " + snapshot.data[i].Slug),
                                  trailing: snapshot.data[i].Photo == null
                                      ? Image(
                                          image: AssetImage("img/icon.png"),
                                          height: 50,
                                          width: 50,
                                        )
                                      : Image(
                                          image: AssetImage("img/icon.png")),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ));
  }
}

class Buluntu {
  String Title;

  String Id;

  String Slug;

  String Photo;

  Buluntu(this.Title, this.Slug, this.Id, this.Photo);
}
