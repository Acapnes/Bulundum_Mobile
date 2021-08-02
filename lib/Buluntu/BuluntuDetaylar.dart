import 'package:bulundum_mobile/Buluntu/BuluntuListele.dart';
import 'package:bulundum_mobile/Drawer/mainDrawer.dart';
import 'package:flutter/material.dart';

class mainBuluntuDetaylar extends StatelessWidget {
  final Buluntu buluntu;

  mainBuluntuDetaylar(this.buluntu);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        drawer: mainDrawer(),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30.0),
                      bottomLeft: Radius.circular(30.0),
                    )),
              ),
              Container(
                margin: EdgeInsets.all(25),
                child: Column(
                  children: <Widget>[
                    Align(
                      child: ListTile(
                        title: Text("Eşya numarası : ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300)),
                        subtitle: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(buluntu.Id,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ),
                    Align(
                      child: ListTile(
                        title: Text("Eşya numarası : ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300)),
                        subtitle: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(buluntu.Id,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
