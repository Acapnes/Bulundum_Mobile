import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bulundum_mobile/Controllers/Colors/primaryColors.dart';
import 'package:bulundum_mobile/Controllers/Drawer/mainDrawer.dart';
import 'package:bulundum_mobile/Pages/Help/Help.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class MainFoto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: kPrimaryColor,
          accentColor: kPrimaryColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Ubuntu'),
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
  File imageFile;
  String imageData;

  TextEditingController item_nameController = TextEditingController();
  TextEditingController item_locationController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  getImageMainBuluntu() async {
    final image = await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      if (image != null) {
        imageFile = File(image.path);
        imageData = base64Encode(imageFile.readAsBytesSync());
          if(imageFile.lengthSync() > 64000)
            {
              imageData = null;
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Fotoğrafın boyutu çok fazla!")));
            }
      }});
  }

  Future<void> Upload() async {
    /// 192.168.1.33 LocalHost ip
    var url = 'http://192.168.1.33/mobiledb/item/iteminsert.php';
    var response = await http.post(Uri.parse(url),
        body: ({
          'item_name': item_nameController.text,
          'item_location': item_locationController.text,
          'comment': commentController.text,
          'item_photo': imageData.isNotEmpty ? imageData : "null",
        }));
    var data = json.decode(response.body);
    print(response.statusCode.toString());
    print(data.toString());
    if (response.statusCode == 200 && data == "Success") {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Fotoğraf Gönderildi!")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Gönderme İşlemi Başarısız.")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
            backgroundColor: kPrimaryColor,elevation: 0,title:Text("Eşya Ekle!"),centerTitle: true,
          actions: [
            PopupMenuButton(
                iconSize: 20,
                onSelected: (value){
                  if(value ==1){
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => MainHelp()));
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    padding: EdgeInsets.only(right: 0,left: 8),
                    child: Row(
                      children: [
                        Icon(Icons.help,color: Colors.black),
                        Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Text("Yardım"),
                        ),
                      ],
                    ),
                    value: 1,
                  ),
                ]),
          ],
        ),
        drawer: mainDrawer(),
        body:Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                Container(
                  color: Colors.white,
                  child: TextFormField(
                    controller: item_nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Eşya İsmi",
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  color: Colors.white,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Eşya Adresi",
                    ),
                    controller: item_locationController,
                  ),
                ),
                SizedBox(height: 5),
                Container(
                    color: Colors.white,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Açıklama",
                    ),
                    controller: commentController,
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: imageData != null ? MediaQuery.of(context).size.width : 0,
                  height: imageData != null ? MediaQuery.of(context).size.height/2-10: 0,
                  child: imageData != null ? Card(
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          right: 0,
                          child: PopupMenuButton(
                              iconSize: 20,
                              onSelected: (value){},
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  padding: EdgeInsets.only(right: 0,left: 8),
                                  child: Row(
                                    children: [
                                      Icon(Icons.description, color: Colors.black),
                                      Padding(
                                        padding: const EdgeInsets.only(left:8.0),
                                        child: Text("Fotoğraf detayı"),
                                      ),
                                    ],
                                  ),
                                  value: 1,
                                ),
                                PopupMenuItem(
                                  padding: EdgeInsets.only(right: 0,left: 8),
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete,color: Colors.black),
                                      Padding(
                                        padding: const EdgeInsets.only(left:8.0),
                                        child: Text("Fotoğrafı sil"),
                                      ),
                                    ],
                                  ),
                                  value: 2,
                                ),
                              ]),
                        ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.all(20),
                            child: Image.memory(
                              base64Decode(imageData),width: 400,height: 350,),
                          ),
                        ),
                      ],
                    ),
                  ):Text("Fotoğraf Eklenmedi"),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width - 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Align(
                        child: Container(
                          height: 55,
                          width: 100,
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
                        child: Container(
                          height: 55,
                          width: 100,
                          child: ElevatedButton(
                            style: ButtonStyle(),
                            onPressed: () {
                              Upload();
                            },
                            child: Icon(
                              Icons.drive_folder_upload,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      );
  }
}