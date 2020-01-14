import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Sets extends Equatable {
  Sets({
    @required this.set,
  })  : total = set.reduce((a, b) => a + b);

  final List<int> set;
  final int total;
}
