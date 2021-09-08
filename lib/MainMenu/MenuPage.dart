import 'package:bulundum_mobile/Buluntu/BuluntuEkle.dart';
import 'package:bulundum_mobile/Buluntu/BuluntuListele.dart';
import 'package:bulundum_mobile/Drawer/mainDrawer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  bool individual = false;

  getTypeofUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.get("UserType");

    if (prefs.get("sk1") != null && prefs.get("sk2") != null) {
      setState(() {
        individual = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getTypeofUser();
    print(individual);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: individual == false
            ? Text(
                "Bireysel",
                style: TextStyle(fontSize: 20),
              )
            : Text("Kurumsal", style: TextStyle(fontSize: 20)),
        centerTitle: true,
      ),
      drawer: mainDrawer(),
      body: SingleChildScrollView(
        child: Align(
          child: Container(
            margin: EdgeInsets.only(top: 20, left: 40, right: 40),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: individual == false
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 135,
                            child: ElevatedButton(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.list,
                                    size: 80,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 35),
                                    child: Text("Eşya Listesi",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 25)),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            mainBuluntuEkle()));
                              },
                            ),
                          ),
                        )
                      : SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 115,
                          child: ElevatedButton(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.list,
                                  size: 80,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 35),
                                  child: Text("Buluntu Listesi",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20)),
                                ),
                              ],
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainBuluntuList()));
                            },
                          ),
                        ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: individual == false
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 135,
                          child: ElevatedButton(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add_box,
                                  size: 80,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 35),
                                  child: Text("Eşya Ekle",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 25)),
                                ),
                              ],
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => mainBuluntuEkle()));
                            },
                          ),
                        )
                      : SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 115,
                          child: ElevatedButton(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.list_alt,
                                  size: 80,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 35),
                                  child: Text("Kayıp Eşya Listesi",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20)),
                                ),
                              ],
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => mainBuluntuEkle()));
                            },
                          ),
                        ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: individual == false
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 135,
                            child: ElevatedButton(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.message,
                                    size: 80,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 35),
                                    child: Text("Mesajlar",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 25)),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            mainBuluntuEkle()));
                              },
                            ),
                          )
                        : SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 115,
                            child: ElevatedButton(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.network_check_outlined,
                                    size: 80,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 35),
                                    child: Text("Eşleşmeler",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20)),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            mainBuluntuEkle()));
                              },
                            ),
                          ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: individual == false
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 135,
                          child: ElevatedButton(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.account_box,
                                  size: 80,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 35),
                                  child: Text("Profil",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 25)),
                                ),
                              ],
                            ),
                            onPressed: () {
                              setState(() {
                                individual = !individual;
                              });
                              /*Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => mainBuluntuEkle()));*/
                            },
                          ),
                        )
                      : SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 115,
                          child: ElevatedButton(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.message,
                                  size: 80,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 35),
                                  child: Text("Mesajlar",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20)),
                                ),
                              ],
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => mainBuluntuEkle()));
                            },
                          ),
                        ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: individual == false
                      ? null
                      : SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 115,
                          child: ElevatedButton(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.account_box,
                                  size: 80,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 35.0),
                                  child: Text("Profil",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20)),
                                ),
                              ],
                            ),
                            onPressed: () {
                              setState(() {
                                individual = !individual;
                              });
                              /*Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => mainBuluntuEkle()));*/
                            },
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
