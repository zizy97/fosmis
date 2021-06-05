// import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:fosmis/model/newsdata.dart';
// import 'package:fosmis/pages/dataview.dart';
// import 'package:fosmis/pages/home.dart';

Widget createCard(
    NewsDatum newsdata, BuildContext context, VoidCallback opencontainer) {
  String date = newsdata.date.split("/")[0];
  return GestureDetector(
    onTap: opencontainer,
    child: Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Colors.white,
      elevation: 10,
      child: Container(
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.arrow_drop_down_circle),
              title: Text(newsdata.title,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(
                date,
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
