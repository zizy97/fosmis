import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:fosmis/Widgets/DrawerWidget.dart';
import 'package:fosmis/model/newsdata.dart';

// ignore: must_be_immutable
class DataView extends StatelessWidget {
  // ignore: avoid_init_to_null
  String heading, title;
  String desc;
  String link;
  List<Widget> description;

  DataView(NewsDatum newsdata) {
    title = newsdata.title;
    newsdata.source != null ? link = newsdata.source[1] : link = null;
    var list = newsdata.description.split("\n");
    int count = 0;
    for (var l in list) {
      if (l == "\n") list.removeAt(count);
      count++;
    }
    if (list != null) {
      if (list[0] == "") {
        this.heading = newsdata.title;
      } else {
        this.heading = list[0];
      }

      list.removeAt(0);
      this.description = modifyDesc(list);
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
      drawer: build_drawer("News Feed"),
    );
  }

  List<Widget> modifyDesc(List<String> list) {
    var urlPattern =
        r"(https?|ftp)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
    var reg = RegExp(urlPattern, caseSensitive: false);
    List<Widget> data = [];
    data.add(Container(
        padding:
            EdgeInsets.only(left: 20.0, top: 20.0, bottom: 20.0, right: 20),
        child: Text(heading != null ? heading : title,
            style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade400))));
    for (var row in list) {
      print("Row " + row);
      var url = reg.allMatches(row);
      if (url != null) {
        var interdata = row.split(reg);
        print(interdata);
        data.add(Text(interdata[0]));
        //data.add(Text(interdata[1]));
      } else {
        data.add(Text(row));
      }
    }
    return data;
  }
}
// children: [
//                   Container(
//                       padding: EdgeInsets.only(
//                           left: 20.0, top: 20.0, bottom: 20.0, right: 20),
//                       child: Text(heading != null ? heading : title,
//                           style: TextStyle(
//                               fontSize: 17.0,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.red.shade400))),
//                   Container(
//                       padding:
//                           EdgeInsets.only(left: 18.0, bottom: 20.0, right: 10),
//                       child: Text(
//                         desc != null ? desc : "No descrition",
//                         style: TextStyle(fontSize: 16.0),
//                       ))
//                 ],
