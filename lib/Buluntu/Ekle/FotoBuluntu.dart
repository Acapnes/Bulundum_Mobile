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
  File _image;
  String base64Image;

  final imagePicker = ImagePicker();

  Future getImage() async {
    final image = await imagePicker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(image.path);
    });
  }

  Future upload() async {
    var response = await http.post(Uri.parse("https://reqres.in/api/login"), body: {
      "image": base64Image,
    });
    if (response.statusCode == 200) {
      response.body;
    }
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
                margin: EdgeInsets.all(20),
                child: Center(
                  child: _image == null
                      ? Text(
                          "Fotoğraf Seçilmedi",
                          style: TextStyle(color: Colors.white70, fontSize: 25),
                        )
                      : Image.file(_image),
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
                            upload();
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
                          setState(() {
                            _image = null;
                          });
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
