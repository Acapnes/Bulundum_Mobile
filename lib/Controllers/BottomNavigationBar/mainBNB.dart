import 'package:bulundum_mobile/Buluntu/BuluntuListele.dart';
import 'package:bulundum_mobile/Pages/Profile/Profile.dart';
import 'package:flutter/material.dart';

class mainBNB extends StatefulWidget {
  @override
  _mainBNBState createState() => _mainBNBState();
}

class _mainBNBState extends State<mainBNB> {
  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    if (_currentIndex == 0) {
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => MainBuluntuList()));
    } else if (_currentIndex == 1) {
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => MainProfile()));
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: BottomNavigationBar(
        elevation: 20,
        onTap: onTabTapped,
        iconSize: 35,
        selectedItemColor: Colors.orangeAccent,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list,
              color: Colors.blueAccent,
            ),
            title: Text('Buluntu Listesi'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.blueAccent),
              title: Text('Profil')),
        ],
      ),
    );
  }
}
