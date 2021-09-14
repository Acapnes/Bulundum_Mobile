import 'package:bulundum_mobile/BottomNavigationBar/mainBNB.dart';
import 'package:bulundum_mobile/Buluntu/BuluntuDetaylar.dart';
import 'package:bulundum_mobile/Buluntu/Ekle/FotoBuluntu.dart';
import 'package:bulundum_mobile/Colors/primaryColors.dart';
import 'package:bulundum_mobile/FAB/mainFAB.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
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
  String dataController;
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

  _showAlertDialogEkleme(){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    Text("Ne Eklemek İstiyorsunuz?"),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 20),
                          child: Icon(Icons.cancel,color: Colors.blue,size: 25,)),
                    ),
                  ],
                )),
            actions: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 30),
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                FotoBuluntu()));
                  },
                  child: Text("Buluntu",style: TextStyle(fontSize: 16)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 30),
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text("Kayıp Eşya",style: TextStyle(fontSize: 16),),
                ),
              ),

            ],
          );
        }
    );
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: kPrimaryColor,
          accentColor: kPrimaryColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Ubuntu'),
      home: Scaffold(
        backgroundColor: kPrimaryColor,
          bottomNavigationBar: mainBNB(),
          appBar: AppBar(elevation: 0,title:Text("Buluntu Listesi"),centerTitle: true,
            leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){
            Navigator.pop(context);
          },),
          actions: [
            IconButton(icon: Icon(Icons.search),onPressed: (){},),
          ],),
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
          body: Container(
            child: SafeArea(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20,bottom: 10,left: 20,right: 20),
                    padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                        vertical: kDefaultPadding/4
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                          enabledBorder:InputBorder.none,
                          focusedBorder:InputBorder.none,
                          icon: Icon(Icons.search,color: Colors.white,),
                          hintText:("Aramak istediğiniz eşya numarasını giriniz."),
                          hintStyle: TextStyle(color: Colors.white)
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            if(PageNumber>1){
                              toTop();
                              PageNumber--;
                            }
                          });
                        },
                        child: Column(
                          children: [
                            Icon(Icons.arrow_back,color: Colors.white,),
                            Text("Önceki Buluntular",style: TextStyle(color: Colors.white),)
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            toTop();
                              PageNumber++;
                          });
                        },
                        child: Column(
                          children: [
                            Icon(Icons.arrow_forward,color: Colors.white,),
                            Text("Sonraki Buluntular",style: TextStyle(color: Colors.white),)
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: FutureBuilder(
                      future: ListFoundItems(),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return Container(
                            margin: EdgeInsets.only(top: 100),
                            child: Center(
                              child: Text("Yükleniyor...",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                            ),
                          );
                        } else {
                          return Expanded(
                            child: Container(
                              margin: EdgeInsets.only(bottom: 3),
                              width: MediaQuery.of(context).size.width,
                              child: Stack(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 70),
                                    decoration: BoxDecoration(
                                      color: kBackgroundColor,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(40),
                                        topRight: Radius.circular(40),
                                      ),
                                    ),),
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      controller: _scrollController,
                                      itemCount: snapshot.data.length,
                                      itemBuilder: (context, i) {
                                        return Slidable(
                                          actionPane: SlidableScrollActionPane(),
                                          actions: <Widget>[
                                             Container(
                                               margin: EdgeInsets.only(left: 10,right: 5),
                                               child: ElevatedButton(
                                                   child: Container(
                                                     height: 150,
                                                     child: Column(
                                                       children: [
                                                         Padding(
                                                           padding: const EdgeInsets.only(right: 3.0,top: 30,bottom: 30),
                                                           child: Icon(Icons.more,color: Colors.black,size: 50,),
                                                         ),
                                                         Text("Detaylar",style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.bold),),
                                                       ],
                                                     ),
                                                   ),
                                                 onPressed: (){
                                                   Navigator.push(
                                                       context,
                                                       new MaterialPageRoute(
                                                           builder: (context) =>
                                                               mainBuluntuDetaylar(snapshot.data[i])));
                                                 },
                                                 style: ElevatedButton.styleFrom(
                                                     elevation: 20,
                                                     primary: Colors.greenAccent,
                                                   minimumSize: Size(175,175),
                                                 ),
                                               ),
                                             ),
                                          ],
                                          secondaryActions: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(left: 5,right: 10),
                                              child: ElevatedButton(
                                                child: Container(
                                                  height: 150,
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 3.0,top: 30,bottom: 30),
                                                        child: Icon(Icons.delete,color: Colors.black,size: 50,),
                                                      ),
                                                      Text("Sil",style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.bold),),
                                                    ],
                                                  ),
                                                ),
                                                onPressed: (){},
                                                style: ElevatedButton.styleFrom(
                                                    elevation: 20,
                                                    primary: Colors.redAccent,
                                                    minimumSize: Size(175,175),
                                                ),
                                              ),
                                            ),
                                          ],

                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(22),
                                              color: Colors.orangeAccent,
                                              boxShadow: [kDefaultShadow],
                                            ),
                                              margin: EdgeInsets.all(10),
                                              height: 207,
                                              child: Container(
                                                margin: EdgeInsets.only(right: 10),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(22),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Container(
                                                          padding: EdgeInsets.symmetric(
                                                            horizontal: kDefaultPadding*1.5,
                                                            vertical: kDefaultPadding/4,
                                                          ),
                                                          decoration: BoxDecoration(
                                                              color: Colors.greenAccent,
                                                            borderRadius: BorderRadius.only(
                                                              bottomLeft: Radius.circular(22),
                                                              topRight: Radius.circular(22),
                                                            )
                                                          ),
                                                          child: Icon(Icons.more),
                                                        ),
                                                        Container(
                                                          padding: EdgeInsets.symmetric(
                                                            horizontal: kDefaultPadding*1.5,
                                                            vertical: kDefaultPadding/4,
                                                          ),
                                                          decoration: BoxDecoration(
                                                              color: Colors.redAccent,
                                                              borderRadius: BorderRadius.only(
                                                                bottomRight: Radius.circular(22),
                                                                topLeft: Radius.circular(22),
                                                              )
                                                          ),
                                                          child: Icon(Icons.delete),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
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
