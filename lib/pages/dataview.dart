import 'package:flutter/material.dart';
import 'package:fosmis/model/newsdata.dart';

// ignore: must_be_immutable
class DataView extends StatelessWidget {
  // ignore: avoid_init_to_null
  NewsDatum newsdata = null;
  DataView(NewsDatum newsdata) {
    this.newsdata = newsdata;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Text(newsdata.description),
      ),
    );
  }
}
