import 'package:bulundum_mobile/Controllers/BottomNavigationBar/mainBNB.dart';
import 'package:flutter/material.dart';


class mainMessages extends StatefulWidget {
  const mainMessages({Key key}) : super(key: key);

  @override
  _mainMessagesState createState() => _mainMessagesState();
}

class _mainMessagesState extends State<mainMessages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: mainBNB(),
      body: Container(
        child: Text("deneme"),
      ),
    );
  }
}
