import 'package:flutter/material.dart';
import 'package:fosmis/Widgets/DrawerWidget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("FOSMIS NEWS UPDATE"),
          backgroundColor: Colors.purple.shade400,
        ),
        drawer: build_drawer("NEWS FEED"));
  }
}
