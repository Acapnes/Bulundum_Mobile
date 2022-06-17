import 'package:bulundum_mobile/Buluntu/BuluntuListele.dart';
import 'package:bulundum_mobile/Pages/Login-Register/RegisterPage.dart';
import 'package:bulundum_mobile/Pages/Help/Help.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginMain extends StatefulWidget {
  const LoginMain({Key key}) : super(key: key);

  @override
  _LoginMainState createState() => _LoginMainState();
}

class _LoginMainState extends State<LoginMain> {
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: mainDrawer(),
      appBar: AppBar( title: Text("Giriş yap!") ,centerTitle: true,
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
      body: Container(
        margin: EdgeInsets.only(left: 20,right: 20,top: 50),
        child: Form(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 50),
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text("E-Posta / Kullanıcı Adı",
                            style: TextStyle(fontSize: 16))),
                    TextField(
                      autofocus: true,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      controller: usernameController,
                      decoration: InputDecoration(hintText: ''),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(),
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text("Şifre", style: TextStyle(fontSize: 16))),
                    TextField(
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordController,
                      decoration: InputDecoration(hintText: ''),
                      onSubmitted: (term){
                      },
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 40),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        child: RaisedButton(
                          color: Color(0xFF0078CE),
                          child: Text(
                            "Giriş Yap",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            login();
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text("Hesabın yok mu?"),
                    ),
                    Container(
                      margin: EdgeInsets.only(),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        child: RaisedButton(
                          color: Color(0xFF0078CE),
                          child: Text(
                            "Kayıt ol!",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => RegisterMain()));
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
      ),
    );
  }

  Future<void> login() async {
    /// 192.168.1.33 LocalHost ip
    if (passwordController.text.isNotEmpty && usernameController.text.isNotEmpty) {
      var url = 'https://db9a-85-96-210-113.ngrok.io/mobiledb/auth/login.php';
      var response = await http.post(Uri.parse(url),
          body: ({
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