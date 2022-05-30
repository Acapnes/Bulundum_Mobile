
import 'package:flutter/material.dart';

class MainInfoHelp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Column(
            children: <Widget>[
              SizedBox(height: 20,),
              Text("Uygulamamız Hakkında",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold)),
              SizedBox(height: 20,),
              Text(("- Uygulamamız kullanma kapsamında sizden bazı izinleri almak durumunda. Bu isteklerden bazıları kamerayı kullanma, ses kaydetme. Uygulamamızı"
                  " kullanmak için lütfen bu izinleri reddetmeyiniz aksi halde uygulamayı kullanmazsınız."),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
              SizedBox(height: 5,),SizedBox(height: 5,),
              Text("- Eğer izinlere tekrar göz atmak istiyorsanız telefonunuzun ayarlar kısmındaki uygulamar sekmesinden Lost&FoundApp uygulamasını seçerek izinler kısmına girmek.",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),

              SizedBox(height: 5,),SizedBox(height: 5,),
              Text("- Destek almak istiyorsanız bizimle iletişime geçebilirsiniz.",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),

              SizedBox(height: 40,),
              Text("Memnun kaldınız mı?",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500)),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Image.asset('img/dislike.png'),
                    iconSize: 50,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Geri dönüşünüz için teşekkür ederiz."),duration: Duration(seconds: 1)));
                    },
                  ),
                  IconButton(
                    icon: Image.asset('img/like.png'),
                    iconSize: 50,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Geri dönüşünüz için teşekkür ederiz."),duration: Duration(seconds: 1)));
                    },
                  ),
                ],
              ),
              SizedBox(height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Tüm Hakları saklıdır.",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500,color: Colors.orange)),
                  Icon(Icons.privacy_tip,size: 40,color: Colors.orange,)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

