import 'package:flutter/material.dart';
import 'package:fragwall/views/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FragWall',
      theme: ThemeData(
        hoverColor: Color(0xffbb86fc),
        scaffoldBackgroundColor: Color(0xff131719),
        primaryColor: Color(0xff131719),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}

