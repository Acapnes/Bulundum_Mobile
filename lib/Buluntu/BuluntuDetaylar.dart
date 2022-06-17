import 'dart:convert';
import 'dart:io';
import 'package:bulundum_mobile/Controllers/Colors/primaryColors.dart';
import 'package:http/http.dart' as http;
import 'package:bulundum_mobile/Buluntu/BuluntuListele.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class mainBuluntuDetaylar extends StatefulWidget {
  Item buluntu;
  mainBuluntuDetaylar(this.buluntu);

  @override
  _mainBuluntuDetaylarState createState() => _mainBuluntuDetaylarState();
}

class _mainBuluntuDetaylarState extends State<mainBuluntuDetaylar> {

  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemLocationController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  final imagePicker = ImagePicker();
  File imageFile;
  String imageData;

  @override
  void initState() {
    super.initState();

    /// TextEditingControllers value initialize
    itemNameController.text = widget.buluntu.item_name;
    itemLocationController.text = widget.buluntu.item_location;
    commentController.text = widget.buluntu.comment;
  }

  getImageMainBuluntu() async {
    final image = await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      if (image != null) {
        imageFile = File(image.path);
        imageData = base64Encode(imageFile.readAsBytesSync());
        widget.buluntu.item_photo = imageData;
      }});
  }

  updateItem() async {
    var url = 'https://db9a-85-96-210-113.ngrok.io/mobiledb/item/itemupdate.php';
    var response = await http.post(Uri.parse(url),
    body: ({
      'item_id': widget.buluntu.item_id,
      'item_name': itemNameController.text,
      'item_photo': widget.buluntu.item_photo,
      'item_location': itemLocationController.text,
      'comment': commentController.text
    }));
    if(response.statusCode == 200){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Güncelleme işlemi başarılı.")));
      setState((){});
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Güncelleme işlemi başarısız.")));
    }
  }

  removeItem() async {
    var url = 'https://db9a-85-96-210-113.ngrok.io/mobiledb/item/itemdelete.php';
    var response = await http.post(Uri.parse(url),
        body: ({
          'item_id': widget.buluntu.item_id,
        }));
    if(response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Silme işlemi başarılı.")));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainBuluntuList()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Silme işlemi başarısız.")));
    }
  }

  removePhoto() async {
    var url = 'https://db9a-85-96-210-113.ngrok.io/mobiledb/item/itemphotodelete.php';
    var response = await http.post(Uri.parse(url),
        body: ({
          'item_id': widget.buluntu.item_id,
        }));
    if(response.statusCode == 200) {
      setState(() {
        widget.buluntu.item_photo = "null";
      });
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Fotoğraf kaldırma işlemi başarılı.")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Fotoğraf kaldırma işlemi başarısız.")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text("Buluntu Detayları"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 4 - 20,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: widget.buluntu.item_photo != "null" ?
                  Image.memory(
                    base64Decode(widget.buluntu.item_photo), fit: BoxFit.fill,
                  ): FlatButton(
                    onPressed: () => getImageMainBuluntu(),
                    child: Text("Fotoğraf Ekle"),
                  ),
                ),
                Container(
                  width: 250,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        color: Colors.orangeAccent, width: 4.5),
                  ),
                  child: Center(
                      child: widget.buluntu.item_id != ""
                          ? Text(
                        "No: " + widget.buluntu.item_id,
                        style: TextStyle(fontSize: 18),
                      )
                          : Text("Boş")),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(10),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Eşya İsmi",
                          ),
                          autocorrect: false,
                          controller: itemNameController,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Eşya Konumu",
                          ),
                          autocorrect: false,
                          controller: itemLocationController,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: TextFormField(
                          maxLines: 6,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Eşya Yorumu",
                          ),
                          autocorrect: false,
                          controller: commentController,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      FlatButton(
                          height: 50,
                          color: Colors.yellow,
                          onPressed: () => updateItem(),
                          child: Text("Güncelle")
                      ),
                      FlatButton(
                          height: 50,
                          color: Colors.red,
                          onPressed: () => removeItem(),
                          child: Text("Sil")
                      ),
                      FlatButton(
                          height: 50,
                          color: Colors.orangeAccent,
                          onPressed: () => {
                            if(widget.buluntu.item_photo != "null")
                              removePhoto()
                            else
                              getImageMainBuluntu()
                          },
                          child: widget.buluntu.item_photo != "null" ? Text("Fotoğrafı Kaldır") :Text("Fotoğraf Ekle"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
