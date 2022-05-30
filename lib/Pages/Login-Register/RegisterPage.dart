import 'dart:convert';
import 'package:bulundum_mobile/Buluntu/BuluntuListele.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RegisterMain extends StatefulWidget {
  const RegisterMain({Key key}) : super(key: key);

  @override
  _RegisterMainState createState() => _RegisterMainState();
}

class _RegisterMainState extends State<RegisterMain> {

  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kayıt ol!") ,centerTitle: true,
        actions: [
          PopupMenuButton(
              iconSize: 20,
              onSelected: (value){},
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
      body: Container(
        margin: EdgeInsets.only(left: 20,right: 20,top: 50),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 30,
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child:
                                Text("İsim", style: TextStyle(fontSize: 16))),
                        TextField(
                          autofocus: true,
                          textInputAction: TextInputAction.next,
                          controller: nameController,
                          decoration: InputDecoration(hintText: ''),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 30,
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text("Soyisim",
                                style: TextStyle(fontSize: 16))),
                        TextField(
                          textInputAction: TextInputAction.next,
                          controller: surnameController,
                          decoration: InputDecoration(hintText: ''),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: Column(
                      children: <Widget>[
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text("E-Posta / Kullanıcı adı",
                                style: TextStyle(fontSize: 16))),
                        TextField(
                          textInputAction: TextInputAction.next,
                          controller: usernameController,
                          decoration: InputDecoration(hintText: ''),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: Column(
                      children: <Widget>[
                        Align(
                            alignment: Alignment.topLeft,
                            child:
                                Text("Şifre", style: TextStyle(fontSize: 16))),
                        TextField(
                          textInputAction: TextInputAction.done,
                          controller: passwordController,
                          decoration: InputDecoration(hintText: ''),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      child: RaisedButton(
                        color: Color(0xFF0078CE),
                        child: Text("Kayıt ol!",
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          register();
                        },
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


  Future<void> register() async {
    /// 192.168.1.33 LocalHost ip
    if (nameController.text.isNotEmpty && surnameController.text.isNotEmpty && usernameController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var url = 'http://192.168.1.33/mobiledb/auth/register.php';
      var response = await http.post(Uri.parse(url),
          body: ({
            'name': nameController.text,
            'surname': surnameController.text,
            'username': usernameController.text,
            'password': passwordController.text,
          }));
      var data = json.decode(response.body);
      print(response.statusCode.toString());
      print(data.toString());
      if(response.statusCode == 200 && data == "Success")
      {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('username', usernameController.text);
        prefs.setString('password', passwordController.text);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainBuluntuList()));
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Hesap oluşturuldu!")));
      }
      else
      {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Kullanıcı adı veya şifre hatalı.")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Lütfen gerekli alanları doldurun.")));
    }
  }
}
