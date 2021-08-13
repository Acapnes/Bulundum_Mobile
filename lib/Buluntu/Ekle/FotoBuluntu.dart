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
  final imagePicker = ImagePicker();
  ScrollController _JuniorController = ScrollController();
  ScrollController _SeinorController;
  String imagepath;
  var image;
  List<String> imageArray = [];
  List<AltEsyaNew> AltArray = [];
  int AltEsyaCounter = 0, _currentindex = 0, _activeindex = -1;
  double mainScrollPosition = 0, altScrollPosition = 0;

  getImage() async {
    final image = await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      if (image != null) {
        imagepath = image.path;
      }
      if (_activeindex == -1 && image != null) {
        imageArray.add(imagepath);
        imageArray;
      }
      if (_activeindex != -1 && _activeindex >= 0 && image != null) {
        AltArray[_activeindex].subimageArray.add(imagepath);
        AltArray[_activeindex].subimageArray;
      }
    });
  }

  AltEsyaEkle() {
    setState(() {
      this._activeindex++;
      this.AltEsyaCounter++;
      AltArray.add(new AltEsyaNew());
    });
  }

  @override
  void initState() {
    _SeinorController = ScrollController();
    _SeinorController.addListener(() {
      if (_SeinorController.offset >=
              _SeinorController.position.maxScrollExtent &&
          !_SeinorController.position.outOfRange) {
        setState(() {});
      }
    });
  }

  toTop() async {
    _JuniorController.animateTo(0,
        duration: Duration(milliseconds: 800), curve: Curves.easeInOut);
  }

  toBot() async {
    _JuniorController.animateTo(1000,
        duration: Duration(milliseconds: 800), curve: Curves.easeInOut);
  }

  intoAltItemsUp() async {
    _SeinorController.animateTo(_SeinorController.offset - 500,
        curve: Curves.linear, duration: Duration(milliseconds: 300));
  }

  intoAltItemsDown() async {
    _SeinorController.animateTo(_SeinorController.offset + 500,
        curve: Curves.linear, duration: Duration(milliseconds: 400));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getImage();
        },
        child: Icon(Icons.add_a_photo),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentindex,
        type: BottomNavigationBarType.shifting,
        iconSize: 25,
        onTap: (index) {
          setState(() {
            _currentindex = index;
          });
          if (index == 0) {
            intoAltItemsUp();
            if (_activeindex >= 0 && AltArray[_activeindex - 1] != null) {
              _activeindex--;
            }
          }
          if (index == 1) {
            setState(() {
              _activeindex = -1;
            });

            toTop();
          }
          if (index == 2) {
            _activeindex = AltArray.length - 1;
            AltEsyaEkle();
            toBot();
            if (AltArray.length >= 2) {
              intoAltItemsDown();
            }
          }
          if (index == 3) {
            intoAltItemsDown();
            if (_activeindex == -1) {
              toBot();
            }
            if (AltArray.length - 1 == _activeindex) {
              _activeindex++;
            } else {
              print("Yeni Elemen Ekle");
            }
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
        controller: _JuniorController,
        child: Container(
          margin: EdgeInsets.only(top: 30),
          child: Column(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                height: MediaQuery.of(context).size.height - 260,
                child: Card(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20, top: 20),
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
                                physics: const NeverScrollableScrollPhysics(),
                                crossAxisCount: 2,
                                children:
                                    List.generate(imageArray.length, (index) {
                                  //var img = imageArray[index];
                                  return Container(
                                      margin: EdgeInsets.all(10),
                                      child:
                                          Image.file(File(imageArray[index])));
                                }),
                              ),
                            ),
                          ),
                  ),
                ),
              ),
              Container(
                height: 500,
                width: 500,
                margin:
                    EdgeInsets.only(top: 20, left: 30, right: 30, bottom: 20),
                child: ListView.builder(
                  itemExtent: 500,
                  physics: NeverScrollableScrollPhysics(),
                  controller: _SeinorController,
                  shrinkWrap: true,
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
                                  AltArray.removeAt(index);
                                  setState(() {
                                    AltArray;
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
                            width: MediaQuery.of(context).size.width,
                            height: 400,
                            child: Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: AltArray[index].subimageArray.isEmpty
                                  ? GestureDetector(
                                      onTap: () {
                                        getImage();
                                      },
                                      child: Center(
                                          child: Icon(Icons.add, size: 200)),
                                    )
                                  : SingleChildScrollView(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                5,
                                        child: GridView.count(
                                          shrinkWrap: true,
                                          primary: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          crossAxisCount: 1,
                                          children: List.generate(
                                              AltArray[index]
                                                  .subimageArray
                                                  .length, (i) {
                                            var img = AltArray[index]
                                                .subimageArray[i];
                                            return Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                margin: EdgeInsets.all(10),
                                                child: Image.file(File(img)));
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

class AltEsyaNew {
  String name;

  List subimageArray = [];
}
