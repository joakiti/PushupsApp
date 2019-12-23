import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MainPageState extends Equatable {
  final int index;

  MainPageState(this.index, [List props = const []])
      : super([index]..addAll(props));

}

class ChangedPage extends MainPageState {

  ChangedPage(int index) : super(index);
}
