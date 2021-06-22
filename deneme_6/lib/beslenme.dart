//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Beslenme extends StatefulWidget {
  @override
  _BeslenmeState createState() => _BeslenmeState();
}

class _BeslenmeState extends State<Beslenme> {
  final _firestore = FirebaseFirestore.instance;
  geri(){
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    CollectionReference beslenmeRef = FirebaseFirestore.instance.collection('beslenme');
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,
        centerTitle: true,title: Text("Beslenme Programı",style: TextStyle(color: Colors.black)),),
      body: Container(
        child: Column(
          children:<Widget> [
            StreamBuilder<QuerySnapshot>(
              // neyi dinlediğimiz bilgisi, hangi stream
              stream: beslenmeRef.snapshots(),
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
                                  Text('${listofDocumentSnap[index].get('gun')}',
                                    style: TextStyle(fontSize: 24),),
                                ],
                              ),
                              subtitle: Row(
                                children:[
                                  Text('${listofDocumentSnap[index].get('ogle')}',
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

                /*Text('${asynSnapshot.data.data()}')*/
              },
            ),

            RaisedButton(onPressed: geri, child: Text("Geri"),
            ),
          ],
        ),
      ),
    );
  }
}

class AdminBeslenme extends StatefulWidget {
  @override
  _AdminBeslenmeState createState() => _AdminBeslenmeState();
}

class _AdminBeslenmeState extends State<AdminBeslenme> {
  final _firestore = FirebaseFirestore.instance;

  @override
  geri(){
    Navigator.pop(context);
  }
  duzenle(){
    Navigator.pushNamed(context, "/BeslenmeDuzenle");
  }
  Widget build(BuildContext context) {

    CollectionReference beslenmeRef = FirebaseFirestore.instance.collection('beslenme');


    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,
        centerTitle: true,title: Text("Beslenme Programı",style: TextStyle(color: Colors.black)),),
      body: Container(
        child: Column(
          children:<Widget> [
            StreamBuilder<QuerySnapshot>(
              // neyi dinlediğimiz bilgisi, hangi stream
              stream: beslenmeRef.snapshots(),
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
                                  Text('${listofDocumentSnap[index].get('gun')}',
                                    style: TextStyle(fontSize: 24),),
                                ],
                              ),
                              subtitle: Row(
                                children:[
                                  Text('${listofDocumentSnap[index].get('ogle')}',
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
            RaisedButton(onPressed: geri, child: Text("Geri"),

            ),
          ],
        ),
      ),
    );
  }
}

class BeslenmeDuzenle extends StatefulWidget {

  @override
  _BeslenmeDuzenleState createState() => _BeslenmeDuzenleState();
}

class _BeslenmeDuzenleState extends State<BeslenmeDuzenle> {
  final _firestore = FirebaseFirestore.instance;
  TextEditingController ogleController = TextEditingController();
  TextEditingController gunController = TextEditingController();
  geri(){
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    CollectionReference beslenmeRef = _firestore.collection('beslenme');
    return  Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,
        centerTitle: true,title: Text("Beslenme Programı",style: TextStyle(color: Colors.black),),),
      body: Container(
        child: Column(
          children: [
            Container(child: Text('Günlerin ilk harfi büyük yazılmalıdır!',style: TextStyle(fontSize: 16),),),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 40),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller:  gunController,
                      decoration: InputDecoration(hintText: 'Gün'),
                    ),
                    TextFormField(
                      controller:  ogleController,
                      decoration: InputDecoration(hintText: 'Öğle yemeği'),
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
          print(ogleController.text);
          Map<String, dynamic> beslenmeData= {
            'ogle': ogleController.text,
            'gun' : gunController.text,
          };
          await beslenmeRef.doc(gunController.text).update(beslenmeData);
        },
      ),
    );
  }
}
