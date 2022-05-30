import 'package:flutter/material.dart';

class MainItemHelp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Column(
            children: <Widget>[
              SizedBox(height: 20,),
              Text("Kayıp Eşyalar Hakkında",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold)),
              SizedBox(height: 20,),
              Text("- Eşyalar listeme sayfasında eşyayı kısaca tanımlayacak şekide listelenir. Bu eşyalara detaylı göz atmak istiyen kullanıcılar"
                  " listelenen eşyanın solalt kısmında bulunan detaylar butonuna veya sağüst kısmında bulunan menü butonuna basarak eşya detaylarına gidebilirler.",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
              SizedBox(height: 5,),
              Image.asset("img/help/help_item.png"),
              SizedBox(height: 5,),
              Text("- Eşya ekleme sayfasında kullanıcı belirtilen yerleri eksiksiz doldurup eşyanın fotoğrafını anlaşılır bir biçimde çekerek gönderme butonu ile işlemi gerçekleştirir.",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
              SizedBox(height: 5,),
              Image.asset("img/help/help_item_add.png"),
              SizedBox(height: 10,),
              Text("- Kayıp eşya ekleme işleminizin kalite standartları çerçevesinde olduğuna dikkat ediniz.",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
              SizedBox(height: 5,),SizedBox(height: 5,),
              Text("- Eğer herhangi bir hata ile karşılaşıyorsanız internet durumunuzu ve uygulama izinlerini kontrol ediniz.",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
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
              Text("Sorun hala devam ediyorsa lütfen bize ulaşın.",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.orange)),
              SizedBox(height: 5,),
              Text("E-postamız: lost_foundApp@gmial.com"),
            ],
          ),
        ),
      ),
    );
  }
}
