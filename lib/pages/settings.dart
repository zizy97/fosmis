import 'package:flutter/material.dart';
import 'package:fosmis/Widgets/drawerWidget.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade300,
        title: Text("Settings"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20),
        alignment: Alignment.center,
        child: ListTile(
            leading: Icon(Icons.colorize_sharp),
            title: Text(
              "Dark Theme",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            trailing: Switch(
              value: false,
              onChanged: (value) {},
            )),
      ),
      drawer: build_drawer("NEWS FEED"),
    );
  }
}
