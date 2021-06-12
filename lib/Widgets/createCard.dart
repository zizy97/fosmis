import 'package:flutter/material.dart';
import 'package:fosmis/model/newsdata.dart';
import 'package:google_fonts/google_fonts.dart';

Widget createCard(
    NewsDatum newsdata, BuildContext context, VoidCallback opencontainer) {
  final TextStyle headline4 = Theme.of(context).textTheme.headline4;
  return GestureDetector(
    onTap: opencontainer,
    child: Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 10,
      child: Container(
        child: Column(
          children: [
            ListTile(
              leading: Icon(newsdata.recent
                  ? Icons.notifications_active_outlined
                  : Icons.circle_notifications),
              title: Text(newsdata.title,
                  style: GoogleFonts.lato(
                      fontStyle: FontStyle.italic,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              subtitle: Text(
                newsdata.date,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
