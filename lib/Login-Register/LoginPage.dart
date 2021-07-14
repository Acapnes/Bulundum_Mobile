import 'package:bulundum_mobile/Login-Register/RegisterPage.dart';
import 'package:bulundum_mobile/MainMenu/MenuPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginMain extends StatefulWidget {
  const LoginMain({Key key}) : super(key: key);

  @override
  _LoginMainState createState() => _LoginMainState();
}

class _LoginMainState extends State<LoginMain> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  bool isLogin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(20),
        child: Form(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 80, bottom: 80),
                child: Image(
                  image: AssetImage("img/bulundum_logo.png"),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 40),
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text("E-Posta / Kullanıcı Adı",
                            style: TextStyle(fontSize: 16))),
                    TextField(
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
                      controller: passwordController,
                      decoration: InputDecoration(hintText: ''),
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
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => MainMenu()));
                            //login();
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
      var response = await http.post(Uri.parse("https://reqres.in/api/login"),
          body: ({
            'email': emailController.text,
            'password': passwordController.text,
          }));
      if (response.statusCode == 200) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainMenu()));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Invalid Credentials")));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Black Failed Not Allowed")));
    }
  }
}
