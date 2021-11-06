library myApp.globals;
import 'package:bulundum_mobile/Buluntu/BuluntuListele.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///import '../../globals.dart' as globals;

bool isLoggedIn = false;
String sk1 = "";
String sk2 = "";
String id = "";
String server = "development";
String CompanyType = "";


String buluntuNoktalari = "";
String kayipNoktalari = "";
String personelListesi = "";
String depo = "";
String rafListesi = "";

getUrl (String getUrl) {
  if(server == "production"){
    return "https://bulundum.com/api/v3/$getUrl";
  }else{
    return "https://dev.bulundum.com/api/v3/$getUrl";
  }
}