import 'package:bulundum_mobile/Controllers/Colors/primaryColors.dart';
import 'package:bulundum_mobile/Pages/Help/Information.dart';
import 'package:bulundum_mobile/Pages/Help/ItemHelp.dart';
import 'package:bulundum_mobile/Pages/Help/PersonHelp.dart';
import 'package:flutter/material.dart';

class MainHelp extends StatefulWidget {

  @override
  _MainHelpState createState() => _MainHelpState();
}

class _MainHelpState extends State<MainHelp> with SingleTickerProviderStateMixin {
  TabController _controller;

  Widget _helpPages() {
    switch (_controller.index) {
      case 0:
        return MainPersonHelp();
        break;
      case 1:
        return MainItemHelp();
        break;
      case 2:
        return MainInfoHelp();
        break;
    }
  }
  _handleTabChange() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this, initialIndex: 0);
    _controller.addListener(_handleTabChange);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
              iconSize: 20,
              onSelected: (value){},
              itemBuilder: (context) => [
                PopupMenuItem(
                  padding: EdgeInsets.only(right: 0,left: 8),
                  child: Row(
                    children: [
                      Icon(Icons.contact_support,color: Colors.black,),
                      Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Text("Bizimle iletişime geç"),
                      ),
                    ],
                  ),
                  value: 1,
                ),
              ]),
        ],
        backgroundColor: kPrimaryColor,
        title: Text("Yardım ve Bilgilendirme"),centerTitle: true,
        bottom: TabBar(
          controller: _controller,
          indicatorColor: Colors.white,
          tabs: [
            Tab(
              icon: Icon(Icons.person),
              text: "Hesap",
            ),
            Tab(
              icon: Icon(Icons.add_box),
              text: "Eşyalar",
            ),
            Tab(
              icon: Icon(Icons.perm_device_info_sharp),
              text: "Genel Bilgi",
            )
          ],
        ),
      ),
      body: TabBarView(
          controller: _controller,
          children: [MainPersonHelp(), MainItemHelp(), MainInfoHelp()]),
    );
  }
}


