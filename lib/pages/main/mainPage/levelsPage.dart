import 'package:flutter/material.dart';
import 'package:project_nash_equilibrium/helpers/helpers.dart';
import 'package:project_nash_equilibrium/models/repository.dart';

class LevelsPage extends StatefulWidget {
  LevelsPage(this._repository);

  final Repository _repository;

  @override
  _LevelsPageState createState() => _LevelsPageState();
}

class _LevelsPageState extends State<LevelsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      Column(children: PageHelper.buildHeader(context))
    ]));
  }
}
