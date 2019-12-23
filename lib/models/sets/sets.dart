import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Sets extends Equatable {
  Sets({
    @required this.set,
    @required this.level,
  })  : total = set.reduce((a, b) => a + b),
        super([set, level]);

  final List<int> set;
  final int total;
  final int level;
}
