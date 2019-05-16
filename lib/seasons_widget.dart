import 'package:flutter/material.dart';

class Seasons extends StatelessWidget {
  final Color color;

  Seasons(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: new Text("hi"),
    );
  }
}
