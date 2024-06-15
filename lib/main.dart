import 'package:flutter/material.dart';

import 'Screen/main_Screen.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(fontFamily: 'assets/fonts/Roboto-Light.ttf'),
      debugShowCheckedModeBanner: false,
      home: Whether(),
    ),
  );
}
