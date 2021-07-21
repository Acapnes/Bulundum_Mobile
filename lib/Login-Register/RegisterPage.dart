import 'package:bulundum_mobile/Login-Register/LoginPage.dart';
import 'package:flutter/material.dart';

class RegisterMain extends StatefulWidget {
  const RegisterMain({Key key}) : super(key: key);

  @override
  _RegisterMainState createState() => _RegisterMainState();
}

class _RegisterMainState extends State<RegisterMain> {
  final NameController = TextEditingController();
  final LastNameController = TextEditingController();
  final IdController = TextEditingController();
  final PwController = TextEditingController();

  String _name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 200,horizontal: 20),
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
                          controller: NameController,
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
                          controller: LastNameController,
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
                          controller: IdController,
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
                          controller: PwController,
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
                          //if (NameController.text !=null)
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginMain()));
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
}
