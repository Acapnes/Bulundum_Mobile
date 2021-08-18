import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;

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
  ScrollController _bodyScrollController = ScrollController();
  ScrollController _listScrollController = ScrollController();
  var image;
  var imajlarArray = [];
  List<AltEsyaNew> AltArray = [];
  int _activeindex = -1;
  double listViewSize = 0;
  File imageFile;
  String imageData, img64 = "";

  getImageAltEsya(int altIndex) async {
    final image = await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      if (image != null) {
        imageFile = File(image.path);
        imageData = base64Encode(imageFile.readAsBytesSync());
        imajlarArray[altIndex].add(imageData);
        imajlarArray;
      }
    });
  }

  getImageMainBuluntu() async {
    final image = await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      if (image != null) {
        imageFile = File(image.path);
        imageData = base64Encode(imageFile.readAsBytesSync());
        imajlarArray[0].add(imageData);
        setState(() {
          imajlarArray;
        });
      }
    });
  }

  AltEsyaEkle() {
    setState(() {
      this._activeindex++;
      AltArray.add(new AltEsyaNew());
      imajlarArray.add([]);
    });
  }

  @override
  void initState() {
    imajlarArray.add([]);
  }

  Upload() async {
    var response = await http.post(Uri.parse("https://dev.bulundum.com/api/v3/founditems/create/by-images"),
        body: ({
          'images': imajlarArray
        }));
    if (response.statusCode == 200) {
      Map<String,dynamic>res = jsonDecode(response.body);
      print(res);
      if (res["err"] == 0) {


      }
    }
  }

  animateToTop() async {
  _bodyScrollController.animateTo(0,
        duration: Duration(milliseconds: 800), curve: Curves.easeInOut);
  }

  animateToBot() async {
    final double end = _bodyScrollController.position.maxScrollExtent+600;
    _bodyScrollController.animateTo(end,
        duration: Duration(milliseconds: 800), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
            listViewSize = 600 * (AltArray.length + 1).toDouble();
          _activeindex = AltArray.length - 1;
          AltEsyaEkle();
          animateToBot();
          //print(imajlarArray);
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Fotoğrafla Buluntu Ekle"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        controller: _bodyScrollController,
        child: Container(
          margin: EdgeInsets.only(top: 20),
          child: Column(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                height: MediaQuery.of(context).size.height - 150,
                child: Card(
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 20, top: 20),
                        height: MediaQuery.of(context).size.height - 300,
                        child: imajlarArray[0].isEmpty
                            ? GestureDetector(
                          child: Center(
                              child: Text(
                                "Fotoğraf Eklenmedi",
                                style: TextStyle(fontSize: 25),
                              )),
                        )
                            :SingleChildScrollView(
                          child: Container(
                            child: GridView.count(
                              shrinkWrap: true,
                              primary: true,
                              crossAxisCount: 2,
                              physics: NeverScrollableScrollPhysics(),
                              children: List.generate(
                                  imajlarArray[0].length, (index) {
                                return Container(
                                    margin: EdgeInsets.all(10),
                                    child: Image.memory(base64Decode(
                                        imajlarArray[0][index])));
                              }),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              margin:
                              EdgeInsets.only(left: 10, bottom: 10, top: 20),
                              height: 50,
                              width: 80,
                              child: ElevatedButton(
                                style: ButtonStyle(),
                                onPressed: () {
                                  getImageMainBuluntu();
                                },
                                child: Icon(
                                  Icons.add_a_photo,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              margin:
                              EdgeInsets.only(right: 10, bottom: 10, top: 20),
                              height: 50,
                              width: 80,
                              child: ElevatedButton(
                                style: ButtonStyle(),
                                onPressed: () {
                                  Upload();
                                },
                                child: Icon(
                                  Icons.upload_file,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: listViewSize,
                margin:
                EdgeInsets.only(top: 20, left: 30, right: 30, bottom: 20),
                child: ListView.builder(
                  itemExtent: 600,
                  controller: _listScrollController,
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
                                    margin: EdgeInsets.only(left: 25, top: 25),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        (index + 1).toString() + ". Alt Eşya",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      print(index);
                                      setState(() {
                                        AltArray.removeAt(index);
                                        imajlarArray.removeAt(index+1);
                                        setState(() {
                                          listViewSize -= 600;
                                        });
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(right: 15, top: 15),
                                      child: Align(
                                          alignment: Alignment.topRight,
                                          child: Icon(
                                            Icons.delete,
                                            size: 35,
                                            color: Colors.blueAccent,
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 450,
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 20),
                                  child: imajlarArray[index+1].isEmpty
                                      ? Center(
                                    child: Text(
                                      "Fotoğraf Seçilmedi",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  )
                                      : SingleChildScrollView(
                                    child: Container(
                                      margin: EdgeInsets.only( top: 20, bottom: 20),
                                      child: GridView.count(
                                        shrinkWrap: true,
                                        primary: true,
                                        crossAxisCount: 2,
                                        physics: NeverScrollableScrollPhysics(),
                                        children: List.generate(
                                            imajlarArray[index+1].length, (i) {
                                          return Container(
                                              width: MediaQuery.of(context).size.width,
                                              margin: EdgeInsets.all(10),
                                              child: Image.memory(base64Decode(imajlarArray[index+1][i])));
                                        }),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 10, bottom: 10, top: 30),
                              height: 50,
                              width: 80,
                              child: ElevatedButton(
                                style: ButtonStyle(),
                                onPressed: () {
                                  getImageAltEsya(index+1);
                                },
                                child: Icon(
                                  Icons.add_a_photo,
                                  size: 30,
                                  color: Colors.white,
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
}
