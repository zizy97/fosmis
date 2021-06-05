// import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:fosmis/model/newsdata.dart';
import 'package:intl/intl.dart';
// import 'package:fosmis/pages/dataview.dart';
// import 'package:fosmis/pages/home.dart';

Widget createCard(
    NewsDatum newsdata, BuildContext context, VoidCallback opencontainer) {
  //DateTime date = DateTime.parse(newsdata.date);
  // DateFormat df = DateFormat('dd-MM-yyyy hh:mm');
  // String f_date = df.format(date);

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
              leading: Icon(newsdata.recent
                  ? Icons.notifications_active_outlined
                  : Icons.circle_notifications),
              title: Text(newsdata.title,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(
                newsdata.date,
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
