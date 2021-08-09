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
  List<Buluntu> buluntular = new List<Buluntu>();
  ScrollController _scrollController = ScrollController();
  List data;
  int PageNumber = 1;
  String dataController, _dataController;
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
    data = jsonData["Records"];
    var buluntudata = jsonData["Records"];
    List<Buluntu> buluntular = [];
    for (var buluntu in buluntudata) {
      Buluntu newBuluntu = Buluntu(
          buluntu["Title"],
          buluntu["Id"],
          buluntu["Images"],
          buluntu["StatusText"],
          buluntu["PrivateDetails"],
          buluntu["StoragePlace"]["Title"],
          buluntu["InventoryNo"]);
      buluntular.add(newBuluntu);
    }
    return buluntular;
  }

  @override
  void initState() {
    super.initState();
    ListFoundItems();
  }

  toTop() async {
    _scrollController.animateTo(0,
        duration: Duration(milliseconds: 1250), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: MotionTabBar(
          labels: ["Önceki Buluntular", "Ara", "Sonraki Buluntular"],
          initialSelectedTab: "Ara",
          tabIconColor: Colors.green,
          tabSelectedColor: Colors.red,
          onTabItemSelected: (int value) {
            print(value);
            setState(() {});
            if (value == 2) {
              toTop();
              PageNumber++;
            } else if (value == 1) {
              print("Arama Kodu");
            } else if (PageNumber >= 2) {
              toTop();
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
          margin: EdgeInsets.only(top: 20),
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
                  controller: _scrollController,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
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
                            padding:
                                const EdgeInsets.only(left: 12.0, right: 8),
                            child: Container(
                              height: 200,
                              decoration: BoxDecoration(
                                  color: Colors.greenAccent,
                                  borderRadius: BorderRadius.circular(10)),
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
                          padding: const EdgeInsets.only(right: 12.0, left: 8),
                          child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(10)),
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 45,
                            ),
                          ),
                        )
                      ],
                      child: Card(
                        child: Container(
                          margin: EdgeInsets.all(10),
                          height: 185,
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
                                  subtitle: snapshot.data[i].Images == null
                                      ? Text(
                                          "Envanter no  : " +
                                              snapshot.data[i].InventoryNo,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        )
                                      : Text("Null"),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: ListTile(
                                  title: Text(
                                      "Eşya durumu : " + snapshot.data[i].Type),
                                  subtitle: Text(
                                      "Bulunduğu depo  : " +
                                          snapshot.data[i].StorageId,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                                  trailing: snapshot.data[i].Images == null
                                      ? Image(
                                          image: NetworkImage(
                                              snapshot.data[i].Images))
                                      : Image(
                                          image: AssetImage("img/icon.png"),
                                          height: 50,
                                          width: 50,
                                        ),
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

  String Type;

  String StorageId;

  String InventoryNo;

  String PrivateDetails;

  List Images;

  Buluntu(this.Title, this.Id, this.Images, this.Type, this.PrivateDetails,
      this.StorageId, this.InventoryNo);
}
