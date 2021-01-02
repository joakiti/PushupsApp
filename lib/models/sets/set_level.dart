import 'package:flutter/material.dart';
import 'package:project_nash_equilibrium/models/sets/sets.dart';

class SetLevel {
  List<Sets> sets;
  int level;
  int day = 1;

  SetLevel({@required this.sets, @required this.level});
}