import 'dart:convert';
import 'package:bulundum_mobile/Controllers/BottomNavigationBar/mainBNB.dart';
import 'package:bulundum_mobile/Controllers/Colors/primaryColors.dart';
import 'package:bulundum_mobile/Pages/Help/Help.dart';
import 'package:flutter/widgets.dart';
import 'package:bulundum_mobile/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MainProfile extends StatefulWidget {
  @override
  _MainProfileState createState() => _MainProfileState();
}

class _MainProfileState extends State<MainProfile> {
  var profileId;
  TextEditingController textFirstNameController = TextEditingController();
  TextEditingController textLastNameController = TextEditingController();
  TextEditingController textUserNameController = TextEditingController();
  TextEditingController textPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initialGet();
  }

  deleteProfile() async {
    var url = 'https://db9a-85-96-210-113.ngrok.io/mobiledb/auth/profileDelete.php';
    var response = await http.post(Uri.parse(url),
        body: ({
          'id': profileId,
        }));
    if(response.statusCode == 200)
    {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove("name");
      prefs.remove("surname");
      prefs.remove("username");
      prefs.remove("password");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Hesap silme işlemi başarılı.")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Hesap silme işlemi başarısız.")));
    }
  }

  profileUptade() async {
    var url = 'https://db9a-85-96-210-113.ngrok.io/mobiledb/auth/profileupdate.php';
    var response = await http.post(Uri.parse(url),
        body: ({
          'id': profileId,
          'name': textFirstNameController.text,
          'surname': textLastNameController.text,
          'username': textUserNameController.text,
          'password': textPasswordController.text,
        }));
    if(response.statusCode == 200)
    {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("name", textFirstNameController.text);
      prefs.setString("surname", textLastNameController.text);
      prefs.setString("username", textUserNameController.text);
      prefs.setString("password", textPasswordController.text);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Güncelleme işlemi başarılı.")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Güncelleme işlemi başarısız.")));
    }
  }

  logout() async {
    var url = 'https://db9a-85-96-210-113.ngrok.io/mobiledb/auth/logout.php';
    var response = await http.post(Uri.parse(url),
        body: ({
          'username': textFirstNameController.text,
          'password': textPasswordController.text,
        }));
    if(response.statusCode == 200)
      {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove("username");
        prefs.remove("password");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyHomePage()));
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Hesaptan çıkış işlemi başarılı.")));
      } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Hesaptan çıkış işlemi başarısız.")));
    }
  }

  initialGet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = "https://db9a-85-96-210-113.ngrok.io/mobiledb/auth/userInfo.php";
    var response = await http.post(Uri.parse(url),
        body: ({
          'username': prefs.get("username"),
          'password': prefs.get("password"),
        }));
    if(response.statusCode == 200)
    {
      var jsonData = jsonDecode(response.body);
      textFirstNameController.text = jsonData["name"];
      textLastNameController.text = jsonData["surname"];
      textUserNameController.text = jsonData["username"];
      textPasswordController.text = jsonData["password"];
      setState(() {
        profileId = jsonData["id"];
      });
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Hesap bilgilerini çekme işlemi başarısız.")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil"),
        elevation: 0,
        centerTitle: true, backgroundColor: kPrimaryColor,
        actions: [
          PopupMenuButton(
              icon: Icon(Icons.filter_list),
              iconSize: 20,
              onSelected: (value){
                if(value==1)
                  logout();
                else if(value ==2)
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => MainHelp()));
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  padding: EdgeInsets.only(right: 0,left: 8),
                  child: Row(
                    children: [
                      Icon(Icons.logout,color: Colors.black),
                      Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Text("Hesaptan Çık"),
                      ),
                    ],
                  ),
                  value: 1,
                ),
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
                  value: 2,
                ),
              ]),
        ],
      ),
      bottomNavigationBar: mainBNB(),
      body: MaterialApp(
        theme: ThemeData(
            primaryColor: kPrimaryColor,
            accentColor: kPrimaryColor,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            fontFamily: 'Ubuntu'),
        home: Container(
          color: kPrimaryColor,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Container(
            margin: EdgeInsets.only(top: 5),
            child: Column(
              children: <Widget>[
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width - 20,
                  child: Stack(
                    children: [
                      Container(
                        child: Center(
                          child: SizedBox(
                            height: 125,
                            width: 125,
                            child: CircleAvatar(
                              maxRadius: 20,
                              backgroundImage:
                              AssetImage("img/circle-avatar.jpg"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 5, right: 5, bottom: 5),
                    child: Card(
                      child: Column(children: <Widget>[
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 10, left: 5),
                            child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Container(
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: "İsminiz",
                                        ),
                                        autocorrect: false,
                                        controller: textFirstNameController,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: "Soyadınız",
                                        ),
                                        autocorrect: false,
                                        controller: textLastNameController,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: "Email",
                                        ),
                                        autocorrect: false,
                                        controller: textUserNameController,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: "Şifre",
                                        ),
                                        autocorrect: false,
                                        controller: textPasswordController,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 10, left: 10, right: 10),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.lightGreen),
                                        onPressed: () {
                                          profileUptade();
                                        },
                                        child: ListTile(
                                          title: Text(
                                            "Profili Güncelle",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                          trailing: Icon(
                                            Icons.save,
                                            color: Colors.white,
                                            size: 35,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 10, left: 10, right: 10),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.orange),
                                        onPressed: () {
                                          logout();
                                        },
                                        child: ListTile(
                                          title: Text(
                                            "Oturumu kapat",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                          trailing: Icon(
                                            Icons.logout,
                                            color: Colors.white,
                                            size: 35,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 10, left: 10, right: 10),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.red),
                                        onPressed: () {
                                          deleteProfile();
                                        },
                                        child: ListTile(
                                          title: Text(
                                            "Hesabı Sil",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                          trailing: Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                            size: 35,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20,),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
