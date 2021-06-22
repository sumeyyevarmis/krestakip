import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Ders extends StatefulWidget {
  @override
  _DersState createState() => _DersState();
}

class _DersState extends State<Ders> {
  final _firestore=FirebaseFirestore.instance;
  geri(){
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference dersRef = _firestore.collection('ders');
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,
        centerTitle: true,title: Text("Ders Programı",style: TextStyle(color: Colors.black)),),
      body: Center(
        child: Column(
          children:<Widget> [
            StreamBuilder<QuerySnapshot>(
        stream: dersRef.snapshots(),
              builder: (BuildContext context, AsyncSnapshot asyncSnapshot){
                if(asyncSnapshot.hasError){
                  return Center(
                    child: Text('Bir hata oluştu, Tekrar Deneyiniz.'),
                  );
                }
                else{
                  if(asyncSnapshot.hasData){
                    List<DocumentSnapshot> listofDocumentSnap =asyncSnapshot.data.docs;
                    return Flexible(
                      child: ListView.builder(
                        itemCount: listofDocumentSnap.length,
                        itemBuilder: (context, index){
                          return Container(
                            child: ListTile(
                              title: Row(
                                children: [
                                  Text('${listofDocumentSnap[index].get('ders')}',
                                    style: TextStyle(fontSize: 24),),

                                ],
                              ),
                              subtitle: Column(
                                children: [
                                  Text(' '),
                                  Text(' '),
                                  Text(' '),
                                  Text('${listofDocumentSnap[index].get('ders1')}',
                                    style: TextStyle(fontSize: 16),),
                                  Text(' '),
                                  Text('${listofDocumentSnap[index].get('ders2')}',
                                    style: TextStyle(fontSize: 16),),
                                  Text(' '),
                                  Text('${listofDocumentSnap[index].get('ders3')}',
                                    style: TextStyle(fontSize: 16),),
                                  Text(' '),
                                  Text('${listofDocumentSnap[index].get('ders4')}',
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
class AdminDers extends StatefulWidget {
  @override
  _AdminDersState createState() => _AdminDersState();
}

class _AdminDersState extends State<AdminDers> {
  final _firestore=FirebaseFirestore.instance;
  @override
  geri(){
    Navigator.pop(context);
  }
  Widget build(BuildContext context) {
    CollectionReference dersRef = _firestore.collection('ders');
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,
        centerTitle: true,title: Text("Ders Programı",style: TextStyle(color: Colors.black)),),
      body: Container(
        child: Column(
          children:<Widget> [
            StreamBuilder<QuerySnapshot>(
              stream: dersRef.snapshots(),
              builder: (BuildContext context, AsyncSnapshot asyncSnapshot){
                if(asyncSnapshot.hasError){
                  return Center(
                    child: Text('Bir hata oluştu, Tekrar Deneyiniz.'),
                  );
                }
                else{
                  if(asyncSnapshot.hasData){
                    List<DocumentSnapshot> listofDocumentSnap =asyncSnapshot.data.docs;
                    return Flexible(
                      child: ListView.builder(
                        itemCount: listofDocumentSnap.length,
                        itemBuilder: (context, index){
                          return Container(
                            child: ListTile(
                              title: Row(
                                children: [
                                  Text('${listofDocumentSnap[index].get('ders')}',
                                    style: TextStyle(fontSize: 24),),

                                ],
                              ),
                              subtitle: Column(
                                children: [
                                  Text(' '),
                                  Text(' '),
                                  Text(' '),
                                  Text('${listofDocumentSnap[index].get('ders1')}',
                                    style: TextStyle(fontSize: 16),),
                                  Text(' '),
                                  Text('${listofDocumentSnap[index].get('ders2')}',
                                    style: TextStyle(fontSize: 16),),
                                  Text(' '),
                                  Text('${listofDocumentSnap[index].get('ders3')}',
                                    style: TextStyle(fontSize: 16),),
                                  Text(' '),
                                  Text('${listofDocumentSnap[index].get('ders4')}',
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

