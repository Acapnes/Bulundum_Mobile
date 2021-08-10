import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:motion_tab_bar/motiontabbar.dart';

class MainFoto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FotoBuluntu(),
      ),
    );
  }
}

class FotoBuluntu extends StatefulWidget {
  @override
  _FotoBuluntuState createState() => _FotoBuluntuState();
}

class _FotoBuluntuState extends State<FotoBuluntu> {
  ScrollController _scrollController = ScrollController();
  var image;
  List imageArray = [];
  List<AltEsyaC> AltArray = [];
  int AltEsyaCounter = 0, _currentindex = 0, _activeindex = 0;

  getImage() async {
    image = await ImagePicker.pickImage(source: ImageSource.camera);
    imageArray.add(image);
    setState(() {
      imageArray;
      AltArray[0].subimageArray = imageArray[0];
    });
  }

  AltEsyaEkle() {
    setState(() {
      this.AltEsyaCounter++;
      AltArray.add(new AltEsyaC());
    });
  }

  toBottom() async {
    _scrollController.animateTo(0,
        duration: Duration(milliseconds: 1250), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentindex,
        type: BottomNavigationBarType.shifting,
        iconSize: 25,
        onTap: (index) {
          setState(() {
            _currentindex = index;
          });
          if (index == 2) {
            AltEsyaEkle();
          }
          if (index == 3) {
            _activeindex++;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.keyboard_arrow_left_outlined),
            title: Text("Önceki Alt Eşya"),
            backgroundColor: Colors.blueAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.keyboard_arrow_up_outlined),
            title: Text("Ana Eşyaya Dön"),
            backgroundColor: Colors.blueAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            title: Text("Yeni Alt Eşya"),
            backgroundColor: Colors.blueAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.keyboard_arrow_right_outlined),
            title: Text("Önceki Alt Eşya"),
            backgroundColor: Colors.blueAccent,
          ),
        ],
      ),
      appBar: AppBar(
        title: Text("Fotoğrafla Eşya Ekle"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 30),
          child: Column(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                height: MediaQuery.of(context).size.height - 260,
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent, width: 4)),
                  child: imageArray.isEmpty
                      ? Center(
                    child: Text(
                      "Fotoğraf Seçilmedi",
                      style: TextStyle(fontSize: 22),
                    ),
                  )
                      : SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.blueAccent, width: 1)),
                      child: GridView.count(
                        shrinkWrap: true,
                        primary: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        children:
                        List.generate(imageArray.length, (index) {
                          var img = imageArray[index];
                          return Container(
                              margin: EdgeInsets.all(10),
                              child: Image.file(img));
                        }),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 50,
                        child: RaisedButton(
                            child: Icon(
                              Icons.add_a_photo,
                              size: 40,
                            ),
                            color: Colors.orangeAccent,
                            onPressed: () {
                              getImage();
                            }),
                      ),
                      SizedBox(
                        height: 50,
                        child: RaisedButton(
                            child: Icon(
                              Icons.upload_file,
                              size: 40,
                            ),
                            color: Colors.orangeAccent,
                            onPressed: () {
                            }),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 500,
                width: 500,
                margin: EdgeInsets.all(50),
                child: ListView.builder(
                  shrinkWrap: true,
                  controller: _scrollController,
                  itemCount: AltArray.length == null ? 0 : AltArray.length,
                  itemBuilder: (context, index) {
                    return Container(
                        child: Card(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 15, top: 15),
                                    child: Align(
                                      child: Text(
                                        (index + 1).toString() + ". Alt Eşya",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      print(AltArray[index].subimageArray);
                                      setState(() {
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(right: 15, top: 15),
                                      child: Align(
                                          alignment: Alignment.topRight,
                                          child: Icon(
                                            Icons.cancel,
                                            size: 35,
                                            color: Colors.orangeAccent,
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 40,
                                height: MediaQuery.of(context).size.height - 350,
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: imageArray.isEmpty
                                      ? Center(
                                    child: Text(
                                      "Fotoğraf Seçilmedi",
                                      style: TextStyle(fontSize: 22),
                                    ),
                                  )
                                      : SingleChildScrollView(
                                    child: Container(
                                      child: GridView.count(
                                        shrinkWrap: true,
                                        primary: true,
                                        physics:
                                        const NeverScrollableScrollPhysics(),
                                        crossAxisCount: 2,
                                        children: List.generate(
                                            imageArray.length, (index) {
                                          var img = imageArray[index];
                                          return Container(
                                              margin: EdgeInsets.all(10),
                                              child: Image.file(img));
                                        }),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ));
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

class AltEsyaC{
  String name;

  List subimageArray = [];
}