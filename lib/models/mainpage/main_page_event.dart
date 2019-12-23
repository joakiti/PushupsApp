import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MainPageEvent extends Equatable {
  final int index;

  MainPageEvent(this.index, [List props = const []])
      : super([index]..addAll(props));

}

class PageChanged extends MainPageEvent {

  PageChanged(int index) : super(index);
}
