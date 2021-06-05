import 'package:flutter/material.dart';
import 'package:fosmis/Widgets/DrawerWidget.dart';
import 'package:fosmis/model/newsdata.dart';

// ignore: must_be_immutable
class DataView extends StatelessWidget {
  // ignore: avoid_init_to_null
  String heading, title;
  String desc;
  List<String> list;
  String link;

  DataView(NewsDatum newsdata) {
    title = newsdata.title;
    var list = newsdata.description.split("\n");
    if (list != null) {
      if (list[0] == "") {
        this.heading = newsdata.title;
      } else {
        this.heading = list[0];
      }

      list.removeAt(0);
      this.list = list;
      this.desc = list.join("\n");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FOSMIS NEWS UPDATE"),
        backgroundColor: Colors.purple.shade300,
        actions: [
          IconButton(
              icon: Icon(Icons.keyboard_return),
              onPressed: () => Navigator.pop(context))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.only(
                    left: 20.0, top: 20.0, bottom: 20.0, right: 20),
                child: Text(heading != null ? heading : title,
                    style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.red.shade400))),
            Container(
                padding: EdgeInsets.only(left: 18.0, bottom: 20.0, right: 10),
                child: Text(
                  desc != null ? desc : "No descrition",
                  style: TextStyle(fontSize: 16.0),
                ))
          ],
        ),
      ),
      drawer: build_drawer("News Feed"),
    );
  }
}
