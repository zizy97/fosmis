import 'package:flutter/material.dart';
import 'package:fosmis/model/newsdata.dart';

Widget createCard(NewsDatum newsdata) {
  return Card(
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    color: Colors.white,
    elevation: 10,
    child: Column(
      children: [
        ListTile(
          leading: Icon(Icons.arrow_drop_down_circle),
          title: Text(newsdata.content,
              style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(
            newsdata.date,
            style: TextStyle(color: Colors.black.withOpacity(0.6)),
          ),
        ),
      ],
    ),
  );
}
