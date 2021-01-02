import 'package:flutter/material.dart';
import 'package:project_nash_equilibrium/interfaces/MainPageInterface.dart';

class HistoryPage extends StatefulWidget implements MainPageInterface {
  @override
  _HistoryPageState createState() => _HistoryPageState();

  @override
  Widget buildButton(BuildContext context) {
    // TODO: implement buildButton
    return Container();
  }
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      child: Text("This page is currently under development. \n\nLike this app on the app or google play store for more updates!"),
    ));
  }
}
