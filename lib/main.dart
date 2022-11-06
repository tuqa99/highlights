import "package:flutter/material.dart";
import 'package:highlights/UserScreens/allscreens.dart';
import 'package:highlights/screens/SplashScreen.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MainPage();
  }
}
