import 'package:flutter/material.dart';

class Iletisim extends StatefulWidget {
  @override
  _IletisimState createState() => _IletisimState();
}

class _IletisimState extends State<Iletisim> {
  geri(){
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,
        centerTitle: true,title: Text("İletisim",style: TextStyle(color: Colors.black)),),
      body: Container(
        child: Column(
          children:<Widget> [
            Container(
              child: Text("sumeyyevarmis@hotmail.com",style: TextStyle(fontSize: 20,color: Colors.black),),
            ),
            RaisedButton(onPressed: geri, child: Text("Geri"))
          ],
        ),
      ),
    );
  }
}

