import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:fosmis/Widgets/modifyDescription.dart';
import 'package:fosmis/model/newsdata(modified).dart';

// ignore: must_be_immutable
class DataView extends StatelessWidget {
  // ignore: avoid_init_to_null
  String heading, title;
  String desc;
  String link;
  List<Widget> description;

  DataView(Newsdatum newsdata) {
    title = newsdata.title;
    link = newsdata.source[1] != "" ? newsdata.source[1] : link = null;
    var list = newsdata.description.split("\n");
    int count = 0;
    for (var l in list) {
      if (l == "\n") list.removeAt(count);
      count++;
    }
    if (list != null) {
      if (list[0] == "" || heading == null) {
        this.heading = newsdata.title;
      } else {
        this.heading = list[0];
      }
      if (list.length > 1) {
        list.removeAt(0);
      }
      this.description = modifyDesc(list, heading);
      this.desc = list.join("\n");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FOSMIS NEWS UPDATE"),
        backgroundColor: Colors.purple.withOpacity(0.5),
      ),
      body: link == null
          ? SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: description,
              ),
            )
          : Container(
              child: const PDF().cachedFromUrl(
                link,
                placeholder: (double progress) => Center(
                    child: Text(
                  'Openning PDF ' + '$progress %',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
                errorWidget: (dynamic error) =>
                    Center(child: Text(error.toString())),
              ),
            ),
    );
  }
}
