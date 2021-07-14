import 'package:bulundum_mobile/Buluntu/BuluntuDetaylar.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MainBuluntuList extends StatefulWidget {

  @override
  _MainBuluntuListState createState() => _MainBuluntuListState();
}

class _MainBuluntuListState extends State<MainBuluntuList> {
  int number;


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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {},
      ),
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
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                      onTap: () {
                        number = i;
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                mainBuluntuDetaylar(number : number)));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 8,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orangeAccent,
                              blurRadius: 4,
                              offset: Offset(4, 8), // Shadow position
                            ),
                          ],
                        ),
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        child: Container(
                          child: ListTile(
                            title: Text("Eşya No",style: TextStyle(color: Colors.white),),
                            subtitle: Text(snapshot.data[i].name,style: TextStyle(color: Colors.white),),
                            trailing: SizedBox(
                              height: 100,
                              width: 100,
                              child: Image(
                                image: AssetImage("img/bulundum_logo.png"),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class User {
  final String name, email, userName;

  User(this.name, this.email, this.userName);
}
