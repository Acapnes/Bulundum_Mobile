import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  var image;
  List imageArray = [];
  int _activeindex = 0;

  getImage() async {
    image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      imageArray[_activeindex].add(image);
    });
  }

  altEsyaEkle() {
    setState(() {
      imageArray.add([]);
      _activeindex += 1;
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
        currentIndex: _activeindex,
        type: BottomNavigationBarType.shifting,
        iconSize: 25,
        onTap: (index) {
          setState(() {
            _activeindex = index;
          });
          if (index == -1) {
            altEsyaEkle();
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.keyboard_arrow_left_outlined),
            label: "Önceki Alt Eşya",
            backgroundColor: Colors.blueAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.keyboard_arrow_up_outlined),
            label: "Ana Eşyaya Dön",
            backgroundColor: Colors.blueAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "Yeni Alt Eşya",
            backgroundColor: Colors.blueAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.keyboard_arrow_right_outlined),
            label: "Önceki Alt Eşya",
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
                        child: ElevatedButton(
                            child: Icon(
                              Icons.add_a_photo,
                              size: 40,
                            ),
                            style: ButtonStyle(backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                              return Colors.orangeAccent;
                            })),
                            onPressed: () {
                              getImage();
                            }),
                      ),
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                            child: Icon(
                              Icons.upload_file,
                              size: 40,
                            ),
                            style: ButtonStyle(backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                              return Colors.orangeAccent;
                            })),
                            onPressed: () {}),
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
                  itemCount: imageArray[_activeindex].length,
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
                                  print(imageArray[_activeindex]);
                                  setState(() {});
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

class AltEsyaC {
  String name;

  List subimageArray = [];
}
