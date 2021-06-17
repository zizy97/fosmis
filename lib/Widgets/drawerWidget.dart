import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

// ignore: non_constant_identifier_names
Drawer build_drawer(String title, {BuildContext context}) {
  final userdata = GetStorage();
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        Container(
          color: Colors.purple.withOpacity(0.5),
          padding: EdgeInsets.only(top: 40),
          height: 150,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Container(
              height: 75,
              child: Image.asset("images/bell.png"),
            ),
            Text(
              "NEWS FEED",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            )
          ]),
        ),
        ListTile(
          title: Text(
            'Settings',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          leading: Icon(Icons.settings),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).pushNamed('/settings');
          },
        ),
        ListTile(
          title: Text(
            'Feedback',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          leading: Icon(Icons.feedback),
          onTap: () => createNote(context, "FEEDBACK", "Not Implemented Yet"),
        ),
        ListTile(
          title: Text(
            'Rate Us',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          leading: Icon(Icons.rate_review),
          onTap: () => createNote(context, "Rate Us", "Not Implemented Yet"),
        ),
        ListTile(
          title: Text(
            'Share',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          leading: Icon(Icons.share),
          onTap: () => createNote(context, "Share", "Not Implemented Yet"),
        ),
        ListTile(
          title: Text(
            'Help',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          leading: Icon(Icons.help),
          onTap: () => createNote(context, "Help", "Not Implemented Yet"),
        ),
        ListTile(
            title: Text(
              'LogOut',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            leading: Icon(Icons.logout),
            onTap: () {
              userdata.write('isLogged', false);
              userdata.remove('uname');
              userdata.remove('upwd');
              Get.offAllNamed('/login');
            }),
      ],
    ),
  );
}

Future<dynamic> createNote(BuildContext context, String title, String note) {
  return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(note)],
            ),
          ),
        );
      });
}
