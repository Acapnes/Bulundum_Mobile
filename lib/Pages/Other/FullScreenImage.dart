//import 'package:bulundum_mobile/Buluntu/BuluntuListele.dart';
import 'package:bulundum_mobile/Buluntu/BuluntuListele.dart';
import 'package:bulundum_mobile/KayipEsya/KayıpEsyaListele.dart';
import 'package:flutter/material.dart';



class mainFSImage extends StatelessWidget {
  final int index;
  Buluntu buluntu;
  KayipEsya kayipEsya;
  mainFSImage({Key key, @required this.index,this.buluntu,this.kayipEsya}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image(
          fit: BoxFit.cover,
          image: buluntu == null ? NetworkImage(kayipEsya.Images[index]["RemotePath"]) : NetworkImage(buluntu.Images[index]["RemotePath"]),
        ),
      ),
    );
  }
}
