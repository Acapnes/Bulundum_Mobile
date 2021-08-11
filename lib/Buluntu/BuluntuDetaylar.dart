import 'package:bulundum_mobile/Buluntu/BuluntuListele.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motion_tab_bar/motiontabbar.dart';

class MainBuluntuDetaylar extends StatelessWidget {
  final Buluntu buluntu;

  MainBuluntuDetaylar(this.buluntu);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: MotionTabBar(
          labels: ["Eski Buluntular", "Ara", "Yeni Buluntular"],
          initialSelectedTab: "Ara",
          tabIconColor: Colors.orange,
          tabSelectedColor: Colors.blueAccent,
          onTabItemSelected: (int value) {
            print(value);
          },
          icons: [
            Icons.keyboard_arrow_left_outlined,
            Icons.search,
            Icons.keyboard_arrow_right_outlined
          ],
          textStyle: TextStyle(color: Colors.red),
        ),
        appBar: AppBar(),
        //drawer: mainDrawer(),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.blueAccent,
                    margin: EdgeInsets.only(bottom: 20),
                    child: Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Image(
                        image: AssetImage("img/icon.png"),
                        height: 150,
                        width: 150,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: 250,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border:
                            Border.all(color: Colors.orangeAccent, width: 4.5),
                      ),
                      child: Center(
                          child: Text(
                        buluntu.title,
                        style: TextStyle(fontSize: 20),
                      )),
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.all(25),
                child: Column(
                  children: <Widget>[
                    Align(
                      child: ListTile(
                        title: Text("Kayıt numarası : ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w300)),
                        subtitle: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            buluntu.id,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      child: ListTile(
                        title: Text("Özel detaylar : ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w300)),
                        subtitle: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            buluntu.privateDetails,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              /*Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: buluntu.Images == null
                            ? buluntu.Images
                            : AssetImage("img/icon.png"))),
              )*/
            ],
          ),
        ));
  }
}
