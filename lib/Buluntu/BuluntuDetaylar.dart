import 'dart:convert';

import 'package:bulundum_mobile/Buluntu/BuluntuListele.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class mainBuluntuDetaylar extends StatefulWidget {
  final int number;

  const mainBuluntuDetaylar({Key key, this.number}) : super(key: key);

  @override
  _mainBuluntuDetaylarState createState() => _mainBuluntuDetaylarState(number);
}

class _mainBuluntuDetaylarState extends State<mainBuluntuDetaylar> {
  final int number;

  _mainBuluntuDetaylarState(this.number);

  Future getUserData() async {
    var response =
        await http.get(Uri.https('jsonplaceholder.typicode.com', 'users'));
    var jsonData = jsonDecode(response.body);
    List<User> users = [];
    for (var u in jsonData) {
      User user = User(u["name"], u["email"], u["username"]);
      users.add(user);
    }
    print(users.length);
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Card(
          child: FutureBuilder(
            future: getUserData(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Text("Loading.."),
                  ),
                );
              } else
                return ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, i) {
                    return Container(
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(snapshot.data[number].name),
                            subtitle: Text(snapshot.data[number].email),
                            trailing: Text(snapshot.data[number].name),
                          ),
                        ],
                      ),
                    );
                  },
                );
            },
          ),
        ),
      ),
    );
  }
}
