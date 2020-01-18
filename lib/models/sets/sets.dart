import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Sets extends Equatable {
  Sets({
    @required this.set,
  })  : total = set.reduce((a, b) => a + b);

  final List<int> set;
  final int total;

  @override
  String toString() {
    String withManyDashes = set.fold<String>(
        "", (empty, next) => empty.toString() + next.toString() + " - ");
    return withManyDashes.substring(
        0, ((set.length - 1) * 3 + set.length) + 1);
  }
}
