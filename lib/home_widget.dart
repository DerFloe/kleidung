import 'package:flutter/material.dart';
import 'overview_widget.dart';
import 'seasons_widget.dart';
import 'placeholder_widget.dart';

class Home extends StatefulWidget {
 @override
 State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    Overview(),
    Seasons(Colors.black),
    PlaceholderWidget(Colors.black),
  ];
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title:new Image.asset('assets/logo-appbar.png', fit: BoxFit.cover)
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        fixedColor: Colors.red,
        unselectedItemColor: Colors.white,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.line_weight),
            title: Text('Items'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            title: Text('Seasons'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
          )
        ]
      )
    );
  }
  void onTabTapped(int index) {
   setState(() {
     _currentIndex = index;
   });
  }
}