import 'package:flutter/material.dart';

mixin MainPageInterface on Widget {
  Widget buildButton(BuildContext context) {
    throw Exception(
        "buildButton not overwritten in:" + this.runtimeType.toString());
  }
}
