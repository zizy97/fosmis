import 'package:flutter/material.dart';
import 'package:fosmis/Services/apimanger.dart';
import 'package:fosmis/Widgets/DrawerWidget.dart';
import 'package:fosmis/Widgets/createCard.dart';
import 'package:fosmis/model/newsdata.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // ignore: unused_field
  Future<NewsData> _newsModel;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    _newsModel = APIManager().getNotify();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("FOSMIS NEWS UPDATE"),
          backgroundColor: Colors.purple.shade300,
        ),
        body: Container(
          child: FutureBuilder<NewsData>(
            future: _newsModel,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.newsData.length,
                  itemBuilder: (context, index) {
                    var notification = snapshot.data.newsData;
                    return Container(
                        height: 100.0,
                        color: Colors.purple.shade400,
                        child: createCard(notification[index]));
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
        drawer: build_drawer("NEWS FEED"));
  }
}
