import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Servis extends StatefulWidget {
  @override
  _ServisState createState() => _ServisState();
}

class _ServisState extends State<Servis> {
  final _firestore = FirebaseFirestore.instance;
  geri(){
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    CollectionReference yoklamaRef = FirebaseFirestore.instance.collection('servis');
    var mertRef = FirebaseFirestore.instance.collection('servis').doc('mert');
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,
        centerTitle: true,title: Text("Servis Bilgisi",style: TextStyle(color: Colors.black)),),
      body: Container(
        child: Column(
          children:<Widget> [
            StreamBuilder<QuerySnapshot>(
              // neyi dinlediğimiz bilgisi, hangi stream
              stream: yoklamaRef.snapshots(),
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
                                  Text('${listofDocumentSnap[index].get('isim')}',
                                    style: TextStyle(fontSize: 24),),
                                  Text(' '),
                                  Text('${listofDocumentSnap[index].get('soyisim')}',
                                    style: TextStyle(fontSize: 24),),
                                ],
                              ),
                              subtitle: Row(
                                children: [
                                  Text('${listofDocumentSnap[index].get('tarih')}',
                                    style: TextStyle(fontSize: 16),),
                                  Text(' '),
                                  Text('${listofDocumentSnap[index].get('saat')}',
                                    style: TextStyle(fontSize: 16),),
                                  Text(' '),
                                  Text('${listofDocumentSnap[index].get('yoklama')}',
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
            RaisedButton(onPressed: geri, child: Text("Geri"))
          ],
        ),
      ),
    );
  }
}

class AdminServis extends StatefulWidget {
  @override
  _AdminServisState createState() => _AdminServisState();
}

class _AdminServisState extends State<AdminServis> {

  final _firestore=FirebaseFirestore.instance;
  TextEditingController isimController = TextEditingController();
  TextEditingController soyisimController = TextEditingController();
  TextEditingController yoklamaController = TextEditingController();
  TextEditingController tarihController = TextEditingController();
  TextEditingController saatController = TextEditingController();
  @override

  geri(){
    Navigator.pop(context);
  }
  Widget build(BuildContext context) {
    CollectionReference servisRef = _firestore.collection('servis');
    var mertRef = _firestore.collection('servis').doc('mert');

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,
        centerTitle: true,title: Text("Servis Bilgisi",style: TextStyle(color: Colors.black)),),
      body: Container(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: servisRef.snapshots(),
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
                          return Card(
                            child: ListTile(
                              title: Row(
                                children: [
                                  Text('${listofDocumentSnap[index].get('isim')}',
                                    style: TextStyle(fontSize: 24),),
                                  Text(' '),
                                  Text('${listofDocumentSnap[index].get('soyisim')}',
                                    style: TextStyle(fontSize: 24),),
                                ],
                              ),
                              subtitle: Row(
                                children: [
                                  Text('${listofDocumentSnap[index].get('tarih')}',
                                    style: TextStyle(fontSize: 16),),
                                  Text(' '),
                                  Text('${listofDocumentSnap[index].get('saat')}',
                                    style: TextStyle(fontSize: 16),),
                                  Text(' '),
                                  Text('${listofDocumentSnap[index].get('yoklama')}',
                                    style: TextStyle(fontSize: 16),),
                                ],
                              ),
                              trailing: IconButton(icon: Icon(Icons.delete),
                                onPressed: () async{ await listofDocumentSnap[index].reference.delete();},),

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 40),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller:  isimController,
                      decoration: InputDecoration(hintText: 'İsim'),
                    ),
                    TextFormField(
                      controller: soyisimController,
                      decoration: InputDecoration(hintText: 'Soyisim'),
                    ),
                    TextFormField(
                      controller: tarihController,
                      decoration: InputDecoration(hintText: 'Tarih'),
                    ),
                    TextFormField(
                      controller: saatController,
                      decoration: InputDecoration(hintText: 'Saat'),
                    ),
                    TextFormField(
                      controller: yoklamaController,
                      decoration: InputDecoration(hintText: 'Yoklama'),
                    ),
                  ],
                ),
              ),
            ),
            RaisedButton(onPressed: geri, child: Text("Geri"))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('Ekle'),
        onPressed: () async {
          print(isimController.text);
          print(soyisimController.text);
          print(tarihController.text);
          print(yoklamaController.text);
          print(saatController.text);
          // Text alanındaki veriden bir map oluşturulması
          Map<String, dynamic> yoklamaData= {'isim': isimController.text,
            'soyisim': soyisimController.text,
            'tarih': tarihController.text,
            'yoklama': yoklamaController.text,
            'saat': saatController.text,
          };

          // Veriyi yazmak istediğimiz referansa ulaşacağız ve ilgili metodu çağıravağız
          await servisRef.doc(isimController.text).set(yoklamaData);

        },),
    );
  }
}