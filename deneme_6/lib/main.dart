import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:deneme_6/beslenme.dart';
import 'package:deneme_6/yoklama.dart';
import 'package:deneme_6/servis.dart';
import 'package:deneme_6/ders.dart';
import 'package:deneme_6/etkinlikler.dart';
import 'package:deneme_6/iletisim.dart';

void main()  {
  WidgetsFlutterBinding.ensureInitialized();
 // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  final Future<FirebaseApp> _initilization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => Giris(),
        "/AnasayfaRotasi": (context) => Anasayfa(),
        "/BeslenmeSayfasıRotasi":(context) => Beslenme(),
        "/DersSayfasiRotasi":(context) => Ders(),
        "/ServisSayfasiRotasi":(context) => Servis(),
        "/YoklamaSayfasiRotasi":(context) => Yoklama(),
        "/EtkinlikSayfasiRotasi":(context) => Etkinlik(),
        "/IletisimSayfasiRotasi": (context) => Iletisim(),

        //admin sayfa rotası
        "/AdminAnasayfaRotasi": (context) => AdminAnasayfa(),
        "/AdminBeslenmeSayfasıRotasi":(context) => AdminBeslenme(),
        "/AdminDersSayfasiRotasi":(context) => AdminDers(),
        "/AdminServisSayfasiRotasi":(context) => AdminServis(),
        "/AdminYoklamaSayfasiRotasi":(context) => AdminYoklama(),
        "/AdminEtkinlikSayfasiRotasi":(context) => AdminEtkinlik(),
        "/BeslenmeDuzenle":(context) => BeslenmeDuzenle(),
        "/EtkinlikDuzenle":(context) => EtkinlikDuzenle(),
      },
    );
  }
}

class Giris extends StatefulWidget {
  @override
  _GirisState createState() => _GirisState();
}

class _GirisState extends State<Giris> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

  girisYap(){
    if(t1.text == "admin" && t2.text == "1234") {
      Navigator.pushNamed(context, "/AdminAnasayfaRotasi", arguments: VeriModeli(t1.text ,t2.text));
    }
    else if(t1.text == "kullanici" && t2.text == "1234") {
      Navigator.pushNamed(context, "/AnasayfaRotasi", arguments: VeriModeli(t1.text ,t2.text));
    }

    else {
      showDialog(context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Yanlış kullanıcı adı veya şifre"),
            content:  new Text("Lütfen giriş bilgilerinizi gözden geçiriniz."),
            actions:<Widget> [
              new FlatButton(onPressed: (){Navigator.of(context).pop();}, child: new Text("Kapat"))
            ],
          );
        },
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( backgroundColor: Colors.white,
        centerTitle: true,title: Text("Akıllı Kreş",style: TextStyle(color: Colors.black)),),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(100),
          child: Column(
            children:<Widget> [
              TextFormField(
                decoration: InputDecoration(hintText: "Kullanıcı Adı:"),
                controller: t1,),
              TextFormField(
                decoration: InputDecoration(hintText: "Şifre:"),
                controller: t2,),
              RaisedButton(onPressed: girisYap, child: Text("Giriş yap"),),
            ],
          ),
        ),
      ),
    );
  }
}

class AdminAnasayfa extends StatefulWidget {
  @override
  _AdminAnasayfaState createState() => _AdminAnasayfaState();
}

