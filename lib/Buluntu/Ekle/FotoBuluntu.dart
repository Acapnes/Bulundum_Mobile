import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

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
  double ht = 0, wt = 0;
  var image;
  List imageArray = [];
  List<AltEsya> DynamicList = [];

  AltEsya altesya = AltEsya();

  AltEsyaEkle() {
    DynamicList.add(new AltEsya());
    setState(() {});
  }

  getImage() async {
    image = await ImagePicker.pickImage(source: ImageSource.camera);
    imageArray.add(image);
    setState(() {
      imageArray;
    });
  }

  toBottom() async {
    _scrollController.animateTo(0,
        duration: Duration(milliseconds: 1250), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                height: MediaQuery.of(context).size.height - 300,
                child: Container(
                  child: imageArray.isEmpty
                      ? Center(
                          child: Text("Fotoğraf Seçilmedi"),
                        )
                      : Container(
                          child: GridView.count(
                            crossAxisCount: 2,
                            children: List.generate(imageArray.length, (index) {
                              var img = imageArray[index];
                              return Container(
                                  margin: EdgeInsets.all(10),
                                  child: Image.file(img));
                            }),
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
                              print(imageArray[2].toString());
                            }),
                      ),
                      SizedBox(
                        height: 50,
                        child: RaisedButton(
                          child: Icon(
                            Icons.delete,
                            size: 40,
                          ),
                          color: Colors.blue,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 15),
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  color: Colors.redAccent,
                  child: Text(
                    "Alt Eşya Ekle",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    ht = (MediaQuery.of(context).size.height / 1.5);
                    wt = (MediaQuery.of(context).size.width);
                    AltEsyaEkle();

                    },
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                width: wt,
                height: ht,
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: DynamicList.length,
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
                                    setState(() {
                                      DynamicList.removeAt(index);
                                      if(index==0){
                                        ht = 0;
                                        wt = 0;
                                      }
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
                            DynamicList[index],
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
      ),
    );
  }
}

class AltEsya extends StatefulWidget {
  @override
  _AltEsyaState createState() => _AltEsyaState();
}

class _AltEsyaState extends State<AltEsya> {
  TextEditingController controller = TextEditingController();
  var image;
  List imageArray = [];

  getImage() async {
    image = await ImagePicker.pickImage(source: ImageSource.camera);
    imageArray.add(image);
    setState(() {
      imageArray;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 400,
            child: Container(
              child: imageArray.isEmpty
                  ? Center(
                      child: Text("Fotoğraf Seçilmedi"),
                    )
                  : Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: GridView.count(
                        crossAxisCount: 2,
                        children: List.generate(imageArray.length, (index) {
                          var img = imageArray[index];
                          return Container(
                              margin: EdgeInsets.all(10),
                              child: Image.file(img));
                        }),
                      ),
                    ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Container(
              margin: EdgeInsets.only(bottom: 20),
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
                        Icons.upload,
                        size: 40,
                      ),
                      color: Colors.blue,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
