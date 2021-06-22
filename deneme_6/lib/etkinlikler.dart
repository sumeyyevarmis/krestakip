import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Etkinlik extends StatefulWidget {
  @override
  _EtkinlikState createState() => _EtkinlikState();
}

class _EtkinlikState extends State<Etkinlik> {
  final _firestore = FirebaseFirestore.instance;
  geri(){
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    CollectionReference etkinlikRef = FirebaseFirestore.instance.collection('etkinlikler');
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,
        centerTitle: true,title: Text("Etkinlikler",style: TextStyle(color: Colors.black)),),
      body: Container(
        child: Column(
          children:<Widget> [
            StreamBuilder<QuerySnapshot>(
              // neyi dinlediğimiz bilgisi, hangi stream
              stream: etkinlikRef.snapshots(),
              // Streamdan her yeni veri aktığında, aşağıdaki metodu çalıştırır
              builder:(BuildContext context, AsyncSnapshot asynSnapshot ) {


                if(asynSnapshot.hasError){
                  return Center(
                    child: Text('Bir hata oluştu, Tekrar Deneyiniz.'),
                  );
                }
                else{
                  if(asynSnapshot.hasData){
                    List<DocumentSnapshot> listofDocumentSnap = asynSnapshot.data.docs;
                    return Flexible(
                      child: ListView.builder(
                        itemCount: listofDocumentSnap.length,
                        itemBuilder: (context , index){
                          return Card(
                            child: ListTile(
                              title: Row(
                                children: [
                                  Text('${listofDocumentSnap[index].get('adı')}',
                                    style: TextStyle(fontSize: 24),),
                                ],
                              ),
                              subtitle: Row(
                                  children:[
                                    Text('${listofDocumentSnap[index].get('tarih')}',
                                      style: TextStyle(fontSize: 16),),
                                  ]
                              ),

                            ),
                          );
                        },

                      ),
                    );
                  }else{
                    return Center(child: CircularProgressIndicator(),);
                  }
                }
              },
            ),
            RaisedButton(onPressed: geri, child: Text("Geri"))
          ],
        ),
      ),
    );
  }
}



class AdminEtkinlik extends StatefulWidget {
  @override
  _AdminEtkinlikState createState() => _AdminEtkinlikState();
}

class _AdminEtkinlikState extends State<AdminEtkinlik> {
  final _firestore = FirebaseFirestore.instance;
  @override
  geri(){
    Navigator.pop(context);
  }
  duzenle(){
    Navigator.pushNamed(context, "/EtkinlikDuzenle");
  }
  Widget build(BuildContext context) {
    CollectionReference etkinlikRef = FirebaseFirestore.instance.collection('etkinlikler');
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,
        centerTitle: true,title: Text("Etkinlikler",style: TextStyle(color: Colors.black)),),
      body: Container(
        child: Column(
          children:<Widget> [
            StreamBuilder<QuerySnapshot>(
              // neyi dinlediğimiz bilgisi, hangi stream
              stream: etkinlikRef.snapshots(),
              // Streamdan her yeni veri aktığında, aşağıdaki metodu çalıştırır
              builder:(BuildContext context, AsyncSnapshot asynSnapshot ) {


                if(asynSnapshot.hasError){
                  return Center(
                    child: Text('Bir hata oluştu, Tekrar Deneyiniz.'),
                  );
                }
                else{
                  if(asynSnapshot.hasData){
                    List<DocumentSnapshot> listofDocumentSnap = asynSnapshot.data.docs;
                    return Flexible(
                      child: ListView.builder(
                        itemCount: listofDocumentSnap.length,
                        itemBuilder: (context , index){
                          return Card(
                            child: ListTile(
                              title: Row(
                                children: [
                                  Text('${listofDocumentSnap[index].get('adı')}',
                                    style: TextStyle(fontSize: 24),),
                                ],
                              ),
                              subtitle: Row(
                                children:[
                                  Text('${listofDocumentSnap[index].get('tarih')}',
                                    style: TextStyle(fontSize: 16),),

                                ],

                              ),

                            ),
                          );
                        },

                      ),
                    );
                  }else{
                    return Center(child: CircularProgressIndicator(),);
                  }
                }

                /*Text('${asynSnapshot.data.data()}')*/
              },
            ),
            RaisedButton(onPressed: duzenle, child: Text('Düzenle')),
            RaisedButton(onPressed: geri, child: Text("Geri"))
          ],
        ),
      ),
    );
  }
}

class EtkinlikDuzenle extends StatefulWidget {
  @override
  _EtkinlikDuzenleState createState() => _EtkinlikDuzenleState();
}

class _EtkinlikDuzenleState extends State<EtkinlikDuzenle> {
  final _firestore = FirebaseFirestore.instance;
  TextEditingController adiController = TextEditingController();
  TextEditingController tarihController = TextEditingController();
  @override
  geri(){
    Navigator.pop(context);
  }
  Widget build(BuildContext context) {
    CollectionReference etkinlikRef = _firestore.collection('etkinlikler');
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,
        centerTitle: true,title: Text("Etkinlikler",style: TextStyle(color: Colors.black),),),
      body: Container(
        child: Column(
          children: [
            Container(child: Text('Etkinliklerin ilk harfi büyük yazılmalıdır!',style: TextStyle(fontSize: 16),),),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 40),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller:  adiController,
                      decoration: InputDecoration(hintText: 'Etkinlik adı'),
                    ),
                    TextFormField(
                      controller:  tarihController,
                      decoration: InputDecoration(hintText: 'Tarih'),
                    ),
                  ],
                ),
              ),
            ),
            new Align(alignment: Alignment.bottomLeft,child: RaisedButton(onPressed: geri, child: Text("Geri"),),
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('Kaydet'),
        onPressed: () async{
          print(adiController.text);
          Map<String, dynamic> EtkinlikData= {
            'adı': adiController.text,
            'tarih' : tarihController.text,
          };
          await etkinlikRef.doc(adiController.text).set(EtkinlikData);
        },
      ),
    );
  }
}
