import 'package:flutter/material.dart';
import 'package:fosmis/Widgets/drawerWidget.dart';
import 'package:fosmis/themeChange.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    bool isDarked = ThemeBuilder.Of(context).isDarked();
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
              value: isDarked,
              onChanged: (value) {
                ThemeBuilder.Of(context).changeTheme();
                setState(() {
                  isDarked = ThemeBuilder.Of(context).isDarked();
                });
              },
            )),
      ),
      drawer: build_drawer("NEWS FEED"),
    );
  }
}
