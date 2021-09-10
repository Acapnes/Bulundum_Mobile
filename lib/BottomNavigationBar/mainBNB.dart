import 'package:bulundum_mobile/Profile/Profile.dart';
import 'package:flutter/material.dart';

class mainBNB extends StatefulWidget {
  @override
  _mainBNBState createState() => _mainBNBState();
}

class _mainBNBState extends State<mainBNB> {
  bool individual = false;
  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      print(_currentIndex);
      print(individual);
    });

    // **** Invidual **** //
    if (individual == false) {
      if (_currentIndex == 0) {
        setState(() {
          individual = !individual;
        });
      } else if (_currentIndex == 3) {
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => mainProfile()));
      }
    }

    // **** Corporate **** //

    else if (individual == true) {
      if (_currentIndex == 0) {
        setState(() {
          individual = !individual;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (individual != false) {
      return BottomNavigationBar(
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
            icon: Icon(Icons.list_alt_outlined, color: Colors.blueAccent),
            title: Text('Kayıp Eşya Listesi'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.network_check_outlined, color: Colors.blueAccent),
            title: Text('Eşleşmeler'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message, color: Colors.blueAccent),
            title: Text('Mesajlar'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.blueAccent),
              title: Text('Profil')),
        ],
      );
    } else {
      return BottomNavigationBar(
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
            title: Text('Eşya Listesi'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add, color: Colors.blueAccent),
            title: Text('Eşya Ekle'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message, color: Colors.blueAccent),
            title: Text('Mesajlar'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.blueAccent),
            title: Text('Profil'),
          ),
        ],
      );
    }
  }
}
