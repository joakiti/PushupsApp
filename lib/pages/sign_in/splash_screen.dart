
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:             Image.asset(
        "assets/pushup_man.jpg",
        height: ui.window.physicalSize.height,
        fit: BoxFit.fitHeight,
      ),
    );
  }
}