import 'package:flutter/material.dart';
import 'package:fosmis/model/newsdata.dart';
import 'package:google_fonts/google_fonts.dart';

Widget createCard(
    NewsDatum newsdata, BuildContext context, VoidCallback opencontainer) {
  return GestureDetector(
    onTap: opencontainer,
    child: Ink(
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.2),
          borderRadius: BorderRadius.circular(4.0)),
      child: ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(newsdata.recent
                ? Icons.notifications_active_outlined
                : Icons.circle_notifications),
          ],
        ),
        title: Text(newsdata.title,
            maxLines: 2,
            style: GoogleFonts.lato(
                color: Colors.black,
                fontStyle: FontStyle.italic,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        subtitle: Text(
          newsdata.date,
          style: TextStyle(color: Colors.black.withOpacity(.8)),
        ),
      ),
    ),
  );
}
