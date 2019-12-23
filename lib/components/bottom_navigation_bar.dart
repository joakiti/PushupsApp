import 'package:flutter/material.dart';

class FancyBottomNavigationBar extends StatefulWidget {
  @override
  _FancyBottomNavigationBarState createState() =>
      _FancyBottomNavigationBarState();
}

class _FancyBottomNavigationBarState extends State<FancyBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.red,
      child: Row(children: <Widget>[
        Expanded(
          child: Icon(Icons.build),
        ),
        Expanded(
          child: Icon(Icons.map),
        ),
        Expanded(
          child: Icon(Icons.ac_unit),
        )
      ]),
    );
  }
}
