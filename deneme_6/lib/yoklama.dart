import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Yoklama extends StatefulWidget {
  @override
  _YoklamaState createState() => _YoklamaState();
}

class _YoklamaState extends State<Yoklama> {
  final _firestore = FirebaseFirestore.instance;

  geri(){
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    CollectionReference yoklamaRef = FirebaseFirestore.instance.collection('yoklama');
    var mertRef = FirebaseFirestore.instance.collection('yoklama').doc('mert');

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,
        centerTitle: true,title: Text("Yoklama Bilgisi",style: TextStyle(color: Colors.black)),),
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
                                children:[
                                  Text('${listofDocumentSnap[index].get('tarih')}',
                                    style: TextStyle(fontSize: 16),),
                                  Text(': '),
                                  Text('${listofDocumentSnap[index].get('yoklama')}',
                                    style: TextStyle(fontSize: 16),)
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

class AdminYoklama extends StatefulWidget {
  @override
  _AdminYoklamaState createState() => _AdminYoklamaState();
}

class _AdminYoklamaState extends State<AdminYoklama> {
  final _firestore = FirebaseFirestore.instance;
  TextEditingController isimController = TextEditingController();
  TextEditingController soyisimController = TextEditingController();
  TextEditingController yoklamaController = TextEditingController();
  TextEditingController tarihController = TextEditingController();
  geri(){
    Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {

    CollectionReference yoklamaRef = _firestore.collection('yoklama');
    var mertRef = _firestore.collection('yoklama').doc('mert');

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,
        centerTitle: true,title: Text("Yoklama Girişi",style: TextStyle(color: Colors.black)),),
      body: Container(
        child: Column(
          children:<Widget> [
            /* Container(
              child: Text('${yoklamaRef.id}'),
            ),*/
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
                                children:[
                                  Text('${listofDocumentSnap[index].get('tarih')}',
                                    style: TextStyle(fontSize: 16),),
                                  Text(': '),
                                  Text('${listofDocumentSnap[index].get('yoklama')}',
                                    style: TextStyle(fontSize: 16),)
                                ],

                              ),
                              // döküman silme
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

                /*Text('${asynSnapshot.data.data()}')*/
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
                      controller: yoklamaController,
                      decoration: InputDecoration(hintText: 'Yoklama'),
                    ),
                  ],
                ),
              ),
            ),
            RaisedButton(onPressed: geri, child: Text("Geri")),

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
          // Text alanındaki veriden bir map oluşturulması
          Map<String, dynamic> yoklamaData= {'isim': isimController.text,
            'soyisim': soyisimController.text,
            'tarih': tarihController.text,
            'yoklama': yoklamaController.text,
          };

          // Veriyi yazmak istediğimiz referansa ulaşacağız ve ilgili metodu çağıravağız
          await yoklamaRef.doc(isimController.text).set(yoklamaData);

        },),
    );
  }
}