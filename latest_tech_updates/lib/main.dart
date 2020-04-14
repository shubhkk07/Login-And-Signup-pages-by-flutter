import 'package:flutter/material.dart';
import 'package:latest_tech_updates/homepage.dart';
import 'package:latest_tech_updates/splashScreen.dart';

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
