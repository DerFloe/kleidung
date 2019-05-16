import 'package:flutter/material.dart';

class Home extends StatefulWidget {
 @override
 State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title:new Image.asset('assets/logo-appbar.png', fit: BoxFit.cover)
      ),
    );
  }
}