class _AdminAnasayfaState extends State<AdminAnasayfa> {
  @override
  adminyoklama(){
    Navigator.pushNamed(context, "/AdminYoklamaSayfasiRotasi");
  }
  adminbeslenme(){
    Navigator.pushNamed(context, "/AdminBeslenmeSayfasıRotasi");
  }
  adminders(){
    Navigator.pushNamed(context, "/AdminDersSayfasiRotasi");
  }
  adminservis(){
    Navigator.pushNamed(context, "/AdminServisSayfasiRotasi");
  }
  adminetkinlik(){
    Navigator.pushNamed(context, "/AdminEtkinlikSayfasiRotasi");
  }
  cikisYap(){
    Navigator.pop(context);
  }
  Widget build(BuildContext context) {
    VeriModeli iletilenArgumanlar = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,
        centerTitle: true,title: Text("Anasayfa",style: TextStyle(color: Colors.black),),),
      body: Center(
        child: Container(
          child: Column(
            children: [
              new Align(alignment: Alignment(0.7, -0.9), child:Text(iletilenArgumanlar.kullaniciAdi ,style: TextStyle(color: Colors.black, fontSize: 20),),),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: FlatButton(
                      highlightColor: Colors.white,
                      splashColor: Colors.white,
                      onPressed:adminbeslenme,

                      child: Image.asset('assets/icons/beslenme.jpg')
                  ),
                ),
              ),
              Text('Beslenme Programı',
                style: TextStyle(fontSize: 15),
              ),
              Container(
                width: 200,
                child: Divider(
                  height: 5,
                  color: Colors.black,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: FlatButton(
                    highlightColor: Colors.white,
                    splashColor: Colors.white,
                    onPressed: adminyoklama,
                    child: Image.asset('assets/icons/yoklama.jpg'),
                  ),
                ),
              ),
              Text('Yoklama Bilgisi',
                style: TextStyle(fontSize: 15),
              ),
              Container(
                width: 200,
                child: Divider(
                  height: 5,
                  color: Colors.black,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: FlatButton(
                      highlightColor: Colors.white,
                      splashColor: Colors.white,
                      onPressed: adminders,
                      child: Image.asset('assets/icons/ders.jpg')),
                ),
              ),
              Text('Ders Programı',
                style: TextStyle(fontSize: 15),
              ),
              Container(
                width: 200,
                child: Divider(
                  height: 5,
                  color: Colors.black,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: FlatButton(
                      highlightColor: Colors.white,
                      splashColor: Colors.white,
                      onPressed: adminservis,
                      child: Image.asset('assets/icons/servis.jpg')),
                ),
              ),
              Text('Servis Bilgisi',
                style: TextStyle(fontSize: 15),
              ),
              Container(
                width: 200,
                child: Divider(
                  height: 5,
                  color: Colors.black,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: FlatButton(
                      highlightColor: Colors.white,
                      splashColor: Colors.white,
                      onPressed: adminetkinlik,
                      child: Image.asset('assets/icons/etkinlik.png')),
                ),
              ),
              Text('Etkinlikler',
                style: TextStyle(fontSize: 15),
              ),
              Container(
                width: 200,
                child: Divider(
                  height: 3,
                  color: Colors.black,
                ),
              ),
              Align(alignment: Alignment.bottomRight,
                child: RaisedButton(onPressed: cikisYap, child: Text("Çıkış yap"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Anasayfa extends StatefulWidget {
  @override
  _AnasayfaState createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  beslenme(){
    Navigator.pushNamed(context, "/BeslenmeSayfasıRotasi");
  }
  ders(){
    Navigator.pushNamed(context, "/DersSayfasiRotasi");
  }
  servis(){
    Navigator.pushNamed(context, "/ServisSayfasiRotasi");
  }
  yoklama(){
    Navigator.pushNamed(context, "/YoklamaSayfasiRotasi");
  }
  etkinlik(){
    Navigator.pushNamed(context, "/EtkinlikSayfasiRotasi");
  }
  iletisim(){
    Navigator.pushNamed(context, "/IletisimSayfasiRotasi");
  }
  cikisYap(){
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {

    VeriModeli iletilenArgumanlar = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,
        centerTitle: true,title: Text("Anasayfa",style: TextStyle(color: Colors.black),),),
      body: Center(
        child: Container(
          child: Column(
            children:<Widget> [
              new Align(alignment: Alignment(0.7, -0.9), child:Text(iletilenArgumanlar.kullaniciAdi ,style: TextStyle(color: Colors.black, fontSize: 20),),),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: FlatButton(
                      highlightColor: Colors.white,
                      splashColor: Colors.white,
                      onPressed:beslenme,

                      child: Image.asset('assets/icons/beslenme.jpg')
                  ),
                ),
              ),
              Text('Beslenme Programı',
                style: TextStyle(fontSize: 15),
              ),
              Container(
                width: 200,
                child: Divider(
                  height: 5,
                  color: Colors.black,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: FlatButton(
                      highlightColor: Colors.white,
                      splashColor: Colors.white,
                      onPressed: ders,
                      child: Image.asset('assets/icons/ders.jpg')),
                ),
              ),
              Text('Ders Programı',
                style: TextStyle(fontSize: 15),
              ),
              Container(
                width: 200,
                child: Divider(
                  height: 5,
                  color: Colors.black,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: FlatButton(
                      highlightColor: Colors.white,
                      splashColor: Colors.white,
                      onPressed: servis,
                      child: Image.asset('assets/icons/servis.jpg')),
                ),
              ),
              Text('Servis Bilgisi',
                style: TextStyle(fontSize: 15),
              ),
              Container(
                width: 200,
                child: Divider(
                  height: 5,
                  color: Colors.black,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: FlatButton(
                    highlightColor: Colors.white,
                    splashColor: Colors.white,
                    onPressed: yoklama,
                    child: Image.asset('assets/icons/yoklama.jpg'),
                  ),
                ),
              ),
              Text('Yoklama Bilgisi',
                style: TextStyle(fontSize: 15),
              ),
              Container(
                width: 200,
                child: Divider(
                  height: 5,
                  color: Colors.black,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: FlatButton(
                      highlightColor: Colors.white,
                      splashColor: Colors.white,
                      onPressed: etkinlik,
                      child: Image.asset('assets/icons/etkinlik.png')),
                ),
              ),
              Text('Etkinlikler',
                style: TextStyle(fontSize: 15),
              ),
              Container(
                width: 200,
                child: Divider(
                  height: 3,
                  color: Colors.black,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: FlatButton(
                      highlightColor: Colors.white,
                      splashColor: Colors.white,
                      onPressed: iletisim,
                      child: Image.asset('assets/icons/iletisim.png')),
                ),
              ),
              Text('İletişim',
                style: TextStyle(fontSize: 15),
              ),
              Container(
                width: 200,
                child: Divider(
                  height: 5,
                  color: Colors.black,
                ),
              ),

              Align(alignment: Alignment.bottomRight,
                child: RaisedButton(onPressed: cikisYap, child: Text("Çıkış yap"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VeriModeli {
  String kullaniciAdi, sifre;
  VeriModeli(this.kullaniciAdi, this.sifre);
}

/*
            ElevatedButton(
                onPressed: () async {
                 var response= await mertRef.get();
                 var veri = response.data();
                 print(veri);
                 print(veri['isim']);

                 var response1 = await yoklamaRef.get();
                 var list = response1.docs;
                 print(list[0].data());

                },
                child:Text('veri al')),*/