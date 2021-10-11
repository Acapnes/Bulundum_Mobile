import 'package:bulundum_mobile/Buluntu/BuluntuListele.dart';
import 'package:bulundum_mobile/Pages/Other/FullScreenImage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class mainBuluntuDetaylar extends StatelessWidget {
  Buluntu buluntu;

  mainBuluntuDetaylar(this.buluntu);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Buluntu Detayları"),
          centerTitle: true,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Theme(
                  data: Theme.of(context).copyWith(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                  ),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.greenAccent,
                        margin: EdgeInsets.only(bottom: 20),
                        child: Padding(
                            padding:
                                const EdgeInsets.only(bottom: 50.0, top: 20),
                            child: Container(
                                child: buluntu.Images.isNotEmpty
                                    ? CarouselSlider.builder(
                                        options: CarouselOptions(
                                          reverse: false,
                                          autoPlay: true,
                                          autoPlayInterval:
                                              Duration(seconds: 2),
                                        ),
                                        itemCount: buluntu.Images.length,
                                        itemBuilder:
                                            (context, index, realIndex) {
                                          return MaterialButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  new MaterialPageRoute(
                                                      builder: (context) =>
                                                          mainFSImage(buluntu: buluntu,index: index,kayipEsya: null,)));
                                            },
                                            child: Card(
                                              elevation: 20,
                                              child: Container(
                                                margin: EdgeInsets.all(20),
                                                child: Image.network(
                                                    buluntu.Images[index]
                                                        ["RemotePath"]),
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    : Container(
                                        width: 200,
                                        height: 200,
                                        child: Image.asset(
                                            "assets/icon-v1.png")))),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: 250,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                color: Colors.orangeAccent, width: 4.5),
                          ),
                          child: Center(
                              child: buluntu.Title != ""
                                  ? Text(
                                      buluntu.Title,
                                      style: TextStyle(fontSize: 18),
                                    )
                                  : Text("Boş")),
                        ),
                      )
                    ],
                  )),
              Container(
                margin: EdgeInsets.all(25),
                child: Column(
                  children: <Widget>[
                    Align(
                      child: ListTile(
                        title: Text("Kayıt numarası : ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w300)),
                        subtitle: buluntu.Title != ""
                            ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  buluntu.InventoryNo,
                                  style: TextStyle(fontSize: 18),
                                ),
                            )
                            : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Boş"),
                            ),
                      ),
                    ),
                    Align(
                      child: ListTile(
                        title: Text("Kayıt numarası : ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w300)),
                        subtitle: buluntu.PrivateDetails != ""
                            ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            buluntu.PrivateDetails != null ? buluntu.PrivateDetails : "",
                            style: TextStyle(fontSize: 18),
                          ),
                        )
                            : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Boş"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
