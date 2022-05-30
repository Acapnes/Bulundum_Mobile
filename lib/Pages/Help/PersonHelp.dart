import 'package:flutter/material.dart';

class MainPersonHelp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20,),
              Text("Giriş Yapma Hakkında",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold)),
              SizedBox(height: 20,),
              Text("- Kullanıcı adınızı / E-postanızı eksiksiz ve hatasız aşşağıda bir şekilde, Şifrenizi eksizsiz ve hatasız bir şekilde belirtilen bölgeye giriniz.",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
              SizedBox(height: 10,),
              Image.asset("img/help/help_login.png"),
              SizedBox(height: 10,),
              Text("- Eksiksiz ve hatasız girdiğinizi düşünüyorsanız giriş tuşuna basınız.",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
              SizedBox(height: 10,),
              Image.asset("img/help/help_login_button.png"),

              SizedBox(height: 20,),
              Text("Kayıt Olma Hakkında",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold)),
              SizedBox(height: 20,),
              Text("- İsim - Soyisim - Kullanıcıadı / E-posta ve son olarak şifrenizi eksiksiz ve hatasız bir şekilde aşşağıda belirtilen bölgelere giriniz.",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
              SizedBox(height: 10,),
              Image.asset("img/help/help_register.png"),
              SizedBox(height: 10,),
              Text("- Eğer girdiğiniz bilgilerin doğru ve eksiksiz olduğunu düşünüyorsanız kayıt ol butonuna basınız.",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
              SizedBox(height: 10,),
              Image.asset("img/help/help_register_button.png"),
              SizedBox(height: 10,),

              SizedBox(height: 50,),
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
