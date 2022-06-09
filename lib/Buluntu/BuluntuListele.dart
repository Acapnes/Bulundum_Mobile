import 'package:bulundum_mobile/Buluntu/BuluntuDetaylar.dart';
import 'package:bulundum_mobile/Buluntu/FotoBuluntuEkle.dart';
import 'package:bulundum_mobile/Controllers/BottomNavigationBar/mainBNB.dart';
import 'package:bulundum_mobile/Controllers/Colors/primaryColors.dart';
import 'package:bulundum_mobile/Controllers/Drawer/mainDrawer.dart';
import 'package:bulundum_mobile/Controllers/FAB/mainFAB.dart';
import 'package:bulundum_mobile/Pages/Help/Help.dart';
import 'package:bulundum_mobile/Pages/Profile/Profile.dart';
import 'package:bulundum_mobile/Pages/QRMenu/QRMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MainBuluntuList extends StatefulWidget {
  @override
  _MainBuluntuListState createState() => _MainBuluntuListState();
}

class _MainBuluntuListState extends State<MainBuluntuList> {
  List<Item> buluntular = [];

  Future<List<Item>> ListFoundItems() async {
    /// 192.168.1.33 LocalHost ip
    var url = 'http://192.168.1.33/mobiledb/item/itemlist.php';
    http.Response response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    List<Item> buluntular = [];
    for (var buluntu in jsonData){
      Item newBuluntu = Item(
          buluntu["item_id"],
          buluntu["item_name"],
          buluntu["item_photo"],
          buluntu["item_location"],
          buluntu["comment"],);
      buluntular.add(newBuluntu);
    }
    return buluntular;
  }


  @override
  void initState() {
    super.initState();
    ListFoundItems();
  }

  removeItem(id) async {
    var url = 'http://192.168.1.33/mobiledb/item/itemdelete.php';
    var response = await http.post(Uri.parse(url),
        body: ({
          'item_id': id,
        }));
    if(response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Silme işlemi başarılı.")));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainBuluntuList()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Silme işlemi başarısız.")));
    }
  }

  _showAlertDialogSilme(id){
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
                      onPressed: (){
                        removeItem(id);
                      },
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      bottomNavigationBar: mainBNB(),
      drawer: mainDrawer(),
      appBar: AppBar(elevation: 0,title:Text("Buluntu Listesi"),centerTitle: true,backgroundColor: kPrimaryColor,
        actions: [
          PopupMenuButton(
              iconSize: 20,
              onSelected: (value){
                if(value == 2){
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => MainHelp()));
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  padding: EdgeInsets.only(right: 0,left: 8),
                  child: Row(
                    children: [
                      Icon(Icons.refresh,color: Colors.black),
                      Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Text("Sayfayı yenile"),
                      ),
                    ],
                  ),
                  value: 1,
                ),
                PopupMenuItem(
                  padding: EdgeInsets.only(right: 0,left: 8),
                  child: Row(
                    children: [
                      Icon(Icons.help,color: Colors.black),
                      Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Text("Yardım"),
                      ),
                    ],
                  ),
                  value: 2,
                ),
              ]),
        ],
      ),
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
            textWidth: 140,
            textHeight: 30,
          ),
          ActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MainProfile()));
            },
            icon: const Icon(Icons.add),
            text: "Profil",
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
                margin: EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 20),
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
                      hintText:("Buluntu numarasını giriniz..."),
                      hintStyle: TextStyle(color: Colors.white)
                  ),
                ),
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
                                  itemCount: snapshot.data.length == null ? 0 : snapshot.data.length,
                                  itemBuilder: (context, i) {
                                    return Container(
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
                                                Container(
                                                  height: 50,
                                                  child: Stack(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 8.0),
                                                        child: Center(
                                                            child: Text(
                                                              snapshot.data[i].item_name,
                                                              style: TextStyle(fontSize: 18),
                                                            )),
                                                      ),
                                                      Positioned(
                                                          right: 20,
                                                          top: 10,
                                                          child:  PopupMenuButton(
                                                              iconSize: 20,
                                                              onSelected: (value){
                                                                if( value == 1){
                                                                  Navigator.push(
                                                                      context,
                                                                      new MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              mainBuluntuDetaylar(snapshot.data[i])));
                                                                }
                                                                else if(value==2)
                                                                  removeItem(snapshot.data[i].item_id);
                                                                else if(value ==3){
                                                                  Navigator.push(
                                                                      context,
                                                                      new MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              QRMenu(snapshot.data[i].item_id+snapshot.data[i].item_name)));
                                                                }
                                                              },
                                                              itemBuilder: (context) => [
                                                                PopupMenuItem(
                                                                    padding: EdgeInsets.only(right: 0,left: 8),
                                                                  child: Row(
                                                                    children: [
                                                                      Icon(Icons.more),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(left:8.0),
                                                                        child: Text("Eşya Detayları"),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  value: 1,
                                                                ),
                                                                PopupMenuItem(
                                                                  padding: EdgeInsets.only(right: 0,left: 8),
                                                                  child: Row(
                                                                    children: [
                                                                      Icon(Icons.delete),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(left:8.0),
                                                                        child: Text("Eşyayı Sil"),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  value: 2,
                                                                ),
                                                                PopupMenuItem(
                                                                  padding: EdgeInsets.only(right: 0,left: 8),
                                                                  child: Row(
                                                                    children: [
                                                                      Icon(Icons.qr_code),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(left:8.0),
                                                                        child: Text("QR Kodu Görüntüle"),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  value: 3,
                                                                ),
                                                              ]),
                                                      ),
                                                  ]),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(right: 100),
                                                  child: Column(
                                                    children: [
                                                      ListTile(
                                                        title: snapshot.data[i].item_id != null ? Text("Eşya no : " + snapshot.data[i].item_id):Text("null"),
                                                        subtitle: snapshot.data[i].comment != null ?
                                                        Text("Eşya konumu  : " + snapshot.data[i].item_location,
                                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))
                                                            : Text("Null"),
                                                      ),
                                                      Align(
                                                        alignment: Alignment.center,
                                                        child: Container(
                                                          margin: EdgeInsets.only(top: 10,left: 90),
                                                          width: 150,
                                                          height: 80,
                                                          child: snapshot.data[i].item_photo != "null" ?
                                                          Image.memory(
                                                            base64Decode(snapshot.data[i].item_photo), fit: BoxFit.fill,
                                                          ): Center(child: Text("Fotoğraf Yok.")),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
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
                                                                  mainBuluntuDetaylar(snapshot.data[i])));
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
                                                        child: Icon(Icons.more)
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  right:0,
                                                  bottom: 0,
                                                  child: GestureDetector(
                                                    onTap: (){
                                                      _showAlertDialogSilme(snapshot.data[i].item_id);
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
}

class Item {

  var item_id;
  var item_name;
  var item_photo;
  var item_location;
  var comment;

  Item(this.item_id, this.item_name, this.item_photo, this.item_location, this.comment);
}