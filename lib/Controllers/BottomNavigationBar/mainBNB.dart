import 'package:bulundum_mobile/Buluntu/BuluntuListele.dart';
import 'package:bulundum_mobile/Buluntu/FotoBuluntuEkle.dart';
import 'package:bulundum_mobile/KayipEsya/Kay%C4%B1pEsyaListele.dart';
import 'package:bulundum_mobile/Pages/Messages/mainMessages.dart';
import 'package:bulundum_mobile/Pages/Profile/Profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class mainBNB extends StatefulWidget {
  @override
  _mainBNBState createState() => _mainBNBState();
}

class _mainBNBState extends State<mainBNB> {
  bool Company = false;
  int _currentIndex = 0;

  GetCompanyType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.get("CompanyType") != "ctNone") {
      setState(() {
        Company = true;
      });
    } else {
      setState(() {
        Company = false;
      });
    }
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // **** Invidual **** //
    if (Company == false) {
      if (_currentIndex == 0) {
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => MainBuluntuList()));
      } else if (_currentIndex == 1) {
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => MainKayipList()));
      } else if (_currentIndex == 2) {
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => mainProfile()));
      }
    }

    // **** Corporate **** //

    else if (Company == true) {
      if (_currentIndex == 0) {
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => MainKayipList()));
      }if (_currentIndex == 1) {
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => MainFoto()));
      }  else if (_currentIndex == 2) {
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => mainProfile()));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    GetCompanyType();
  }

  @override
  Widget build(BuildContext context) {
    if (Company == true) {
      return BottomNavigationBar(
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
            icon: Icon(Icons.list_alt_outlined, color: Colors.blueAccent),
            title: Text('Kayıp Eşya Listesi'),
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
            title: Text('Kayıp Eşya Listesi'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add, color: Colors.blueAccent),
            title: Text('Eşya Ekle'),
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
