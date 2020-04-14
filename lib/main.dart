import 'package:apil/Screens/SplashScreen.dart';
import 'package:apil/Screens/login_page.dart';
import 'package:apil/Screens/new_user.dart';
import 'package:flutter/material.dart';

void main()=> runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:LoginPage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.deepPurple
      ),
    );
  }
}
