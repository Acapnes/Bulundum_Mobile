import 'dart:async';
import 'dart:io';
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
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width - 40,
              height: MediaQuery.of(context).size.height / 1.4,
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
                            return Container(margin: EdgeInsets.all(10),child: Image.file(img));
                          }),
                        ),
                      ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Container(
                margin: EdgeInsets.only(top: 20),
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
                        onPressed: () {
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
