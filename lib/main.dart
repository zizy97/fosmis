import 'package:flutter/material.dart';
import 'package:fosmis/pages/home.dart';
import 'package:fosmis/pages/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'fosmis',
      theme: ThemeData(
        primarySwatch: Colors.purple, //backgroundColor: Colors.purple.shade300,
      ),
      home: Login(),
      routes: <String, WidgetBuilder>{
        '/home': (context) => Home(),
      },
    );
  }
}
