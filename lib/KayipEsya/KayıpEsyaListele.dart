import 'package:bulundum_mobile/Buluntu/BuluntuDetaylar.dart';
import 'package:bulundum_mobile/Buluntu/BuluntuListele.dart';
import 'package:bulundum_mobile/Buluntu/FotoBuluntuEkle.dart';
import 'package:bulundum_mobile/Controllers/BottomNavigationBar/mainBNB.dart';
import 'package:bulundum_mobile/Controllers/Colors/primaryColors.dart';
import 'package:bulundum_mobile/Controllers/Drawer/mainDrawer.dart';
import 'package:bulundum_mobile/Controllers/FAB/mainFAB.dart';
import 'package:bulundum_mobile/KayipEsya/KayipEsyaDetaylar.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MainKayipList extends StatefulWidget {
  @override
  _MainKayipListState createState() => _MainKayipListState();
}

class _MainKayipListState extends State<MainKayipList> {
  List<KayipEsya> kayipesyalar = [];
  ScrollController _scrollController = ScrollController();
  List data;
  int pageNumber = 1;
  String dataController;
  bool first = true;

  Future<List<KayipEsya>> ListFoundItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final uri = Uri.https("dev.bulundum.com", "/api/v3/founditems", {
      'sk1': prefs.get("sk1"),
      'sk2': prefs.get("sk2"),
      'Page': "$pageNumber"
    });
    var response = await http.get(uri);
    var jsonData = jsonDecode(response.body);
    data = jsonData["Records"];
    var kayipesyadata = jsonData["Records"];
    List<KayipEsya> kayipesyalar = [];
    for (var kayipesya in kayipesyadata) {
      KayipEsya newKayipEsya = KayipEsya(
          kayipesya["Title"],
          kayipesya["Id"],
          kayipesya["Images"],
          kayipesya["StatusText"],
          kayipesya["PrivateDetails"],
          kayipesya["StoragePlace"]["Title"],
          kayipesya["InventoryNo"]);
      kayipesyalar.add(newKayipEsya);
    }
    return kayipesyalar;
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
    return Scaffold (
      backgroundColor: kPrimaryColor,
      bottomNavigationBar: mainBNB(),
      drawer: mainDrawer(),
      appBar: AppBar(elevation: 0,title:Text("Kayıp Eşya Listesi"),centerTitle: true,backgroundColor: kPrimaryColor,),
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
        child: Container(
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
                      hintText:("Kayıp eşya numarasını giriniz..."),
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
                        if(pageNumber>1){
                          toTop();
                          pageNumber--;
                        }
                      });
                    },
                    child: Column(
                      children: [
                        Icon(Icons.arrow_back,color: Colors.white,),
                        Text("Önceki Kayıp Eşyalar",style: TextStyle(color: Colors.white),)
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        toTop();
                        pageNumber++;
                      });
                    },
                    child: Column(
                      children: [
                        Icon(Icons.arrow_forward,color: Colors.white,),
                        Text("Sonraki Kayıp Eşyalar",style: TextStyle(color: Colors.white),)
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
                                      //actionPane: SlidableScrollActionPane(),
                                      /*actions: <Widget>[
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
                                            ],*/
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(22),
                                          color: Colors.orangeAccent,
                                          boxShadow: [kDefaultShadow],
                                        ),
                                        margin: EdgeInsets.all(10),
                                        child: Container(
                                          height: MediaQuery.of(context).size.height * 0.29,
                                          margin: EdgeInsets.only(right: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(22),
                                          ),
                                          child: Stack(
                                            children: [
                                              Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 8.0),
                                                    child: Center(
                                                        child: Text(
                                                          snapshot.data[i].Title,
                                                          style: TextStyle(fontSize: 18),
                                                        )),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(right: 100),
                                                    child: Column(
                                                      children: [
                                                        ListTile(
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
                                                        ListTile(
                                                          title: Text(
                                                              "Eşya durumu : " + snapshot.data[i].StatusText),
                                                          subtitle: Text(
                                                              "Bulunduğu depo  : " +
                                                                  snapshot.data[i].StorageTitle,
                                                              style: TextStyle(
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 15)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Align(
                                                  alignment: Alignment.centerRight,
                                                  child: Container(
                                                    width: 110,
                                                    height: 110,
                                                    child: snapshot.data[i].Images.length > 0 ? Image(
                                                        image: NetworkImage(
                                                            snapshot.data[i].Images[0]["RemotePath"]))
                                                        : Image.asset("assets/icon-v1.png") ,
                                                  )
                                              ),
                                              Stack(
                                                children: [
                                                  Positioned(
                                                    left:0,
                                                    bottom: 0,
                                                    child: GestureDetector(
                                                      onTap: (){
                                                        Navigator.push(
                                                            context,
                                                            new MaterialPageRoute(
                                                                builder: (context) =>
                                                                    mainKayipEsyaDetaylar(snapshot.data[i])));
                                                      },
                                                      child: Container(
                                                        padding: EdgeInsets.symmetric(
                                                          horizontal: kDefaultPadding*1.5,
                                                          vertical: kDefaultPadding/3.5,
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
                                                    ),
                                                  ),
                                                  Positioned(
                                                    right:0,
                                                    bottom: 0,
                                                    child: GestureDetector(
                                                      onTap: (){
                                                        _showAlertDialogSilme();
                                                      },
                                                      child: Container(
                                                        padding: EdgeInsets.symmetric(
                                                          horizontal: kDefaultPadding*1.5,
                                                          vertical: kDefaultPadding/3.5,
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
                                                    ),
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
      ),
    );
  }
  _showAlertDialogSilme(){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Text("Silmek istediğinize emin misiniz?")),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    child: ElevatedButton(
                      onPressed: (){},
                      child: Text("Sil",style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  Container(
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: Text("İptal",style: TextStyle(fontSize: 16),),
                    ),
                  ),
                ],
              ),
            ],
          );
        }
    );
  }
}

class KayipEsya {
  String Title;
  String Id;
  List Images = [];
  String StatusText;
  String PrivateDetails;
  String StorageTitle;
  String InventoryNo;

  KayipEsya(this.Title, this.Id, this.Images, this.StatusText, this.PrivateDetails,this.StorageTitle, this.InventoryNo);
}
