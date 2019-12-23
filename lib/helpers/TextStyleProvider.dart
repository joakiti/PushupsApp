import 'package:flutter/material.dart';

class TextStyleProvider {
  static TextStyle italicBold(double fontSize) {
    return TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      fontSize: fontSize,
    );
  }

  static TextStyle bold(double fontSize) {
    return TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: fontSize,
    );
  }

  static TextStyle regular(double fontSize) {
    return TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w100,
      fontSize: fontSize,
    );
  }
}
