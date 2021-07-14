import 'package:bulundum_mobile/Buluntu/Ekle/FotoBuluntu.dart';
import 'package:bulundum_mobile/Buluntu/Ekle/QRBuluntu.dart';
import 'package:bulundum_mobile/Drawer/mainDrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class mainBuluntuEkle extends StatelessWidget {
  const mainBuluntuEkle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: mainDrawer(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 80),
                child: Image(
                  image: AssetImage("img/bulundum_logo.png"),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 30),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 7,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.orangeAccent,width: 8)
                    ),
                    color: Colors.blueAccent,
                    child: ListTile(
                      title: Text("Normal Buluntu Ekle",style: TextStyle(color: Colors.white,fontSize: 20),),
                      trailing: Icon(Icons.view_list,size: 60,),
                    ),
                    onPressed: (){
                      print("1");
                    },
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 30),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 7,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.orangeAccent,width: 8)
                    ),
                    color: Colors.blueAccent,
                    child: ListTile(
                      title: Text("Fotoğrafla Buluntu Ekle",style: TextStyle(color: Colors.white,fontSize: 20),),
                      trailing: Icon(Icons.add_a_photo,size: 60,),
                    ),
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FotoBuluntu()));
                    },
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 30),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 7,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.orangeAccent,width: 8)
                    ),
                    color: Colors.blueAccent,
                    child: ListTile(
                      title: Text("Ses Kaydı ile Buluntu Ekle",style: TextStyle(color: Colors.white,fontSize: 20),),
                      trailing: Icon(Icons.mic,size: 60,),
                    ),
                    onPressed: (){
                      print("1");
                    },
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 30),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 7,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.orangeAccent,width: 8)
                    ),
                    color: Colors.blueAccent,
                    child: ListTile(
                      title: Text("QR Kod ile Buluntu Ekle",style: TextStyle(color: Colors.white,fontSize: 20),),
                      trailing: Icon(Icons.qr_code,size: 60,),
                    ),
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QRBuluntu()));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
