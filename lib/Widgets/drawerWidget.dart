import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Drawer build_drawer(String title, {BuildContext context}) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.only(left: 15),
          height: 100,
          child: DrawerHeader(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/bell.png"),
                      fit: BoxFit.fitHeight,
                      alignment: Alignment.centerLeft)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Text("NEWS FEED")],
              )),
        ),
        ListTile(
          title: Text('Settings'),
          leading: Icon(Icons.settings),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).pushNamed('/settings');
          },
        ),
        ListTile(
          title: Text('Feedback'),
          leading: Icon(Icons.feedback),
        ),
        ListTile(
          title: Text('Rate Us'),
          leading: Icon(Icons.rate_review),
        ),
        ListTile(
          title: Text('Share'),
          leading: Icon(Icons.share),
        ),
        ListTile(
          title: Text('Help'),
          leading: Icon(Icons.help),
        )
      ],
    ),
  );
}
