import 'package:bulundum_mobile/Buluntu/BuluntuListele.dart';
import 'package:bulundum_mobile/Controllers/Drawer/mainDrawer.dart';
import 'package:bulundum_mobile/Pages/Login-Register/RegisterPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../globals.dart' as globals;

class LoginMain extends StatefulWidget {
  const LoginMain({Key key}) : super(key: key);

  @override
  _LoginMainState createState() => _LoginMainState();
}

class _LoginMainState extends State<LoginMain> {

  String sk1="",sk2="",CompanyType="";

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  bool isLogin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: mainDrawer(),
      body: Container(
        margin: EdgeInsets.only(left: 20,right: 20,top: 75),
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
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
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
    if (passwordController.text.isNotEmpty && emailController.text.isNotEmpty) {
      var response = await http.post(Uri.parse(globals.getUrl("login")),
          body: ({
            'Username': emailController.text,
            'Password': passwordController.text,
          }));
      if (response.statusCode == 200) {
        Map<String,dynamic> res = jsonDecode(response.body);
        if (res["err"] == 0) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('sk1', res["sk1"]);
          prefs.setString('sk2', res["sk2"]);
          prefs.setString('CompanyType', res["Company"]["Typ"]);
          globals.sk1 = res['sk1'];
          globals.sk2 = res['sk2'];
          globals.CompanyType = res["Company"]["Typ"];
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MainBuluntuList()));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Yanlış kullanıcı adı veya şifre")));
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Communication with server failed. Try again in a few minutes.")));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Lütfen gerekli alanları doldurun.")));
    }
  }
}