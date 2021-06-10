import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

List<Widget> modifyDesc(List<String> list, String heading) {
  var urlPattern =
      r"(https?|ftp)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
  var reg = RegExp(urlPattern, caseSensitive: false);
  List<Widget> data = [];
  data.add(Container(
      padding: EdgeInsets.only(left: 20.0, top: 20.0, bottom: 20.0, right: 20),
      child: Text(heading,
          style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
              color: Colors.red.shade400))));
  for (String row in list) {
    if (row != String.fromCharCode(160)) {
      Iterable<RegExpMatch> url = reg.allMatches(row);
      var flag = false;
      String match = '';
      for (Match m in url) {
        flag = true;
        match = m[0];
      }
      if (url != null && flag) {
        var interdata = row.split(reg);
        data.add(Padding(
          padding: EdgeInsets.only(left: 18.0, right: 10),
          child: Text(interdata[0], style: TextStyle(fontSize: 16.0)),
        ));
        data.add(InkWell(
            onTap: () async {
              if (await canLaunch(match)) {
                await launch(match);
              } else {
                throw 'Could not launch $match';
              }
            },
            child: Padding(
              padding: EdgeInsets.only(left: 18.0, right: 10),
              child: Text(
                match,
                style: TextStyle(fontSize: 16.0, color: Colors.blue.shade600),
              ),
            )));
        data.add(Padding(
          padding: EdgeInsets.only(left: 18.0, right: 10),
          child: Text(interdata[1], style: TextStyle(fontSize: 16.0)),
        ));
      } else {
        data.add(Padding(
          padding: EdgeInsets.only(left: 18.0, right: 10),
          child: Text(row, style: TextStyle(fontSize: 16.0)),
        ));
      }
    }
  }
  return data;
}
